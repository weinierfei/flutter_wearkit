package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/4 10:28
 */
data class TemperatureBean(
    val timestampSeconds: Long,

    /**
     * Temperature of your body(unit ℃)。
     * This value is generally in the normal body temperature range[36℃-42℃].
     */
    val body: Float,

    /**
     * Temperature of your wrist(unit ℃)。
     * The range of this value is wider, because it is related to the ambient temperature, in extreme cases it may be below 0℃.
     */
    val wrist: Float,
)
