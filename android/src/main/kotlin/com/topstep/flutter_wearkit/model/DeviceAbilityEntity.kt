package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/6/6 15:54
 */
data class DeviceAbilityEntity(
    val isSupportContact: Boolean,
    val isSupportWeather: Boolean,
    val isSupportMusic: Boolean,
    val isSupportBusinessCard: Boolean,
    val isSupportPaymentCode: Boolean,
    val isSupportSportPush: Boolean,
    val isSupportRemind: Boolean,
    val isSupportEBook: Boolean,
    val isSupportAlbum: Boolean,
    val isSupportAlarm: Boolean,
    val isSupportEmergencyContact: Boolean,
)
