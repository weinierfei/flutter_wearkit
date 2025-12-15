package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/29 18:39
 */
data class SportHeartRateItemBean(
    val timestampSeconds: Long,

    /**
     * The duration(unit seconds) of this item
     */
    val duration: Int,

    /**
     * Heart rate
     */
    val heartRate: Int,
)
