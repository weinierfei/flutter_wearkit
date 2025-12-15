package com.topstep.flutter_wearkit.log

import android.content.Context
import android.os.Looper
import android.os.Process
import android.util.Log
import com.github.kilnn.tool.system.SystemUtil
import com.tencent.mars.xlog.Xlog
import com.topstep.flutter_wearkit.FlutterWearKitPlugin
import java.io.File
import kotlin.system.measureTimeMillis
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext
import timber.log.Timber

object AppLogger {

    private var xlog: Xlog? = null

    fun init(context: Context) {
        val time = System.currentTimeMillis()
        val logDir = AppFiles.dirLog(context)
        xlog =
                if (logDir != null) {
                    initXlog(context, logDir)
                } else {
                    null
                }

        val msg: String =
                if (xlog == null) {
                    Timber.plant(Timber.DebugTree())
                    "Timber.DebugTree"
                } else {
                    if (FlutterWearKitPlugin.isDebugMode) {
                        Timber.plant(DebugTree())
                        "DebugTree"
                    } else {
                        Timber.plant(ReleaseTree())
                        "ReleaseTree"
                    }
                }
        Timber.i(
                "AppLogger init with %s time use %d , dir:${logDir?.absolutePath}",
                msg,
                System.currentTimeMillis() - time
        )
//        Timber.i("App Version:%s", BuildConfig.VERSION_NAME)
    }

    suspend fun flush() {
        val xlog = this.xlog ?: return
        withContext(Dispatchers.IO) {
            val usedTimes = measureTimeMillis { xlog.appenderFlush(0, true) }
            Timber.i("flush used:%d", usedTimes)
        }
    }

    private class DebugTree : Timber.DebugTree() {
        override fun log(priority: Int, tag: String?, message: String, t: Throwable?) {
            super.log(priority, tag, message, t)
            Xlog.logWrite2(
                    0,
                    tag,
                    "",
                    "",
                    0,
                    Process.myPid(),
                    Thread.currentThread().id,
                    Looper.getMainLooper().thread.id,
                    message
            )
        }
    }

    private class ReleaseTree : Timber.DebugTree() {
        override fun isLoggable(tag: String?, priority: Int): Boolean {
            return priority > Log.DEBUG
        }

        override fun log(priority: Int, tag: String?, message: String, t: Throwable?) {
            Xlog.logWrite2(
                    0,
                    tag,
                    "",
                    "",
                    0,
                    Process.myPid(),
                    Thread.currentThread().id,
                    Looper.getMainLooper().thread.id,
                    message
            )
        }
    }

    private fun initXlog(context: Context, logDir: File): Xlog {
        val processName = SystemUtil.getProcessAliasName(context)
        System.loadLibrary("c++_shared")
        System.loadLibrary("marsxlog")
        val xlog = Xlog()
        xlog.appenderOpen(
                Xlog.LEVEL_VERBOSE,
                Xlog.AppednerModeAsync,
                context.filesDir.absolutePath + "/xlog",
                logDir.absolutePath,
                processName,
                0
        )
        xlog.setConsoleLogOpen(0, false)
        xlog.setMaxFileSize(0, 10 * 1024 * 1024) // 日志文件最大值，10M
        return xlog
    }
}
