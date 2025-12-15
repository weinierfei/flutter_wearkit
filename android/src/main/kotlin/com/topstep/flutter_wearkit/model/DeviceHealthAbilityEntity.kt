package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/6/6 15:54
 */
data class DeviceHealthAbilityEntity(
    val isSleepAbility: Boolean = true,
    val isHeartRateAbility: Boolean,
    val isBloodOxygenAbility: Boolean,
    val isBloodPressureAbility: Boolean,
    val isPressureAbility: Boolean,
    val isWeightAbility: Boolean = true,
    val isTemperatureAbility: Boolean,
    val isWomenHealthAbility: Boolean,
)
