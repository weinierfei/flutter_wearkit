package com.topstep.flutter_wearkit

import android.Manifest
import android.annotation.SuppressLint
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.content.pm.PackageManager
import androidx.core.content.ContextCompat
import androidx.core.net.toUri
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import com.shenju.cameracapturer.FrameData
import com.shenju.cameracapturer.OSIJni
import com.topstep.fitcloud.sdk.v2.FcSDK
import com.topstep.fitcloud.sdk.v2.model.config.FcDeviceInfo
import com.topstep.flutter_wearkit.config.ExerciseGoal
import com.topstep.flutter_wearkit.helper.DeviceHelper
import com.topstep.flutter_wearkit.helper.RemindHelper
import com.topstep.flutter_wearkit.helper.WeatherHelper.weatherCode2Describe
import com.topstep.flutter_wearkit.log.LogUtils
import com.topstep.flutter_wearkit.model.DeviceAbilityEntity
import com.topstep.flutter_wearkit.model.DeviceHealthAbilityEntity
import com.topstep.flutter_wearkit.model.DeviceInfoEntity
import com.topstep.flutter_wearkit.model.DialStyleConstraintDto
import com.topstep.flutter_wearkit.model.ProgressResultBean
import com.topstep.flutter_wearkit.model.RemindBean
import com.topstep.flutter_wearkit.model.StyleDto
import com.topstep.flutter_wearkit.model.WKResourcesDto
import com.topstep.flutter_wearkit.model.WeatherInfo
import com.topstep.flutter_wearkit.model.WomenHealthConfigBean
import com.topstep.wearkit.apis.WKWearKit
import com.topstep.wearkit.apis.ability.dial.WKDialStyleAbility
import com.topstep.wearkit.apis.ability.dial.WKDialStyleAbility.CreateInputCompat
import com.topstep.wearkit.apis.model.WKAlarm
import com.topstep.wearkit.apis.model.WKContacts
import com.topstep.wearkit.apis.model.WKContactsCommon
import com.topstep.wearkit.apis.model.WKContactsEmergency
import com.topstep.wearkit.apis.model.WKRemind
import com.topstep.wearkit.apis.model.config.WKActivityGoalConfig
import com.topstep.wearkit.apis.model.config.WKBloodOxygenMonitorConfig
import com.topstep.wearkit.apis.model.config.WKBloodPressureMonitorConfig
import com.topstep.wearkit.apis.model.config.WKFunctionConfig.Flag
import com.topstep.wearkit.apis.model.config.WKHeartRateAlarmConfig
import com.topstep.wearkit.apis.model.config.WKHeartRateMonitorConfig
import com.topstep.wearkit.apis.model.config.WKPressureMonitorConfig
import com.topstep.wearkit.apis.model.config.WKRaiseWakeupConfig
import com.topstep.wearkit.apis.model.config.WKUnitConfig
import com.topstep.wearkit.apis.model.config.WKWomenHealthConfig
import com.topstep.wearkit.apis.model.config.toBuilder
import com.topstep.wearkit.apis.model.core.WKAuthMode
import com.topstep.wearkit.apis.model.core.WKDeviceType
import com.topstep.wearkit.apis.model.data.WKSleepAlgorithm
import com.topstep.wearkit.apis.model.data.WKSleepItem
import com.topstep.wearkit.apis.model.dial.WKDialStyleConstraint
import com.topstep.wearkit.apis.model.dial.WKDialStyleConstraint.Style
import com.topstep.wearkit.apis.model.file.WKResources
import com.topstep.wearkit.apis.model.weather.WKWeatherDay
import com.topstep.wearkit.apis.model.weather.WKWeatherHour
import com.topstep.wearkit.apis.model.weather.WKWeatherToday
import com.topstep.wearkit.apis.util.WKSleepHelper
import com.topstep.flutter_wearkit.config.ConnectorState
import com.topstep.wearkit.base.utils.BondHelper
import com.topstep.wearkit.base.utils.FixedHashMap
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.schedulers.Schedulers
import java.text.SimpleDateFormat
import java.util.Date
import java.util.Locale
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.combine
import kotlinx.coroutines.flow.distinctUntilChanged
import kotlinx.coroutines.flow.stateIn
import kotlinx.coroutines.launch
import kotlinx.coroutines.rx3.asFlow
import timber.log.Timber

object DeviceManager {

    lateinit var wearkit: WKWearKit
    val gson = Gson()
    val osiJni: OSIJni = OSIJni()
    lateinit var flowState: StateFlow<ConnectorState>
    
    /**
     * 应用级别的 CoroutineScope，不依赖于任何 Flutter 引擎
     * 使用 SupervisorJob 确保子协程的失败不会影响其他协程
     */
    private val applicationScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)
    
    // 标记是否已初始化
    private var isInitialized = false

    fun init(wearkit: WKWearKit) {
        this.wearkit = wearkit
        initFlowState()
        isInitialized = true
    }
    
    /**
     * 检查是否已初始化
     */
    fun isReady(): Boolean = isInitialized
    
    private fun initFlowState() {
        flowState = combine(
            wearkit.observeAdapterEnabled(true).asFlow(),
            wearkit.connector.observeConnectorState().map { DeviceHelper.simpleState(it) }
                .startWithItem(ConnectorState.DISCONNECTED).asFlow()
                .distinctUntilChanged()) { isAdapterEnabled, connectorState ->
            DeviceHelper.combineState(isAdapterEnabled, connectorState)
        }.stateIn(applicationScope, SharingStarted.Eagerly, ConnectorState.DISCONNECTED)
    }

    fun connectDevice(
        type: WKDeviceType,
        authType: Int,
        authCode: String?,
        address: String,
        userId: String,
        sex: Boolean,
        age: Int,
        height: Float,
        weight: Float,
    ) {
        wearkit.connector.connect(
            type,
            address,
            if (authType == 0) WKAuthMode.BIND else WKAuthMode.LOGIN,
            authCode,
            userId,
            sex,
            age,
            height,
            weight
        )
    }

    fun updateUserInfo(
        sex: Boolean,
        age: Int,
        height: Float,
        weight: Float,
    ) {
        wearkit.connector.setUserInfo(sex, age, height, weight).onErrorComplete().subscribe()
    }

    fun unbind(context: Context, address: String?) {
        wearkit.connector.clear(true).onErrorComplete().subscribe()
        removeSystemBond(context, address)
    }

    fun cancelBind(context: Context, address: String?) {
        wearkit.connector.close()
        removeSystemBond(context, address)
    }

    fun disconnectDevice() {
        wearkit.connector.disconnect()
    }

    fun reconnectDevice() {
        wearkit.connector.reconnect()
    }

    fun cancelConnectDevice() {
        wearkit.connector.close()
    }

    fun getDeviceInfo(): String {
        val deviceInfo = wearkit.deviceAbility.getDeviceInfo()
        return gson.toJson(
            DeviceInfoEntity(
                deviceInfo.type.name,
                deviceInfo.model,
                deviceInfo.model,
                deviceInfo.version,
                deviceInfo.shape
            )
        )
    }

    fun resetDevice() {
        wearkit.deviceAbility.reset().onErrorComplete().subscribe()
    }

    fun shutdown() {
        wearkit.deviceAbility.shutdown().onErrorComplete().subscribe()
    }

    fun getDeviceBattery(): String {
        val battery = wearkit.batteryAbility.requestBattery().blockingGet()
        return gson.toJson(battery)
    }

    fun getDeviceAbility(): String {
        // w30 紧急联系人
        val isSupportEmergencyContact =
            wearkit.contactsAbility.compat.getContactsCommonMaxNumber() <= 0 && wearkit.contactsAbility.compat.getContactsEmergencyMaxNumber() > 0
        val entity = DeviceAbilityEntity(
            isSupportContact = wearkit.contactsAbility.compat.getContactsCommonMaxNumber() > 0,
            isSupportWeather = wearkit.weatherAbility.compat.isSupport(),
            isSupportMusic = wearkit.musicAbility.compat.isSupport() && wearkit.musicAbility.compat.isSupportRequest(),
            isSupportBusinessCard = wearkit.businessCardAbility.compat.isSupport(),
            isSupportPaymentCode = wearkit.paymentCodeAbility.compat.isSupport(),
            isSupportSportPush = wearkit.sportUIAbility.compat.isSupport(),
            isSupportRemind = wearkit.remindAbility.compat.isSupport(),
            isSupportEBook = wearkit.eBookAbility.compat.isSupport(),
            isSupportAlbum = wearkit.albumAbility.compat.isSupport(),
            isSupportAlarm = wearkit.alarmAbility.compat.getAlarmMaxNumber() > 0,
            isSupportEmergencyContact = isSupportEmergencyContact,
        )

        return gson.toJson(entity)
    }

    fun getRaiseWakeupConfig(): String {
        return gson.toJson(wearkit.raiseWakeupAbility.getConfig())
    }

    fun isSupportWakeupPeriod(): Boolean {
        return wearkit.raiseWakeupAbility.compat.isSupportPeriod()
    }

    fun updateRaiseWakeupConfig(json: String?) {
        if (json == null) return
        val newConfig = gson.fromJson(json, WKRaiseWakeupConfig::class.java)
        wearkit.raiseWakeupAbility.setConfig(newConfig).onErrorComplete().subscribe()
    }

    fun isEnabledFunctionAbility(@Flag flag: Int): Boolean {
        return wearkit.functionAbility.getConfig().isFlagEnabled(flag)
    }

    fun updateFunctionAbility(@Flag flag: Int, isEnabled: Boolean) {
        val config =
            wearkit.functionAbility.getConfig().toBuilder().setFlagEnabled(flag, isEnabled).create()
        wearkit.functionAbility.setConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportWeather(): Boolean {
        return wearkit.weatherAbility.compat.isSupport()
    }

    fun sendWeather(weatherJson: String?) {
        if (weatherJson == null) return
        Timber.tag("weatherJson").i("sendWeather:%s", weatherJson)
        val weather = gson.fromJson(weatherJson, WeatherInfo::class.java)
        val deviceType = wearkit.deviceAbility.getDeviceInfo().type

        val tempMin = if (weather.min == 0) weather.tmp else weather.min
        val tempMax = if (weather.max == 0) weather.tmp else weather.max
        val today = WKWeatherToday(
            timestampSeconds = if (WKDeviceType.SHEN_JU == deviceType) weather.time
            else weather.time / 1000,
            tempMin = tempMin,
            tempMax = tempMax,
            code = weatherCode2Describe(weather.code),
            tempCurrent = weather.tmp,
            windSpeed = weather.windSpeed.toFloat(),
            windScale = weather.windScale,
            visibility = weather.vis / 100.toFloat()
        ).apply { type = null }

        val format = SimpleDateFormat("yyyy-MM-dd", Locale.US)
        val forecasts = weather.forecasts?.map {
            try {
                WKWeatherDay(
                    timestampSeconds = if (WKDeviceType.SHEN_JU == deviceType) format.parse(it.time).time
                    else format.parse(it.time).time / 1000,
                    tempMin = it.min,
                    tempMax = it.max,
                    code = weatherCode2Describe(it.code),
                ).apply { type = null }
            } catch (e: Exception) {
                Timber.w(e)
                null
            }
        }
        val futureHours = weather.futureHours?.map {
            try {
                WKWeatherHour(
                    timestampSeconds = it.timestampSeconds,
                    code = weatherCode2Describe(it.code),
                    tempCurrent = it.tempCurrent,
                    windScale = it.windScale,
                    ultraviolet = 0,
                    visibility = it.visibility,
                ).apply { type = null }
            } catch (e: Exception) {
                Timber.w(e)
                null
            }
        }
        Timber.i("设置天气:%s%s%s%s", weather, today, forecasts, futureHours)
        wearkit.weatherAbility.setWeather(weather.locality ?: "", today, forecasts, futureHours)
            .onErrorComplete().subscribe()
    }

    fun setCameraStatus(message: Int) {
        wearkit.cameraAbility.sendCameraMessage(message).onErrorComplete().subscribe()
    }

    fun isSupportCameraPreview(): Boolean {
        val isSupportPreview = wearkit.cameraAbility.compat.isSupportPreview()
        if (isSupportPreview) {
            val size = wearkit.cameraAbility.compat.getPreviewSize()
            osiJni.let { synchronized(it) { it.initEncoder(size.x, size.y, 350, 20, 1) } }
        }
        return isSupportPreview
    }

    fun getCameraPreviewSize(): HashMap<Int, Int> {
        val size = wearkit.cameraAbility.compat.getPreviewSize()
        val map = HashMap<Int, Int>()
        map[size.x] = size.y
        return map
    }

    fun startCameraPreview(fps: Int) {
        wearkit.cameraAbility.startPreview(fps).onErrorComplete().subscribe()
    }

    fun stopCameraPreview() {
        osiJni.let { synchronized(it) { it.closeEncoder() } }
    }

    fun updateCameraPreview(call: MethodCall) {
        val width = call.argument<Int>("width")!!
        val height = call.argument<Int>("height")!!
        val rotationDegrees = call.argument<Int>("rotationDegrees")!!
        val isFrontCamera = call.argument<Boolean>("isFrontCamera")!!
        val yBytes = call.argument<ByteArray>("yBytes")!!
        val uBytes = call.argument<ByteArray>("uBytes")!!
        val vBytes = call.argument<ByteArray?>("vBytes")

        osiJni.let {
            synchronized(osiJni) {
                val h264Data = FrameData()
                val ret = osiJni.runEncoder(
                    yBytes, uBytes, vBytes, width, height, rotationDegrees, h264Data, isFrontCamera
                )
                if (ret == 0) {
                    wearkit.cameraAbility.updatePreview(h264Data.frameType, h264Data.frameData)
                        .onErrorComplete().doOnError { Timber.w(it) }.subscribe()
                }
            }
        }
    }

    fun findWatch() {
        wearkit.finderAbility.findWatch().onErrorComplete().subscribe()
    }

    fun stopFindWatch() {
        wearkit.finderAbility.stopFindWatch().onErrorComplete().subscribe()
    }

    fun setTelephonyConfig(telephonyEnabled: Boolean) {
        wearkit.notificationAbility.setTelephonyConfig(telephonyEnabled).onErrorComplete()
            .subscribe()
    }

    fun isSupportAppNotification(pck: String): Boolean {
        return wearkit.notificationAbility.compat.isSupportAppNotification(pck)
    }

    fun getMaxAlarmCount(): Int {
        return wearkit.alarmAbility.compat.getAlarmMaxNumber()
    }

    fun getLabelMaxBytes(): Int {
        return wearkit.alarmAbility.compat.getLabelMaxBytes()
    }

    fun getAlarmList(): String {
        val list = wearkit.alarmAbility.requestAlarms().blockingGet()
        return gson.toJson(list)
    }

    fun setAlarms(alarmList: String?) {
        val list =
            gson.fromJson<List<WKAlarm>>(alarmList, object : TypeToken<List<WKAlarm>>() {}.type)
        wearkit.alarmAbility.setAlarms(list).onErrorComplete().subscribe()
    }

    fun getContactsCommonMaxNumber(): Int {
        return wearkit.contactsAbility.compat.getContactsCommonMaxNumber()
    }

    fun getContactsEmergencyMaxNumber(): Int {
        return wearkit.contactsAbility.compat.getContactsEmergencyMaxNumber()
    }

    fun requestContactsCommon(): String {
        val commonContact = wearkit.contactsAbility.requestContactsCommon().blockingGet().items
        return if (commonContact.isNullOrEmpty()) {
            ""
        } else {
            gson.toJson(commonContact)
        }
    }

    fun setContactsCommon(commonContact: String) {
        val commonContactList = gson.fromJson<List<WKContacts>>(
            commonContact, object : TypeToken<List<WKContacts>>() {}.type
        )
        wearkit.contactsAbility.setContactsCommon(WKContactsCommon(commonContactList))
            .onErrorComplete().subscribe()
    }

    fun requestContactsEmergency(): String {
        val emergency = wearkit.contactsAbility.requestContactsEmergency().blockingGet().items
        return if (emergency.isNullOrEmpty() || (emergency.size == 1 && emergency[0].number == "" && emergency[0].name == "")) {
            ""
        } else {
            gson.toJson(emergency)
        }
    }

    fun setEmergencyContacts(emergencyContact: String) {
        val emergencyContactList = gson.fromJson<List<WKContacts>>(
            emergencyContact, object : TypeToken<List<WKContacts>>() {}.type
        )
        wearkit.contactsAbility.setContactsEmergency(
            WKContactsEmergency(
                isEnabled = true, emergencyContactList
            )
        ).onErrorComplete().subscribe()
    }

    fun getActivityAttributes(): String {
        val configList = wearkit.activityAbility.compat.getActivityAttributes()
        return gson.toJson(configList)
    }

    fun sleepCalculate(json: String, algorithm: Int): String {
        val list = gson.fromJson<List<WKSleepItem>>(
            json, object : TypeToken<List<WKSleepItem>>() {}.type
        )
        val newList = WKSleepHelper.calculate(list[0].belong, list, getWKAlgorithm(algorithm))
        return gson.toJson(newList)
    }

    fun isSupportDial(): Boolean {
        return wearkit.dialAbility.compat.isSupport()
    }

    fun setAsMainDial(dialId: String) {
        wearkit.dialAbility.select(dialId).onErrorComplete().subscribe()
    }

    fun requestDials(): String {
        val dialList = wearkit.dialAbility.requestDials().blockingGet()
        return if (dialList.isEmpty()) {
            ""
        } else {
            gson.toJson(dialList)
        }
    }

    fun isSyncing(): Boolean {
        return wearkit.deviceAbility.isSyncing()
    }

    private fun getWKAlgorithm(id: Int): WKSleepAlgorithm {
        when (id) {
            WKSleepAlgorithm.FITCLOUD_DEFAULT.id -> return WKSleepAlgorithm.FITCLOUD_DEFAULT
            WKSleepAlgorithm.FITCLOUD_NAP.id -> return WKSleepAlgorithm.FITCLOUD_NAP
            WKSleepAlgorithm.FLYWEAR_DEFAULT.id -> return WKSleepAlgorithm.FLYWEAR_DEFAULT
            WKSleepAlgorithm.FLYWEAR_ORAIMO.id -> return WKSleepAlgorithm.FLYWEAR_ORAIMO
            WKSleepAlgorithm.SHENJU_DEFAULT.id -> return WKSleepAlgorithm.SHENJU_DEFAULT
        }
        return WKSleepAlgorithm.FITCLOUD_DEFAULT
    }

    fun getMonitorConfig(): String {
        val config = wearkit.heartRateAbility.getMonitorConfig()
        return gson.toJson(config)
    }

    fun setMonitorConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKHeartRateMonitorConfig::class.java)
        wearkit.heartRateAbility.setMonitorConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportTimePeriod(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportTimePeriod()
    }

    fun isSupportTimeInterval(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportTimeInterval()
    }

    fun isSupportAlarmConfig(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportAlarmConfig()
    }

    fun getHeartAlarmConfig(): String {
        val config = wearkit.heartRateAbility.getAlarmConfig()
        return gson.toJson(config)
    }

    fun setHeartAlarmConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKHeartRateAlarmConfig::class.java)
        wearkit.heartRateAbility.setAlarmConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportMaxThreshold(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportMaxThreshold()
    }

    fun isSupportMinValueConfig(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportMinValueConfig()
    }

    fun getBOMonitorConfig(): String {
        val config = wearkit.bloodOxygenAbility.getMonitorConfig()
        return gson.toJson(config)
    }

    fun setBOMonitorConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKBloodOxygenMonitorConfig::class.java)
        wearkit.bloodOxygenAbility.setMonitorConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportBOTimePeriod(): Boolean {
        return wearkit.bloodOxygenAbility.compat.isSupportTimePeriod()
    }

    fun isSupportBOTimeInterval(): Boolean {
        return wearkit.bloodOxygenAbility.compat.isSupportTimeInterval()
    }

    fun getBPMonitorConfig(): String {
        val config = wearkit.bloodPressureAbility.getMonitorConfig()
        return gson.toJson(config)
    }

    fun setBPMonitorConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKBloodPressureMonitorConfig::class.java)
        wearkit.bloodPressureAbility.setMonitorConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportBPTimePeriod(): Boolean {
        return wearkit.bloodPressureAbility.compat.isSupportTimePeriod()
    }

    fun isSupportBPTimeInterval(): Boolean {
        return wearkit.bloodPressureAbility.compat.isSupportTimeInterval()
    }

    fun getPressureMonitorConfig(): String {
        val config = wearkit.pressureAbility.getMonitorConfig()
        return gson.toJson(config)
    }

    fun setPressureMonitorConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKPressureMonitorConfig::class.java)
        wearkit.pressureAbility.setMonitorConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportPressureTimePeriod(): Boolean {
        return wearkit.pressureAbility.compat.isSupportTimePeriod()
    }

    fun isSupportPressureTimeInterval(): Boolean {
        return wearkit.pressureAbility.compat.isSupportTimeInterval()
    }

    fun isIsolateMonitorConfig(): Boolean {
        val rawSDK = wearkit.getRawSDK()
        if (rawSDK is FcSDK) {
            return rawSDK.connector.configFeature().getDeviceInfo()
                .isSupportFeature(FcDeviceInfo.Feature.ISOLATE_MONITOR_CONFIG)
        }
        return true
    }

    fun getGoalConfig(): String {
        val config = wearkit.activityAbility.getGoalConfig()
        val bean = ExerciseGoal(
            steps = config.steps,
            distance = (config.distance / 1000).toFloat(),
            calories = config.calories.toInt(),
            duration = config.duration / 60,
            number = config.number,
            sportDuration = config.sportDuration / 60,
            disabledReminds = config.disabledReminds,
        )
        return gson.toJson(bean)
    }

    fun syncGoalConfig(configJson: String) {
        val config = gson.fromJson(configJson, ExerciseGoal::class.java)
        wearkit.activityAbility.syncGoalConfig(config.toWKGoal()).ignoreElement().onErrorComplete()
            .subscribe()
    }

    fun isSupportDisabledReminds(): Boolean {
        return wearkit.activityAbility.compat.isSupportDisabledReminds()
    }

    fun getDeviceHealthAbility(): String {
        val entity = DeviceHealthAbilityEntity(
            isSleepAbility = true,
            isHeartRateAbility = wearkit.heartRateAbility.compat.isSupport(),
            isBloodOxygenAbility = wearkit.bloodOxygenAbility.compat.isSupport(),
            isBloodPressureAbility = wearkit.bloodPressureAbility.compat.isSupport(),
            isPressureAbility = wearkit.pressureAbility.compat.isSupport(),
            isWeightAbility = true,
            isTemperatureAbility = wearkit.temperatureAbility.compat.isSupport(),
            isWomenHealthAbility = false
        )
        return gson.toJson(entity)
    }

    fun isSupportWomenHealth(): Boolean {
        return wearkit.womenHealthAbility.compat.isSupport()
    }

    fun isSupportHRMeasure(): Boolean {
        return wearkit.heartRateAbility.compat.isSupportMeasure()
    }

    fun isSupportBPMeasure(): Boolean {
        return wearkit.bloodPressureAbility.compat.isSupportMeasure()
    }

    fun isSupportBOMeasure(): Boolean {
        return wearkit.bloodOxygenAbility.compat.isSupportMeasure()
    }

    fun isSupportPressureMeasure(): Boolean {
        return wearkit.pressureAbility.compat.isSupportMeasure()
    }

    fun getTemperatureConfig(): String {
        val config = wearkit.temperatureAbility.getMonitorConfig()
        return gson.toJson(config)
    }

    fun setTemperatureConfig(configJson: String) {
        val config = gson.fromJson(configJson, WKHeartRateMonitorConfig::class.java)
        wearkit.temperatureAbility.setMonitorConfig(config).onErrorComplete().subscribe()
    }

    fun isSupportTemperatureTimePeriod(): Boolean {
        return wearkit.temperatureAbility.compat.isSupportTimePeriod()
    }

    fun isSupportTemperatureTimeInterval(): Boolean {
        return wearkit.temperatureAbility.compat.isSupportTimeInterval()
    }

    fun getCustomRemindMaxNumber(): Int {
        return wearkit.remindAbility.compat.getCustomRemindMaxNumber()
    }

    fun getReminds(): String {
        val data = wearkit.remindAbility.requestReminds().onErrorComplete().blockingGet()
        data?.map { RemindHelper.convertWkToBeanData(it) }?.let {
            return gson.toJson(it)
        }
        return ""
    }

    fun setReminds(json: String) {
        val data = gson.fromJson<List<RemindBean>>(
            json, object : TypeToken<List<RemindBean>>() {}.type
        )
        val wkRemindList = RemindHelper.convertBeanToWkData(data)
        wearkit.remindAbility.setReminds(wkRemindList).onErrorComplete().subscribe()
    }

    fun updateRemind(json: String) {
        val data = gson.fromJson(json, RemindBean::class.java)
        val wkRemindList = RemindHelper.convertBeanToWkData(arrayListOf(data))
        wearkit.remindAbility.addOrUpdateRemind(wkRemindList[0]).onErrorComplete().subscribe()
    }

    fun deleteRemind(typeId: Int) {
        wearkit.remindAbility.deleteRemind(WKRemind.Type.Custom(typeId)).onErrorComplete()
            .subscribe()
    }

    fun createCustomRemind(json: String): String {
        val data = gson.fromJson<List<RemindBean>>(
            json, object : TypeToken<List<RemindBean>>() {}.type
        )
        val wkRemindList = RemindHelper.convertBeanToWkData(data)
        val newRemind = wearkit.remindAbility.compat.createCustomRemind(wkRemindList)
        val bean = RemindHelper.convertWkToBeanData(newRemind)
        return gson.toJson(bean)
    }

    fun getBusinessCard(): String {
        val business = wearkit.businessCardAbility.request().onErrorComplete().blockingGet()
        return gson.toJson(business)
    }

    fun setBusinessCard(cards: String) {
        val typeToken = object : TypeToken<HashMap<String, String>>() {}.type
        val codeMap: HashMap<String, String> = Gson().fromJson(cards, typeToken)
        val map = FixedHashMap<String, String>()
        codeMap.forEach { map.putUnLimit(it.key, it.value) }
        wearkit.businessCardAbility.set(map).onErrorComplete().subscribe()
    }

    fun getWallet(): String {
        val wallet = wearkit.paymentCodeAbility.request().onErrorComplete().blockingGet()
        return gson.toJson(wallet)
    }

    fun setWallet(cards: String) {
        val typeToken = object : TypeToken<HashMap<String, String>>() {}.type
        val codeMap: HashMap<String, String> = Gson().fromJson(cards, typeToken)
        val map = FixedHashMap<String, String>()
        codeMap.forEach { map.putUnLimit(it.key, it.value) }
        wearkit.paymentCodeAbility.set(map).onErrorComplete().subscribe()
    }

    fun getSupportSports(): List<Int>? {
        val data = wearkit.sportUIAbility.requestSupportSports().onErrorComplete().blockingGet()
        return data?.toList()
    }

    fun getDeviceSports(): String {
        val data = wearkit.sportUIAbility.requestSports().onErrorComplete().blockingGet()
        return gson.toJson(data)
    }

    fun isSupportVideoBackground(): Boolean {
        return wearkit.dialStyleAbility.compat.isSupportVideoBackground()
    }

    fun getVideoDuration(): Int {
        return (wearkit.dialStyleAbility.compat.getVideoMaxDurationMillis() / 1000).toInt()
    }

    fun writeLog(tag: String, log: String, level: Int) {
        when (level) {
            0 -> Timber.tag(tag).i(log)
            1 -> Timber.tag(tag).d(log)
            2 -> Timber.tag(tag).w(log)
            3 -> Timber.tag(tag).e(log)
        }
    }

    fun isSupportDeviceLog(): Boolean {
        return wearkit.logAbility.compat.isSupport()
    }

    fun syncUnitConfig(isMetric: Boolean, isCentigrade: Boolean) {
        wearkit.unitAbility.setConfig(WKUnitConfig(isMetric, isCentigrade)).onErrorComplete()
            .subscribe()
    }

    fun setWomenHealthConfig(json: String?) {
        try {
            if (!wearkit.womenHealthAbility.compat.isSupport()) {
                return
            }
            val configJson = gson.fromJson(json, WomenHealthConfigBean::class.java)
            val config = WKWomenHealthConfig(
                mode = configJson.mode ?: WKWomenHealthConfig.Mode.NONE,
                remindTime = configJson.remindTime ?: (21 * 60),
                remindAdvance = configJson.remindAdvance ?: 1,
                remindType = configJson.remindType ?: WKWomenHealthConfig.RemindType.PREGNANCY_DAYS,
                cycle = configJson.cycle ?: 28,
                duration = configJson.duration ?: 7,
                latest = if (configJson.latest != null) {
                    Date(configJson.latest)
                } else {
                    Date()
                }
            )
            LogUtils.iTag(
                "WomenHealthConfig",
                "device apply WomenHealth ${config.mode} ${config.remindTime} ${config.remindAdvance}  ${config.remindType}  ${config.cycle}  ${config.duration}  ${config.latest}"
            )
            wearkit.womenHealthAbility.setConfig(config).onErrorComplete().subscribe()
        } catch (e: Exception) {
            LogUtils.d("setWomenHealthConfig error $e")
        }
    }

    fun isSupportCarouselDial(): Boolean {
        return wearkit.dialStyleAbility.compat.isSupportMultipleBackground()
    }

    fun getDialFree(): Long {
        val dialList = wearkit.dialAbility.requestSpaces().blockingGet()
        return dialList.sumOf { it.free }
    }

    @SuppressLint("CheckResult")
    fun getDialStyle(result: MethodChannel.Result) {
        wearkit.dialStyleAbility.requestCloudDialStyleResources().subscribeOn(Schedulers.io())
            .observeOn(AndroidSchedulers.mainThread()).subscribe({
                wearkit.dialStyleAbility.requestConstraint(it).subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread()).subscribe({ styles ->
                        val styleDtos = styles.styles.map { style ->
                            StyleDto(
                                image = style.image.toString(),
                                width = style.width,
                                height = style.height
                            )
                        }

                        val templateDto = styles.templates.map { resources ->
                            WKResourcesDto(
                                uri = resources.uri.toString(),
                                size = resources.size,
                            )
                        }

                        val constraintDto = DialStyleConstraintDto(
                            styles = styleDtos,
                            templates = templateDto,
                            allowPositions = styles.allowPositions,
                            allowColorTint = styles.allowColorTint,
                        )
                        Timber.i("====> ${gson.toJson(constraintDto)}")
                        result.success(gson.toJson(constraintDto))
                    }, { result.error("-1", "", null) })
            }, {
                LogUtils.e("getDialStyle error ${it.message}")
                result.error("-2", "", null)
            })
    }

    @SuppressLint("CheckResult")
    fun createAndInstall(
        call: MethodCall, customDialProgress: EventChannel.EventSink?, result: MethodChannel.Result
    ) {
        val constraint = call.argument<String>("dialStyleConstraint")
        val styleIndex = call.argument<List<Int>>("styleIndex")
        val positionIndex = call.argument<List<Int>>("positionIndex")
        val backgroundUri = call.argument<List<String>>("customImageUrl")
        val videoRectMap = call.argument<Map<String, Int>>("videoRect")
        val videoDuration = call.argument<Int>("videoDuration")
        val videoTrimStart = call.argument<Int>("videoTrimStart")

        val videoRect = if (videoRectMap != null) {
            android.graphics.Rect(
                videoRectMap["x"]!!,
                videoRectMap["y"]!!,
                videoRectMap["x"]!! + videoRectMap["width"]!!,
                videoRectMap["y"]!! + videoRectMap["height"]!!
            )
        } else {
            null
        }

        val style = gson.fromJson(constraint, DialStyleConstraintDto::class.java)
        val styles = mutableListOf<Style>()
        style?.styles?.map { styleDto ->
            styles.add(
                Style(
                    image = styleDto.image.toUri(), width = styleDto.width, height = styleDto.height
                )
            )
        }
        val template = mutableListOf<WKResources>()
        style?.templates?.map { resourcesDto ->
            template.add(WKResources(uri = resourcesDto.uri.toUri(), size = resourcesDto.size))
        }

        val wkConstraint = WKDialStyleConstraint(
            styles = styles,
            templates = template,
            allowPositions = style.allowPositions,
            allowColorTint = style.allowColorTint
        )

        val inputCompat: MutableList<CreateInputCompat> = mutableListOf()
        for ((index, item) in styleIndex!!.withIndex()) {
            inputCompat.add(
                WKDialStyleAbility.CreateInput().apply {
                    this.styleIndex = item
                    this.positionIndex = positionIndex!![index]
                    this.backgroundUri = backgroundUri!![index].toUri()
                    this.videoRect = videoRect
                    if (videoTrimStart != null) {
                        this.videoOffsetMillis = videoTrimStart.toLong()
                    }
                    if (videoDuration != null) {
                        this.videoDurationMillis = videoDuration.toLong()
                    }
                })
        }
        val input = WKDialStyleAbility.CreateInput().apply { this.inputs = inputCompat }

        var previewFile = ""
        wearkit.dialStyleAbility.createCustom(wkConstraint, input).flatMapObservable {
            LogUtils.i("====>  ${it.previewFile.absolutePath}")
            previewFile = it.previewFile.absolutePath
            wearkit.dialStyleAbility.installCustom(it.dialFile)
        }.observeOn(AndroidSchedulers.mainThread()).doOnSubscribe {}.subscribe({
            val bean = ProgressResultBean(
                it.progress, it.result?.dialId ?: previewFile
            )
            customDialProgress?.success(gson.toJson(bean))
        }, {
            Timber.e("createCustom fail: $it")
            customDialProgress?.error("-2", null, "${it.message}")
        })
        result.success(true)
    }

    private fun ExerciseGoal.toWKGoal(): WKActivityGoalConfig {
        return WKActivityGoalConfig(
            timestampSeconds = lastModifyTime / 1000,
            steps = steps,
            distance = distance * 1000.0,
            calories = calories.toDouble(),
            duration = duration * 60,
            number = number,
            sportDuration = sportDuration * 60,
            disabledReminds = disabledReminds
        )
    }

    @SuppressLint("MissingPermission")
    private fun removeSystemBond(context: Context, address: String?) {
        if (address == null) return
        if (ContextCompat.checkSelfPermission(
                context, Manifest.permission.BLUETOOTH_CONNECT
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            return
        }
        val adapter = wearkit.bluetoothAdapter ?: return
        val device = adapter.getRemoteDevice(address)
        applicationScope.launch {
            val bondState = device.bondState
            if (bondState != BluetoothDevice.BOND_NONE) {
                BondHelper.cancelBondProcess(device)
                delay(500)
                BondHelper.removeBond(device)
            }
        }
    }
}
