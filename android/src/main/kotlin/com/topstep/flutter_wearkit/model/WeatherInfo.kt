package com.topstep.flutter_wearkit.model


/**
 * 天气信息
 */
data class WeatherInfo(
    val time: Long,//此天气请求下来时候的时间戳
    val expired: Long = 0,//此天气过期的时间戳
    val lat: Double = 0.0,
    val lng: Double = 0.0,
    val locality: String?,
    val tmp: Int,
    val code: Int,
    val text: String? = null,
    val forecasts: List<ForecastInfo>? = null,//天气预报
    val futureHours: List<WeatherHourBean>? = null,
    val min: Int,//当天最低温度
    val max: Int,//当天最高温度
    val windSpeed: Int = 0,
    val pressure: Int = 0,
    val windScale: Int = 0,
    val vis: Int = 0,
) {

    fun isAvailable(maxAge: Long): Boolean {
        return System.currentTimeMillis() < expired
    }

    fun matchForecast(requireForecast: Boolean): Boolean {
        if (!requireForecast) return true
        return forecasts != null && forecasts.size >= 3
    }

    companion object {
        fun newest(w1: WeatherInfo?, w2: WeatherInfo?): WeatherInfo? {
            if (w1 == null) {
                return w2
            }
            if (w2 == null) {
                return w1
            }
            return if (w1.expired > w2.expired) {
                w1
            } else {
                w2
            }
        }
    }
}