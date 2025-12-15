package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/4 10:26
 */
data class HeartRateBean(
    val timestampSeconds: Long,
    /**
     * heart rate value (beats per minute)
     */
    val heartRate: Int,
)
