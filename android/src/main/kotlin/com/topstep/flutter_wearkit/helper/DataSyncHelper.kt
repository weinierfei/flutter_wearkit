package com.topstep.flutter_wearkit.helper

import android.annotation.SuppressLint
import android.content.Context
import com.topstep.flutter_wearkit.DeviceManager.gson
import com.topstep.flutter_wearkit.model.BloodOxygenBean
import com.topstep.flutter_wearkit.model.BloodPressureBean
import com.topstep.flutter_wearkit.model.HeartRateBean
import com.topstep.flutter_wearkit.model.HeartRateDurationBean
import com.topstep.flutter_wearkit.model.IntMaxMinAvgBean
import com.topstep.flutter_wearkit.model.PressureBean
import com.topstep.flutter_wearkit.model.SportRecordBean
import com.topstep.flutter_wearkit.model.SyncDataBean
import com.topstep.flutter_wearkit.model.TemperatureBean
import com.topstep.wearkit.apis.model.WKTimestampRange
import com.topstep.wearkit.apis.model.data.WKSyncData
import com.topstep.wearkit.apis.util.SyncTimeProviderBase
import io.flutter.plugin.common.EventChannel
import timber.log.Timber

/**
 * Description:数据同步辅助
 * @author: guoyongping
 * @date:  2025/8/13 16:07
 */
class DataSyncHelper {

    companion object {

        @SuppressLint("RestrictedApi")
        fun convertDataAndSend(
            data: WKSyncData,
            provider: MySyncTimeProvider,
            syncData: EventChannel.EventSink?
        ) {
            var rawData: Any? = null
            when (data.type) {
                WKSyncData.Type.ACTIVITY_TODAY_ALL -> {
                    data.toActivityTodayAll()?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.ACTIVITY -> {
                    data.toActivity()?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.SLEEP -> {
                    data.toSleep()?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.HEART_RATE_MANUAL, WKSyncData.Type.HEART_RATE, WKSyncData.Type.HEART_RATE_RESTING -> {
                    data.toHeartRate()?.map {
                        HeartRateBean(it.timestampSeconds, it.heartRate)
                    }?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.BLOOD_OXYGEN, WKSyncData.Type.BLOOD_OXYGEN_MANUAL -> {
                    data.toBloodOxygen()?.map {
                        BloodOxygenBean(it.timestampSeconds, it.oxygen)
                    }?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.BLOOD_PRESSURE, WKSyncData.Type.BLOOD_PRESSURE_MANUAL -> {
                    data.toBloodPressure()?.map {
                        BloodPressureBean(it.timestampSeconds, it.sbp, it.dbp)
                    }?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.PRESSURE, WKSyncData.Type.PRESSURE_MANUAL -> {
                    data.toPressure()?.map {
                        PressureBean(it.timestampSeconds, it.pressure)
                    }?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.SPORT -> {
                    data.toSport()?.map {
                        SportRecordBean(
                            it.timestampSeconds,
                            it.sportType,
                            it.endTimestampSeconds,
                            it.duration,
                            it.distance,
                            it.calories,
                            it.steps,
                            HeartRateDurationBean(
                                it.heartRateDuration.warmUp,
                                it.heartRateDuration.fatBurning,
                                it.heartRateDuration.aerobic,
                                it.heartRateDuration.anaerobic,
                                it.heartRateDuration.heartLimit
                            ),
                            IntMaxMinAvgBean(it.heartRate.max, it.heartRate.min, it.heartRate.avg),
                            IntMaxMinAvgBean(it.cadence.max, it.cadence.min, it.cadence.avg),
                            IntMaxMinAvgBean(it.pace.max, it.pace.min, it.pace.avg),
                            IntMaxMinAvgBean(it.speed.max, it.speed.min, it.speed.avg),
                            it.items,
                            it.heartRateItems,
                            it.displayConfigs,
                            it.extraJson
                        )
                    }?.let {
                        rawData = it
                    }
                }

                WKSyncData.Type.TEMPERATURE, WKSyncData.Type.TEMPERATURE_MANUAL -> {
                    data.toTemperature()?.map {
                        TemperatureBean(it.timestampSeconds, it.body, it.wrist)
                    }?.let {
                        rawData = it
                    }
                }
            }

            val dataBean = SyncDataBean(
                deviceType = data.deviceType,
                deviceAddress = data.deviceAddress,
                deviceToken = data.deviceToken,
                rawData = rawData,
                type = data.type
            )
            val json = gson.toJson(dataBean)
            Timber.tag("DataSyncHelper").i(json)
            syncData?.success(json)
            provider.onItemSyncSuccess(data)
        }
    }
}

class MySyncTimeProvider(
    context: Context,
    spName: String,
    macAddress: String,
) : SyncTimeProviderBase(context, spName, macAddress) {

    override fun getRange(@WKSyncData.Type type: Int): WKTimestampRange {
        return if (type == WKSyncData.Type.SPORT) {
            //运动数据比较大，且每条都是独立的，所以只获取新增的数据即可
            rangeOfIncremental(type)
        } else {
            rangeOfWholeDay(type)
        }
    }

}