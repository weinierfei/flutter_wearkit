package com.topstep.flutter_wearkit.helper

import android.content.Context
import android.content.Context.MODE_PRIVATE
import org.json.JSONArray
import org.json.JSONException
import org.json.JSONObject


/**
 * Description:
 * @author: guoyongping
 * @date:  2025/8/15 18:22
 */
class SpHelper {

    companion object {


        /**
         * 获取是否仅在手机息屏时发送通知
         */
        fun isNotificationScreenOff(context: Context): Boolean {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            return prefs.getBoolean("flutter.n_screen_off", false)
        }

        /**
         *  flutter.notification_other_1391
         *  flutter.token
         * 当前包名是否需要通知
         */
        fun isPackageSupport(context: Context, targetPackage: String): Boolean {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            try {
                val jsonStr = prefs.getString("flutter.token", null)
                if (jsonStr != null) {
                    val jsonObj = JSONObject(jsonStr)
                    val userId = jsonObj.getInt("user_id")
                    val packageNameKey = "flutter.notification_other_$userId"
                    prefs.getString(packageNameKey, null)?.let {
                        val jsonArray = JSONArray(it)
                        for (i in 0 until jsonArray.length()) {
                            val appObj = jsonArray.getJSONObject(i)
                            if (appObj.getString("packageName") == targetPackage) {
                                return true
                            }
                        }
                    }
                }
            } catch (e: JSONException) {
                e.printStackTrace()
            }
            return false
        }

        /**
         * 获取标记
         */
        fun getNotificationCommonFlags(context: Context): Int {
            val prefs = context.getSharedPreferences("FlutterSharedPreferences", MODE_PRIVATE)
            return prefs.getLong("flutter.n_common_flags", 0).toInt()
        }
    }
}