package com.topstep.flutter_wearkit.config

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/8/8 17:33
 */
data class TimeRangeConfigBean(
    /**
     * 是否开启
     */
    val isEnabled: Boolean = false,

    /**
     * 开始时间，距离0点0分的分钟数。
     * 如 90 = 1*60+30
     */
    val start: Int = 0,

    /**
     * 结束时间，距离0点0分的分钟数。
     * 如 90 = 1*60+30 = 01:30
     */
    val end: Int = 0,
)
