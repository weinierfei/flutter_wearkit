package com.topstep.flutter_wearkit.function

import android.content.Context
import android.os.PowerManager
import com.topstep.flutter_wearkit.DeviceManager
import com.topstep.flutter_wearkit.helper.SpHelper
import com.topstep.wearkit.apis.ability.base.WKNotificationAbility
import com.topstep.wearkit.apis.model.message.WKTelephonyType
import com.topstep.wearkit.base.utils.telephony.AbsTelephonyController
import timber.log.Timber

class MyTelephonyController(context: Context,
    private val mediaController: MyMediaController,
) : AbsTelephonyController(context) {

    private val messageDisposable = DeviceManager.wearkit.notificationAbility.observeTelephonyHangup()
        .subscribe({
            val result = hangUp(it.endCall, it.sendSms)
            DeviceManager.wearkit.notificationAbility.replayTelephonyHangup(getResult(result.endCall), getResult(result.sendSms))
                .onErrorComplete().subscribe()
        }, {
            Timber.w(it)
        })

    override fun release() {
        super.release()
        messageDisposable.dispose()
    }

    private fun getResult(result: Int): WKNotificationAbility.ReplayResult {
        when (result) {
            0 -> return WKNotificationAbility.ReplayResult.SUCCESS
            1 -> return WKNotificationAbility.ReplayResult.FAIL_NO_PERMISSION
            255 -> return WKNotificationAbility.ReplayResult.FAIL_UNKNOWN
        }
        return WKNotificationAbility.ReplayResult.SUCCESS
    }

    override fun isTelephonyEnabled(context: Context): Boolean {
        if (SpHelper.isNotificationScreenOff(context)) {
            //只在息屏时发送
            val powerManager = context.getSystemService(Context.POWER_SERVICE) as PowerManager
            if (powerManager.isInteractive) {
                Timber.tag(TAG).i("Skip ScreenOff")
                return false
            }
        }
        return true
    }

    override fun mediaExitSilentMode() {
        mediaController.setSilentMode(false)
    }

    override fun sendAnswered(phoneNumber: String, displayName: String?) {
        DeviceManager.wearkit.notificationAbility.sendTelephonyNotification(
            WKTelephonyType.ANSWERED, phoneNumber, displayName
        ).onErrorComplete().subscribe()
    }

    override fun sendIncoming(phoneNumber: String, displayName: String?) {
        DeviceManager.wearkit.notificationAbility.sendTelephonyNotification(
            WKTelephonyType.INCOMING, phoneNumber, displayName
        ).onErrorComplete().subscribe()
    }

    override fun sendMissedCall(phoneNumber: String, displayName: String?) {
        DeviceManager.wearkit.notificationAbility.sendTelephonyNotification(
            WKTelephonyType.MISSED, phoneNumber, displayName
        ).onErrorComplete().subscribe()
    }

    override fun sendReject(phoneNumber: String, displayName: String?) {
        DeviceManager.wearkit.notificationAbility.sendTelephonyNotification(
            WKTelephonyType.REJECTED, phoneNumber, displayName
        ).onErrorComplete().subscribe()
    }

}