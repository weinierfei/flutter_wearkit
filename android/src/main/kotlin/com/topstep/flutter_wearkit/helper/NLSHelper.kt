package com.topstep.flutter_wearkit.helper

import android.content.ComponentName
import android.content.Context
import android.provider.Settings
import com.topstep.flutter_wearkit.service.MyNotificationListenerService

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/8/14 17:18
 */
object NLSHelper {

    private const val SETTING_ENABLED_NOTIFICATION_LISTENERS = "enabled_notification_listeners"

    /**
     * 因为从1.0升级到2.0，监听类的类名改变了。所以要额外判断className。
     * 以后可以使用{@link NotificationListenerServiceUtil#isEnabled(Context, String)}代替
     */
    @JvmStatic
    fun isEnabled(context: Context): Boolean {
        val packageName = context.packageName
        val className = MyNotificationListenerService::class.java.name
        val flat = Settings.Secure.getString(context.contentResolver, SETTING_ENABLED_NOTIFICATION_LISTENERS)
        if (flat.isNullOrEmpty()) {
            return false
        }
        val components = flat.split(":")
        return components.any { component ->
            val componentName = ComponentName.unflattenFromString(component)
            componentName != null && packageName == componentName.packageName && className == componentName.className
        }
    }
}