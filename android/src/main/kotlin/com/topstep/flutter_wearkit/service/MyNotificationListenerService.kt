package com.topstep.flutter_wearkit.service

import android.app.Notification
import android.content.Context
import android.os.PowerManager
import android.service.notification.StatusBarNotification
import android.text.TextUtils
import com.topstep.flywear.sdk.model.message.FwAppType
import com.topstep.flywear.sdk.util.notification.AbsNotificationListenerService
import com.topstep.flutter_wearkit.DeviceManager.wearkit
import com.topstep.flutter_wearkit.FlutterWearKitPlugin
import com.topstep.flutter_wearkit.config.NotificationConfig
import com.topstep.flutter_wearkit.function.MyMediaController
import com.topstep.flutter_wearkit.helper.SpHelper
import com.topstep.flutter_wearkit.log.LogUtils
import com.topstep.wearkit.base.utils.FlagUtil
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.AMAZON
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.APPLE_MUSIC
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.DING_TALK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_10
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_11
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_12
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_13
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_14
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_15
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_16
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_17
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_18
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_19
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_2
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_20
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_3
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_4
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_5
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_6
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_7
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_8
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_9
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_GMAIL
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.EMAIL_OUTLOOK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.FACEBOOK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.FACEBOOK_MESSENGER
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.GPAY
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.HIKE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.INSTAGRAM
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.KAKAO_TALK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.LARK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.LARK_SUITE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.LINE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.LINKEDIN
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.MMS_SERVICE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.QQ
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_GOOGLE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_HONOR
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_ONE_PLUS
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_OTHERS
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_SAMSUNG
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SMS_STANDARD
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.SNAPCHAT
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.MICROSOFT_TEAMS
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.TELEGRAM
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.TIKTOK
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.TIKTOK_MUSICAL_LY
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.TIKTOK_STANDARD
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.TWITTER
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.VIBER
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.WECHAT
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.WHATS_APP
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.WHATS_APP_BUSINESS
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.YOUTUBE
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.ZALO
import com.topstep.wearkit.base.utils.notification.CommonAppPackage.ZOOM
import timber.log.Timber

class MyNotificationListenerService : AbsNotificationListenerService() {

    private val TAG = "NotificationListener"

    private val configs = HashMap<String, PackageConfig>()

    private var mediaController: MyMediaController? = null

    override fun onListenerConnected() {
        super.onListenerConnected()
        mediaController?.setNotificationListenerService(this)
    }

    override fun onListenerDisconnected() {
        super.onListenerDisconnected()
        mediaController?.setNotificationListenerService(null)
    }

    override fun onCreate() {
        super.onCreate()
        mediaController = MyMediaController(this)
        mediaController?.setNotificationListenerService(this)
        val smsConfig = PackageConfig(NotificationConfig.SMS, true)
        getSmsPackages().forEach {
            configs[it] = smsConfig
        }

        val emailConfig = PackageConfig(NotificationConfig.EMAIL, true)
        getEmailPackages().forEach {
            configs[it] = emailConfig
        }

        configs[QQ] = PackageConfig(NotificationConfig.QQ, true)
        configs[WECHAT] = PackageConfig(NotificationConfig.WECHAT, true)
        configs[FACEBOOK] = PackageConfig(NotificationConfig.FACEBOOK, true)
        configs[TWITTER] = PackageConfig(NotificationConfig.TWITTER, true)
        configs[LINKEDIN] = PackageConfig(NotificationConfig.LINKEDIN)
        configs[INSTAGRAM] = PackageConfig(NotificationConfig.INSTAGRAM, true)

        configs[WHATS_APP] = PackageConfig(NotificationConfig.WHATSAPP, true)
        configs[WHATS_APP_BUSINESS] = PackageConfig(NotificationConfig.WHATSAPP_BUSINESS, true)

        configs[LINE] = PackageConfig(NotificationConfig.LINE,true)
        configs[FACEBOOK_MESSENGER] = PackageConfig(NotificationConfig.FACEBOOK_MESSENGER,true)
        configs[KAKAO_TALK] = PackageConfig(NotificationConfig.KAKAO,true)
        configs[MICROSOFT_TEAMS] = PackageConfig(NotificationConfig.TEAMS, true)
        configs[TELEGRAM] = PackageConfig(NotificationConfig.TELEGRAM, true)
        configs[VIBER] = PackageConfig(NotificationConfig.VIBER, true)
        configs[SNAPCHAT] = PackageConfig(NotificationConfig.SNAPCHAT, true)
        configs[HIKE] = PackageConfig(NotificationConfig.HIKE, true)
        configs[YOUTUBE] = PackageConfig(NotificationConfig.YOUTUBE, true)
        configs[APPLE_MUSIC] = PackageConfig(NotificationConfig.APPLE_MUSIC, true)
        configs[ZOOM] = PackageConfig(NotificationConfig.ZOOM, true)

        val tiktokAppConfig = PackageConfig(NotificationConfig.TIKTOK, true)
        configs[TIKTOK] = tiktokAppConfig
        configs[TIKTOK_MUSICAL_LY] = tiktokAppConfig
        configs[TIKTOK_STANDARD] = tiktokAppConfig

        configs[EMAIL_GMAIL] = PackageConfig(NotificationConfig.GMAIL, true)
        configs[EMAIL_OUTLOOK] = PackageConfig(NotificationConfig.OUTLOOK, true)

        configs[GPAY] = PackageConfig(NotificationConfig.GPAY, true)
        configs[AMAZON] = PackageConfig(NotificationConfig.AMAZON, true)
        configs[ZALO] = PackageConfig(NotificationConfig.ZALO, true)
        configs[DING_TALK] = PackageConfig(NotificationConfig.DING_TALK, true)

        val larkConfig = PackageConfig(NotificationConfig.LARK, true)
        configs[LARK] = larkConfig
        configs[LARK_SUITE] = larkConfig
    }

    override fun sendNotification(notificationType: String, title: String?, text: String) {
        LogUtils.i("sendNotification:  $notificationType  $title  $text")
        wearkit.notificationAbility.sendAppNotification(notificationType, title, text, "")
            .onErrorComplete().subscribe()
    }

    override fun getNotificationType(context: Context, sbn: StatusBarNotification): String? {

        val notification = sbn.notification
        val packageName = sbn.packageName

        if (FlutterWearKitPlugin.isDebugMode) {
            val sb = StringBuilder(200)
            //sbn info
            sb.append("sbn info [ ")
            sb.append("isOngoing:" + sbn.isOngoing)
            sb.append("    pkg:$packageName")
            sb.append("    id:" + sbn.id)
            sb.append("    key:" + sbn.key)
            sb.append("    groupKey:" + sbn.groupKey)
            sb.append(" ]\n")
            //base info
            sb.append("ntf base [ ")
            sb.append("flags:" + notification.flags)
            sb.append("    category:" + notification.category)
            sb.append("    tickerText:" + notification.tickerText)
            sb.append(" ]\n")
            //extra info
            if (notification.extras != null) {
                val bundle = notification.extras
                val extraTitle = bundle.getCharSequence(Notification.EXTRA_TITLE)
                val extraText = bundle.getCharSequence(Notification.EXTRA_TEXT)
                val textLines = bundle.getCharSequenceArray(Notification.EXTRA_TEXT_LINES)
                if (!TextUtils.isEmpty(extraTitle)) {
                    sb.append("extraTitle:").append(extraTitle).append("\n")
                }
                if (!TextUtils.isEmpty(extraText)) {
                    sb.append("extraText:").append(extraText).append("\n")
                }
                if (textLines != null && textLines.isNotEmpty()) {
                    sb.append("textLines:\n")
                    for (i in textLines.indices) {
                        sb.append("line").append(i).append(":")
                            .append(textLines[i]).append("\n")
                    }
                }
            }
            Timber.tag(TAG).d("NLSContent:\n$sb")
        }

        val isPackageSupport = SpHelper.isPackageSupport(context, packageName)

        val isNotificationScreenOff = SpHelper.isNotificationScreenOff(context)
        if (isNotificationScreenOff) {
            //只在息屏时发送
            val powerManager = getSystemService(POWER_SERVICE) as PowerManager
            if (powerManager.isInteractive) {
                Timber.tag(TAG).d("Skip ScreenOff")
                return null
            }
        }

        val config = configs[packageName]
        if (FlutterWearKitPlugin.isDebugMode) {
            Timber.tag(TAG).d("config:%s", config)
        }

        return if (config != null) {
            val isSupport = if (config.isCommon) {
                //是常用配置里的APP，那么判断是否在commonFlags里有
                val commonFlags = SpHelper.getNotificationCommonFlags(context)
                if (FlutterWearKitPlugin.isDebugMode) {
                    Timber.tag(TAG).d("commonFlags:%d", commonFlags)
                }
                FlagUtil.isFlagEnabled(commonFlags, 1 shl config.flag)
            } else {
                isPackageSupport
            }
            if (isSupport) {
                packageName
            } else {
                null
            }
        } else {
            if (packageName == MMS_SERVICE
                || packageName == SMS_SAMSUNG
                || packageName == SMS_GOOGLE
                || packageName == SMS_ONE_PLUS
                || packageName == SMS_OTHERS
                || packageName == SMS_HONOR) {
                FwAppType.SMS
            } else {
                //un support
                if (isPackageSupport) {
                    FwAppType.OTHERS
                } else {
                    null
                }
            }
        }
    }

    private data class PackageConfig(
        val flag: Int,
        val isCommon: Boolean = false
    )

    companion object {
        private fun getEmailPackages(): List<String> {
            return listOf(
                EMAIL_2,
                EMAIL_3,
                EMAIL_4,
                EMAIL_5,
                EMAIL_6,
                EMAIL_7,
                EMAIL_8,
                EMAIL_9,
                EMAIL_10,
                EMAIL_11,
                EMAIL_12,
                EMAIL_13,
                EMAIL_14,
                EMAIL_15,
                EMAIL_16,
                EMAIL_17,
                EMAIL_18,
                EMAIL_19,
                EMAIL_20,
            )
        }

        private fun getSmsPackages(): List<String> {
            return listOf(
                SMS_SAMSUNG,
                SMS_GOOGLE,
                SMS_ONE_PLUS,
                SMS_OTHERS,
                MMS_SERVICE,
                SMS_HONOR,
                SMS_STANDARD,
            )
        }
    }
}