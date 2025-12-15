package com.topstep.flutter_wearkit

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry
import com.google.gson.Gson
import com.polidea.rxandroidble3.RxBleClient
import com.polidea.rxandroidble3.exceptions.BleDisconnectedException
import com.topstep.flutter_wearkit.DeviceManager.wearkit
import com.topstep.flutter_wearkit.function.CoreMonitor
import com.topstep.flutter_wearkit.helper.DataSyncHelper
import com.topstep.flutter_wearkit.helper.DeviceHelper
import com.topstep.flutter_wearkit.helper.MySyncTimeProvider
import com.topstep.flutter_wearkit.helper.NLSHelper
import com.topstep.flutter_wearkit.log.AppLogger
import com.topstep.flutter_wearkit.model.BloodPressureBean
import com.topstep.flutter_wearkit.model.ProgressResultBean
import com.topstep.flywear.sdk.util.notification.NotificationListenerServiceUtil
import com.topstep.wearkit.apis.exception.WKFileTransferException
import com.topstep.wearkit.apis.model.config.WKFunctionConfig
import com.topstep.wearkit.apis.model.message.WKCameraMessage
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.reactivex.rxjava3.android.schedulers.AndroidSchedulers
import io.reactivex.rxjava3.core.Observable
import io.reactivex.rxjava3.disposables.Disposable
import io.reactivex.rxjava3.schedulers.Schedulers
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import timber.log.Timber
import java.io.File

/** FlutterWearKitPlugin */
@SuppressLint("CheckResult")
class FlutterWearKitPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, LifecycleOwner {
    /**
     * SDK 初始化完成回调接口
     */
    fun interface OnInitializedListener {
        fun onInitialized()
    }

    companion object {
        /** Debug 模式标志，默认 false，由 Flutter 端动态设置 */
        @Volatile
        var isDebugMode: Boolean = false
            private set

        /** 设置 debug 模式 */
        fun setDebugMode(enabled: Boolean) {
            isDebugMode = enabled
            Timber.i("Debug mode set to: $enabled")
        }

        /**
         * 标记核心组件是否已初始化（静态变量，所有引擎共享）
         * 因为 DeviceManager 是单例，核心组件只需要初始化一次
         */
        @Volatile
        private var isCoreInitialized: Boolean = false

        /**
         * 检查 SDK 是否已初始化
         */
        fun isInitialized(): Boolean = isCoreInitialized

        /**
         * 初始化完成回调列表
         */
        private val initListeners = mutableListOf<OnInitializedListener>()

        /**
         * 注册 SDK 初始化完成回调
         * 如果已经初始化完成，会立即调用回调
         *
         * @param listener 初始化完成回调
         */
        @JvmStatic
        fun addOnInitializedListener(listener: OnInitializedListener) {
            if (isCoreInitialized) {
                // 已经初始化完成，立即回调
                listener.onInitialized()
            } else {
                // 还未初始化，添加到列表中等待
                synchronized(initListeners) {
                    initListeners.add(listener)
                }
            }
        }

        /**
         * 移除初始化完成回调
         */
        @JvmStatic
        fun removeOnInitializedListener(listener: OnInitializedListener) {
            synchronized(initListeners) {
                initListeners.remove(listener)
            }
        }

        /**
         * 通知所有监听器初始化完成
         */
        private fun notifyInitialized() {
            synchronized(initListeners) {
                initListeners.forEach { it.onInitialized() }
                initListeners.clear()
            }
        }
    }

    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private val lifecycleRegistry = LifecycleRegistry(this)

    override val lifecycle: Lifecycle
        get() = lifecycleRegistry

    private val applicationScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

    private var coreMonitor: CoreMonitor? = null
    private var processLifecycleManager: MyProcessLifecycleManager? = null
    private var rxBleClient: RxBleClient? = null

    // 标记是否是主引擎（有 Activity 的引擎），用于区分 WorkManager 后台引擎
    private var isMainEngine = false

    // Event Channels
    private val eventChannelName = "com.topStep.flywear/event"
    private val eventChannelFind = "com.topStep.flywear/find"
    private val eventChannelBattery = "com.topStep.flywear/battery"
    private val eventChannelCamera = "com.topStep.flywear/camera"
    private val eventChannelSyncData = "com.topStep.flywear/syncData"
    private val eventChannelSyncDataStatus = "com.topStep.flywear/syncDataStatus"
    private val eventChannelHRMeasure = "com.topStep.flywear/hrMeasure"
    private val eventChannelBPMeasure = "com.topStep.flywear/bpMeasure"
    private val eventChannelBOMeasure = "com.topStep.flywear/boMeasure"
    private val eventChannelPressureMeasure = "com.topStep.flywear/pressureMeasure"
    private val eventChannelDial = "com.topStep.flywear/dial"
    private val eventChannelOta = "com.topStep.flywear/ota"
    private val eventDialProgress = "com.topStep.flywear/customDialProgress"
    private val eventAlarmsChange = "com.topStep.flywear/alarmsChange"
    private val eventWakeupChange = "com.topStep.flywear/wakeupChange"
    private val eventWeatherChange = "com.topStep.flywear/weatherChange"
    private val eventChannelDeviceLog = "com.topStep.flywear/deviceLog"
    private val eventChannelInitialized = "com.topStep.flywear/initialized"

    // Event Sinks
    private var initializedSink: EventChannel.EventSink? = null
    private var syncData: EventChannel.EventSink? = null
    private var hrMeasure: EventChannel.EventSink? = null
    private var bpMeasure: EventChannel.EventSink? = null
    private var boMeasure: EventChannel.EventSink? = null
    private var pressureMeasure: EventChannel.EventSink? = null
    private var progressDial: EventChannel.EventSink? = null
    private var progressOta: EventChannel.EventSink? = null
    private var customDialProgress: EventChannel.EventSink? = null
    private var deviceLogProgress: EventChannel.EventSink? = null

    // Measurement Jobs
    private var hrMeasureJob: Job? = null
    private var bpMeasureJob: Job? = null
    private var boMeasureJob: Job? = null
    private var pressureMeasureJob: Job? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Timber.i("FlutterWearKitPlugin onAttachedToEngine, isCoreInitialized=$isCoreInitialized")
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "com.topStep.flywear/native")
        channel.setMethodCallHandler(this)

        // 首次初始化核心组件（使用静态变量检查，因为 DeviceManager 是单例）
        if (!isCoreInitialized) {
            initializeCore()
        }

        // Setup Event Channels（每次 attach 都需要重新设置）
        setupEventChannels(flutterPluginBinding)

        lifecycleRegistry.currentState = Lifecycle.State.CREATED
    }

    private fun initializeCore() {
        val application = context as Application

        // Initialize AppLogger
        AppLogger.init(application)

        // 只创建一次 RxBleClient
        if (rxBleClient == null) {
            rxBleClient = RxBleClient.create(context)
        }

        // 只注册一次 ProcessLifecycleManager
        if (processLifecycleManager == null) {
            processLifecycleManager = MyProcessLifecycleManager()
            application.registerActivityLifecycleCallbacks(processLifecycleManager)
        }

        val wearKit = wearkitInit(application, rxBleClient!!, processLifecycleManager!!)

        // Initialize DeviceManager
        DeviceManager.init(wearKit)

        // Initialize CoreMonitor
        coreMonitor = CoreMonitor(context, wearKit)

        isCoreInitialized = true
        Timber.i("FlutterWearKitPlugin core initialized")

        // 通知原生层监听器（如 AppApplication）
        notifyInitialized()

        // 通知 Flutter 层
        initializedSink?.success(true)
    }

    private fun setupEventChannels(binding: FlutterPlugin.FlutterPluginBinding) {

        // SDK 初始化完成回调
        EventChannel(binding.binaryMessenger, eventChannelInitialized).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                initializedSink = events
                // 如果已经初始化完成，立即发送回调
                if (isCoreInitialized) {
                    events?.success(true)
                }
            }

            override fun onCancel(arguments: Any?) {
                initializedSink = null
            }
        })

        // Bluetooth State
        EventChannel(binding.binaryMessenger, eventChannelName).setStreamHandler(object :
            EventChannel.StreamHandler {
            private var flowJob: Job? = null
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                flowJob?.cancel()
                flowJob = applicationScope.launch {
                    DeviceManager.flowState.collect {
                        events?.success(it.toString())
                    }
                }
            }

            override fun onCancel(arguments: Any?) {
                flowJob?.cancel()
                flowJob = null
            }
        })

        // Do you need weather updates?
        EventChannel(binding.binaryMessenger, eventWeatherChange).setStreamHandler(object :
            EventChannel.StreamHandler {
            @SuppressLint("CheckResult")
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                Observable.combineLatest(
                    wearkit.deviceAbility.observeDeviceInfo(true),
                    wearkit.functionAbility.observeConfig(true)
                ) { _, functionConfig ->
                    // Merge logic: Check if the device supports weather functionality and if the configuration is enabled.
                    wearkit.weatherAbility.compat.isSupport() && functionConfig.isFlagEnabled(
                        WKFunctionConfig.Flag.WEATHER
                    )
                }.subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ isSupported ->
                        events?.success(isSupported)
                    }, { _ ->
                        events?.success(false)
                    })
            }

            override fun onCancel(arguments: Any?) {

            }
        })

        // Find Device
        EventChannel(binding.binaryMessenger, eventChannelFind).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                wearkit.finderAbility.observeFinderMessage()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ state ->
                        events?.success(state)
                    }, { error ->
                        events?.error("ERROR", "Error observing find state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {
            }
        })

        // Power monitoring
        EventChannel(binding.binaryMessenger, eventChannelBattery).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                wearkit.batteryAbility.observeBatteryChange()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({
                        events?.success(Gson().toJson(it))
                    }, { error ->
                        events?.error("ERROR", "Error observing battery state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {

            }
        })

        // Sync Data
        EventChannel(binding.binaryMessenger, eventChannelSyncData).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                syncData = events
            }

            override fun onCancel(arguments: Any?) {
                syncData = null
            }
        })

        // Data sync status
        EventChannel(binding.binaryMessenger, eventChannelSyncDataStatus).setStreamHandler(object :
            EventChannel.StreamHandler {
            private var syncStatusDisposable: Disposable? = null

            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                syncStatusDisposable?.dispose()
                syncStatusDisposable =   wearkit.deviceAbility.observeSyncState()
                    .subscribeOn(Schedulers.io())  // 可以在后台线程监听
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ state ->
                        events?.success(state)
                    }, { error ->
                        events?.error("ERROR", "Error observing sync state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {
                syncStatusDisposable?.dispose()
                syncStatusDisposable = null
                Timber.i("SyncDataStatus channel cancelled and disposed")
            }
        })

        // HR Measure
        EventChannel(binding.binaryMessenger, eventChannelHRMeasure).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                hrMeasure = events
            }

            override fun onCancel(arguments: Any?) {
                hrMeasure = null
            }
        })

        // BP Measure
        EventChannel(binding.binaryMessenger, eventChannelBPMeasure).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                bpMeasure = events
            }

            override fun onCancel(arguments: Any?) {
                bpMeasure = null
            }
        })

        // BO Measure
        EventChannel(binding.binaryMessenger, eventChannelBOMeasure).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                boMeasure = events
            }

            override fun onCancel(arguments: Any?) {
                boMeasure = null
            }
        })

        // Pressure Measure
        EventChannel(binding.binaryMessenger, eventChannelPressureMeasure).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                pressureMeasure = events
            }

            override fun onCancel(arguments: Any?) {
                pressureMeasure = null
            }
        })

        // Dial Progress
        EventChannel(binding.binaryMessenger, eventChannelDial).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                progressDial = events
            }

            override fun onCancel(arguments: Any?) {
                progressDial = null
            }
        })

        // OTA Progress
        EventChannel(binding.binaryMessenger, eventChannelOta).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                progressOta = events
            }

            override fun onCancel(arguments: Any?) {
                progressOta = null
            }
        })

        // alarms change
        EventChannel(binding.binaryMessenger, eventAlarmsChange).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                wearkit.alarmAbility.observeAlarmsChange()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ data ->
                        events?.success(DeviceManager.gson.toJson(data))
                    }, { error ->
                        events?.error("ERROR", "Error observing alarm state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {

            }
        })

        // Wakeup
        EventChannel(binding.binaryMessenger, eventWakeupChange).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                wearkit.raiseWakeupAbility.observeConfig(true)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ data ->
                        events?.success(DeviceManager.gson.toJson(data))
                    }, { error ->
                        events?.error("ERROR", "Error observing alarm state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {

            }
        })

        // Custom Dial Progress
        EventChannel(binding.binaryMessenger, eventDialProgress).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                customDialProgress = events
            }

            override fun onCancel(arguments: Any?) {
                customDialProgress = null
            }
        })

        // Device Log Progress
        EventChannel(binding.binaryMessenger, eventChannelDeviceLog).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                deviceLogProgress = events
            }

            override fun onCancel(arguments: Any?) {
                deviceLogProgress = null
            }
        })


        // Camera (Placeholder)
        EventChannel(binding.binaryMessenger, eventChannelCamera).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                wearkit.cameraAbility.observeCameraMessage()
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ state ->
                        events?.success(state)
                    }, { error ->
                        events?.error("ERROR", "Error observing camera state", error)
                    })
            }

            override fun onCancel(arguments: Any?) {
            }
        })
    }

    @SuppressLint("CheckResult")
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "connectDevice" -> {
                val deviceType = call.argument<Int>("deviceType")
                val authType = call.argument<Int>("authType")
                val authCode = call.argument<String>("authCode")
                val mac = call.argument<String>("mac")
                val userId = call.argument<String>("userId")
                val sex = call.argument<Boolean>("sex")
                val age = call.argument<Int>("age")
                val height = call.argument<Double>("height")
                val weight = call.argument<Double>("weight")
                DeviceManager.connectDevice(
                    DeviceHelper.typeToWKDeviceType(deviceType!!),
                    authType!!,
                    authCode,
                    mac!!,
                    userId!!,
                    sex!!,
                    age!!,
                    height!!.toFloat(),
                    weight!!.toFloat()
                )
            }

            "updateUserInfo" -> {
                val sex = call.argument<Boolean>("sex")
                val age = call.argument<Int>("age")
                val height = call.argument<Double>("height")
                val weight = call.argument<Double>("weight")
                DeviceManager.updateUserInfo(sex!!, age!!, height!!.toFloat(), weight!!.toFloat())
            }

            "cancelBind" -> {
                val mac = call.argument<String>("mac")
                DeviceManager.cancelBind(context, mac)
            }

            "unbind" -> {
                val mac = call.argument<String>("mac")
                DeviceManager.unbind(context, mac)
            }

            "disConnectDevice" -> {
                DeviceManager.disconnectDevice()
            }

            "reconnectDevice" -> {
                DeviceManager.reconnectDevice()
            }

            "getDeviceInfo" -> {
                result.success(DeviceManager.getDeviceInfo())
            }

            "resetDevice" -> {
                DeviceManager.resetDevice()
            }

            "shutdown" -> {
                DeviceManager.shutdown()
            }

            "getDeviceBattery" -> {
                result.success(DeviceManager.getDeviceBattery())
            }

            "getRaiseWakeupConfig" -> {
                result.success(DeviceManager.getRaiseWakeupConfig())
            }

            "isSupportWakeupPeriod" -> {
                result.success(DeviceManager.isSupportWakeupPeriod())
            }

            "updateWakeupConfig" -> {
                val config = call.argument<String?>("config")
                DeviceManager.updateRaiseWakeupConfig(config)
            }

            "isEnabledFunctionAbility" -> {
                val flag = call.argument<Int>("flag") ?: 1
                result.success(DeviceManager.isEnabledFunctionAbility(flag))
            }

            "updateFunctionAbility" -> {
                val flag = call.argument<Int>("flag") ?: 1
                val isEnabled = call.argument<Boolean>("isEnabled") == true
                DeviceManager.updateFunctionAbility(flag, isEnabled)
            }

            "isSupportWeather" -> {
                result.success(DeviceManager.isSupportWeather())
            }

            "weatherData" -> {
                val weatherData = call.argument<String?>("weatherData")
                DeviceManager.sendWeather(weatherData)
            }

            "findWatch" -> {
                DeviceManager.findWatch()
            }

            "stopFindWatch" -> {
                DeviceManager.stopFindWatch()
            }

            "sendCameraMessage" -> {
                val status = call.argument<Int>("status") ?: WKCameraMessage.CLOSE
                DeviceManager.setCameraStatus(status)
            }

            "isCameraSupportPreview" -> {
                result.success(DeviceManager.isSupportCameraPreview())
            }

            "getCameraPreviewSize" -> {
                result.success(DeviceManager.getCameraPreviewSize())
            }

            "startCameraPreview" -> {
                val fps = call.argument<Int>("fps")!!
                DeviceManager.startCameraPreview(fps)
            }

            "updateCameraPreview" -> {
                applicationScope.launch {
                    try {
                        withContext(Dispatchers.IO) { // 切换到 IO 线程执行耗时操作
                            DeviceManager.updateCameraPreview(call)
                        }
                        result.success(true)
                    } catch (e: Exception) {
                        Timber.e(e, "updateCameraPreview failed $e")
                        result.error("NATIVE_ERROR", e.message, null)
                    }
                }
            }

            "stopCameraPreview" -> {
                DeviceManager.stopCameraPreview()
            }

            "setTelephonyConfig" -> {
                val telephonyEnabled = call.argument<Boolean>("telephonyEnabled") == true
                DeviceManager.setTelephonyConfig(telephonyEnabled)
            }

            "isSupportAppNotification" -> {
                val pck = call.argument<String>("packageName")!!
                result.success(DeviceManager.isSupportAppNotification(pck))
            }

            "getMaxAlarmCount" -> {
                result.success(DeviceManager.getMaxAlarmCount())
            }

            "getLabelMaxBytes" -> {
                result.success(DeviceManager.getLabelMaxBytes())
            }

            "getAlarmList" -> {
                result.success(DeviceManager.getAlarmList())
            }

            "setAlarms" -> {
                val alarms = call.argument<String>("alarms")
                DeviceManager.setAlarms(alarms)
                result.success(true)
            }

            "getContactsCommonMaxNumber" -> result.success(DeviceManager.getContactsCommonMaxNumber())

            "getContactsEmergencyMaxNumber" -> result.success(DeviceManager.getContactsEmergencyMaxNumber())

            "requestContactsCommon" -> result.success(DeviceManager.requestContactsCommon())
            "setContactsCommon" -> {
                val commonContact = call.argument<String>("items")!!
                DeviceManager.setContactsCommon(commonContact)
            }

            "requestContactsEmergency" -> result.success(DeviceManager.requestContactsEmergency())
            "setEmergencyContacts" -> {
                val emergencyContact = call.argument<String>("items")!!
                DeviceManager.setEmergencyContacts(emergencyContact)
            }

            "getDeviceAbility" -> {
                result.success(DeviceManager.getDeviceAbility())
            }

            "getDeviceHealthAbility" -> {
                result.success(DeviceManager.getDeviceHealthAbility())
            }

            "getActivityAttributes" -> {
                result.success(DeviceManager.getActivityAttributes())
            }

            "sleepCalculate" -> {
                val jsonList = call.argument<String>("jsonList")!!
                val algorithm = call.argument<Int>("algorithm")!!
                result.success(DeviceManager.sleepCalculate(jsonList, algorithm))
            }

            "isDataSyncing" -> {
                result.success(DeviceManager.isSyncing())
            }

            "syncData" -> {
                val device = wearkit.connector.getDevice()
                if (device == null) {
                    Timber.e("syncData --> device is null, cannot sync data")
                    result.error("DEVICE_NOT_CONNECTED", "Device is not connected", null)
                    return
                }
                val address = device.address
                val provider = MySyncTimeProvider(context, "wk_sync_time", address)
                wearkit.deviceAbility.syncData(provider)
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .onErrorComplete().subscribe({ data ->
                        DataSyncHelper.convertDataAndSend(data, provider, syncData)
                    }, {
                        Timber.e("syncData --> error = ${it.message}")
                    })
            }

            "writeLog" -> {
                val tag = call.argument<String>("tag")!!
                val log = call.argument<String>("log")!!
                val level = call.argument<Int>("level")!!
                DeviceManager.writeLog(tag, log, level)
            }

            "flushLog" -> {
                applicationScope.launch {
                    AppLogger.flush()
                    result.success(true)
                }
            }

            "getMonitorConfig" -> {
                result.success(DeviceManager.getMonitorConfig())
            }

            "setMonitorConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setMonitorConfig(config)
            }

            "isSupportTimePeriod" -> {
                result.success(DeviceManager.isSupportTimePeriod())
            }

            "isSupportTimeInterval" -> {
                result.success(DeviceManager.isSupportTimeInterval())
            }

            "isSupportAlarmConfig" -> {
                result.success(DeviceManager.isSupportAlarmConfig())
            }

            "getHeartAlarmConfig" -> {
                result.success(DeviceManager.getHeartAlarmConfig())
            }

            "setHeartAlarmConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setHeartAlarmConfig(config)
            }

            "isSupportHRMaxThreshold" -> {
                result.success(DeviceManager.isSupportMaxThreshold())
            }

            "isSupportHRMinValueConfig" -> {
                result.success(DeviceManager.isSupportMinValueConfig())
            }

            "getBOMonitorConfig" -> {
                result.success(DeviceManager.getBOMonitorConfig())
            }

            "setBOMonitorConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setBOMonitorConfig(config)
            }

            "isSupportBOTimePeriod" -> {
                result.success(DeviceManager.isSupportBOTimePeriod())
            }

            "isSupportBOTimeInterval" -> {
                result.success(DeviceManager.isSupportBOTimeInterval())
            }

            "getBPMonitorConfig" -> {
                result.success(DeviceManager.getBPMonitorConfig())
            }

            "setBPMonitorConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setBPMonitorConfig(config)
            }

            "isSupportBPTimePeriod" -> {
                result.success(DeviceManager.isSupportBPTimePeriod())
            }

            "isSupportBPTimeInterval" -> {
                result.success(DeviceManager.isSupportBPTimeInterval())
            }

            "getPressureMonitorConfig" -> {
                result.success(DeviceManager.getPressureMonitorConfig())
            }

            "setPressureMonitorConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setPressureMonitorConfig(config)
            }

            "isSupportPressureTimePeriod" -> {
                result.success(DeviceManager.isSupportPressureTimePeriod())
            }

            "isSupportPressureTimeInterval" -> {
                result.success(DeviceManager.isSupportPressureTimeInterval())
            }

            "isIsolateMonitorConfig" -> {
                result.success(DeviceManager.isIsolateMonitorConfig())
            }

            "getGoalConfig" -> {
                result.success(DeviceManager.getGoalConfig())
            }

            "syncGoalConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.syncGoalConfig(config)
            }

            "isSupportDisabledReminds" -> {
                result.success(DeviceManager.isSupportDisabledReminds())
            }

            "isSupportHRMeasure" -> {
                result.success(DeviceManager.isSupportHRMeasure())
            }

            "isSupportBPMeasure" -> {
                result.success(DeviceManager.isSupportBPMeasure())
            }

            "isSupportBOMeasure" -> {
                result.success(DeviceManager.isSupportBOMeasure())
            }

            "isSupportPressureMeasure" -> {
                result.success(DeviceManager.isSupportPressureMeasure())
            }

            "startHeartRateMeasure" -> {
                hrMeasureJob = null
                hrMeasureJob = applicationScope.launch {
                    wearkit.heartRateAbility.measureRealtime(60).subscribeOn(Schedulers.io())
                        .filter { it > 0 }.observeOn(AndroidSchedulers.mainThread())
                        .subscribe({ data -> hrMeasure?.success(data) }, { error ->
                            Timber.e("Error observing HeartRateMeasure  $error")
                            if (error is BleDisconnectedException) {
                                //
                                // heartRateMeasure?.error("", "", "")
                            }
                        })
                }

                hrMeasureJob?.invokeOnCompletion { Timber.e("Measurement completed HeartRateMeasure  $it") }
            }

            "stopHeartRateMeasure" -> {
                hrMeasureJob?.cancel()
                hrMeasureJob = null
            }

            "startBPMeasure" -> {
                bpMeasureJob = null
                bpMeasureJob = applicationScope.launch {
                    wearkit.bloodPressureAbility.measureRealtime(60).subscribeOn(Schedulers.io())
                        .filter { it.sbp > 0 && it.dbp > 0 }
                        .observeOn(AndroidSchedulers.mainThread()).subscribe({ data ->
                            val bean = BloodPressureBean(
                                data.timestampSeconds, data.sbp, data.dbp
                            )
                            Timber.e("BPMeasure  ${DeviceManager.gson.toJson(bean)}")
                            bpMeasure?.success(DeviceManager.gson.toJson(bean))
                        }, { error ->
                            Timber.e("Error observing bpMeasure  $error")
                            if (error is BleDisconnectedException) {
                                //
                                // heartRateMeasure?.error("", "", "")
                            }
                        })
                }

                bpMeasureJob?.invokeOnCompletion { Timber.e("Measurement completed bpMeasure  $it") }
            }

            "stopBPMeasure" -> {
                bpMeasureJob?.cancel()
                bpMeasureJob = null
            }

            "startBOMeasure" -> {
                boMeasureJob = null
                boMeasureJob = applicationScope.launch {
                    wearkit.bloodOxygenAbility.measureRealtime(60).subscribeOn(Schedulers.io())
                        .filter { it > 0 }.observeOn(AndroidSchedulers.mainThread())
                        .subscribe({ data -> boMeasure?.success(data) }, { error ->
                            Timber.e("Error observing boMeasure  $error")
                            if (error is BleDisconnectedException) {
                                //
                                // heartRateMeasure?.error("", "", "")
                            }
                        })
                }

                boMeasureJob?.invokeOnCompletion { Timber.e("Measurement completed boMeasure  $it") }
            }

            "stopBOMeasure" -> {
                boMeasureJob?.cancel()
                boMeasureJob = null
            }

            "startPressureMeasure" -> {
                pressureMeasureJob = null
                pressureMeasureJob = applicationScope.launch {
                    wearkit.pressureAbility.measureRealtime(60).subscribeOn(Schedulers.io())
                        .filter { it > 0 }.observeOn(AndroidSchedulers.mainThread())
                        .subscribe({ data -> pressureMeasure?.success(data) }, { error ->
                            Timber.e("Error observing pressureMeasure  $error")
                            if (error is BleDisconnectedException) {
                                //
                                // heartRateMeasure?.error("", "", "")
                            }
                        })
                }

                pressureMeasureJob?.invokeOnCompletion { Timber.e("Measurement completed pressureMeasure  $it") }
            }

            "stopPressureMeasure" -> {
                pressureMeasureJob?.cancel()
                pressureMeasureJob = null
            }

            "getTemperatureConfig" -> {
                result.success(DeviceManager.getTemperatureConfig())
            }

            "setTemperatureConfig" -> {
                val config = call.argument<String>("config")!!
                DeviceManager.setTemperatureConfig(config)
            }

            "isSupportTemperatureTimePeriod" -> {
                result.success(DeviceManager.isSupportTemperatureTimePeriod())
            }

            "isSupportTemperatureTimeInterval" -> {
                result.success(DeviceManager.isSupportTemperatureTimeInterval())
            }

            "isSupportDial" -> result.success(DeviceManager.isSupportDial())
            "installDial" -> {
                val dialId = call.argument<String>("dialId")
                val filePath = call.argument<String>("filePath")
                wearkit.dialAbility.install(dialId!!, File(filePath!!))
                    .subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ progress -> progressDial?.success(progress) }, {
                        com.topstep.flutter_wearkit.log.LogUtils.e("===>  ${it}")
                        if (it is WKFileTransferException) {
                            progressDial?.error(
                                "${it.errorCode}", "Error installing dial", "${it.message}"
                            )
                        }
                    })
            }

            "ota" -> {
                val filePath = call.argument<String>("filePath")
                wearkit.otaAbility.ota(File(filePath!!)).subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread())
                    .subscribe({ progress -> progressOta?.success(progress) }, {
                        Timber.tag("OTA").e("error => $it")
                        progressOta?.error("-100", "${it.message}", "${it.message}")
                    })
            }

            "isSupportCarouselDial" -> result.success(DeviceManager.isSupportCarouselDial())
            "requestDials" -> result.success(DeviceManager.requestDials())
            "setAsMainDial" -> {
                val dialId = call.argument<String>("dialId")!!
                DeviceManager.setAsMainDial(dialId)
            }

            // 获取自定义表盘资源
            "requestResources" -> {
                DeviceManager.getDialStyle(result)
            }

            "createAndInstall" -> {
                DeviceManager.createAndInstall(call, customDialProgress, result)
            }

            "getCustomRemindMaxNumber" -> {
                result.success(DeviceManager.getCustomRemindMaxNumber())
            }

            "getReminds" -> {
                result.success(DeviceManager.getReminds())
            }

            "setReminds" -> {
                val reminds = call.argument<String>("reminds")!!
                DeviceManager.setReminds(reminds)
            }

            "updateRemind" -> {
                val remind = call.argument<String>("remind")!!
                DeviceManager.updateRemind(remind)
            }

            "deleteRemind" -> {
                val typeId = call.argument<Int>("typeId")!!
                DeviceManager.deleteRemind(typeId)
            }

            "createCustomRemind" -> {
                val reminds = call.argument<String>("reminds")!!
                result.success(DeviceManager.createCustomRemind(reminds))
            }

            "isEnabledNLS" -> {
                result.success(NLSHelper.isEnabled(context))
            }

            "requestNLSPermission" -> {
                NotificationListenerServiceUtil.toSettings(context)
            }

            "getBusinessCard" -> {
                result.success(DeviceManager.getBusinessCard())
            }

            "setBusinessCard" -> {
                val cards = call.argument<String>("cards")!!
                DeviceManager.setBusinessCard(cards)
            }

            "getWallet" -> {
                result.success(DeviceManager.getWallet())
            }

            "setWallet" -> {
                val cards = call.argument<String>("cards")!!
                DeviceManager.setWallet(cards)
            }

            "getSupportSports" -> {
                result.success(DeviceManager.getSupportSports())
            }

            "getDeviceSports" -> {
                result.success(DeviceManager.getDeviceSports())
            }

            "pushSport" -> {
                val filePath = call.argument<String>("filePath")!!
                wearkit.sportUIAbility.install(File(filePath)).subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread()).subscribe({ _ -> }, {
                        Timber.tag("pushSport").e("error => $it")
                        result.success(false)
                    }, {
                        Timber.tag("pushSport").i("pushSport.done")
                        result.success(true)
                    })
            }

            "isSupportDeviceLog" -> {
                result.success(DeviceManager.isSupportDeviceLog())
            }

            "getDeviceLog" -> {
                wearkit.logAbility.pull().subscribeOn(Schedulers.io())
                    .observeOn(AndroidSchedulers.mainThread()).subscribe(
                        { data ->
                            val bean = ProgressResultBean(data.progress, data.result?.path)
                            deviceLogProgress?.success(DeviceManager.gson.toJson(bean))
                        },
                        { error ->
                            Timber.e("Error DeviceLog  $error")
                            deviceLogProgress?.error(
                                "-100", "${error.message}", "${error.message}"
                            )
                        },
                    )
            }

            "syncUnitConfig" -> {
                val isMetric = call.argument<Boolean>("isMetric") ?: true
                val isCentigrade = call.argument<Boolean>("isCentigrade") ?: true
                DeviceManager.syncUnitConfig(isMetric, isCentigrade)
            }

            "isSupportWomenHealth" -> {
                result.success(DeviceManager.isSupportWomenHealth())
            }

            "syncWomenHealthConfig" -> {
                val config = call.argument<String>("config")
                DeviceManager.setWomenHealthConfig(config)
            }

            "isSupportVideoBackground" -> {
                result.success(DeviceManager.isSupportVideoBackground())
            }

            "getDialFree" -> {
                result.success(DeviceManager.getDialFree())
            }

            "getVideoDialDuration" -> {
                result.success(DeviceManager.getVideoDuration())
            }

            "setDebugMode" -> {
                val enabled = call.argument<Boolean>("enabled") ?: false
                setDebugMode(enabled)
                result.success(true)
            }

            "isDebugMode" -> {
                result.success(isDebugMode)
            }

            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        Timber.i("FlutterWearKitPlugin onDetachedFromEngine, isMainEngine=$isMainEngine")
        channel.setMethodCallHandler(null)
        lifecycleRegistry.currentState = Lifecycle.State.DESTROYED
    }


    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        Timber.i("FlutterWearKitPlugin onAttachedToActivity, isCoreInitialized=$isCoreInitialized")
        isMainEngine = true
        lifecycleRegistry.currentState = Lifecycle.State.RESUMED
    }

    override fun onDetachedFromActivityForConfigChanges() {
        lifecycleRegistry.currentState = Lifecycle.State.CREATED
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Timber.i("FlutterWearKitPlugin onReattachedToActivityForConfigChanges")
        lifecycleRegistry.currentState = Lifecycle.State.RESUMED
    }

    override fun onDetachedFromActivity() {
        Timber.i("FlutterWearKitPlugin onDetachedFromActivity, isMainEngine=$isMainEngine")
        isMainEngine = false
        lifecycleRegistry.currentState = Lifecycle.State.DESTROYED
    }
}
