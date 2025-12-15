package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/29 18:41
 */
data class HeartRateDurationBean(
    /**
     * Warming up duration, in seconds
     */
    val warmUp: Int = 0,

    /**
     * Fuel burning duration, in seconds
     */
    var fatBurning: Int = 0,

    /**
     * Aerobic endurance duration, in seconds
     */
    val aerobic: Int = 0,

    /**
     * Anaerobic endurance duration, in seconds
     */
    val anaerobic: Int = 0,

    /**
     * Heart rate limit duration, in seconds
     */
    val heartLimit: Int = 0,
)
