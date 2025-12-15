package com.topstep.flutter_wearkit.helper

import com.topstep.wearkit.apis.model.weather.WKWeatherCode
import com.topstep.wearkit.apis.model.weather.WKWeatherType

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/4/28 17:37
 */
object WeatherHelper {

    fun weatherCode2Describe(code: Int): Int {
        return when (code) {
            0x01 -> WKWeatherCode.CLEAR
            0x02 -> WKWeatherCode.CLOUDY
            0x03 -> WKWeatherCode.OVERCAST
            0x04 -> WKWeatherCode.RAIN_SHOWER
            0x05 -> WKWeatherCode.THUNDER_SHOWER
            0x06 -> WKWeatherCode.RAIN
            0x07 -> WKWeatherCode.HEAVY_RAIN
            0x08 -> WKWeatherCode.FREEZING_RAIN
            0x09 -> WKWeatherCode.SNOW
            0x0a -> WKWeatherCode.HEAVY_SNOW
            0x0b -> WKWeatherCode.SAND_DUST
            0x0c -> WKWeatherCode.SMOKE_FOG
            else -> WKWeatherCode.UNKNOWN
        }
    }

    fun weatherCode2WKWeatherType(code: Int): Int {
        return when (code) {
            0x01 -> WKWeatherType.CLEAR_DAY
            0x02 -> WKWeatherType.CLOUDY_DAY
            0x03 -> WKWeatherType.OVERCAST_DAY
            0x04 -> WKWeatherType.RAIN_SHOWER
            0x05 -> WKWeatherType.THUNDER_SHOWER
            0x06 -> WKWeatherType.RAIN_SHOWER
            0x07 -> WKWeatherType.HEAVY_RAIN
            0x08 -> WKWeatherType.FREEZING_RAIN
            0x09 -> WKWeatherType.SNOW
            0x0a -> WKWeatherType.HEAVY_SNOW
            0x0b -> WKWeatherType.SAND_STORM
            0x0c -> WKWeatherType.FOG
            else -> WKWeatherType.UNKNOWN
        }
    }
}