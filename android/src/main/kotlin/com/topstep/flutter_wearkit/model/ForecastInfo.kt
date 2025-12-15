package com.topstep.flutter_wearkit.model


/**
 * 某天的天气预报信息
 */
data class ForecastInfo(
    /**
     * 最低温度
     */
    val min: Int,
    /**
     * 最高温度
     */
    val max: Int,

    /**
     * 天气代码
     */
    val code: Int,

    val text: String? = null,

    val time: String? = null,
)
