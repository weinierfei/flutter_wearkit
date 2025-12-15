package com.topstep.flutter_wearkit.model

data class WeatherHourBean(
    /**
     * 时间戳
     */
    val timestampSeconds: Long,

    /**
     * 天气状态码
     */
    val code: Int,

    /**
     * 当前温度，单位摄氏度
     */
    val tempCurrent: Int,

    /**
     * 风力等级
     * 1-17
     */
    val windScale: Int = 0,

    /**
     * 紫外线强度
     * 0：无
     * 1-2：很弱
     * 3-4：弱
     * 5-6：中等
     * 7-8：强
     * 9-10：很强
     * 11：极强
     */
    val ultraviolet: Int = 0,

    /**
     * 可见度，单位千米
     */
    val visibility: Float = 0.0f,

    var type: Int? = null
)
