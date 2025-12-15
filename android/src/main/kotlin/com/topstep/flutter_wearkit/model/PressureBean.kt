package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/4 10:28
 */
data class PressureBean(
    val timestampSeconds: Long,
    /**
     * Pressure value. Limit(0,100)
     */
    val pressure: Int,
)
