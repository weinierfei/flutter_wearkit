package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/4 10:50
 */
data class BloodOxygenBean(
    val timestampSeconds: Long,
    /**
     * Oxygen value (SpO2)
     */
    val oxygen: Int,
)
