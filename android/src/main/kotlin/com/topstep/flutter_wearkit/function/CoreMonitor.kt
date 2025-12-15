package com.topstep.flutter_wearkit.function

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.media.AudioManager
import android.text.format.DateFormat
import androidx.lifecycle.DefaultLifecycleObserver
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.ProcessLifecycleOwner
import com.topstep.flywear.sdk.model.message.FwMediaMessage
import com.topstep.flutter_wearkit.config.TimeFormat
import com.topstep.wearkit.apis.WKWearKit
import com.topstep.wearkit.apis.model.config.WKFunctionConfig
import com.topstep.wearkit.apis.model.config.toBuilder
import com.topstep.wearkit.apis.model.message.WKMediaMessage
import com.topstep.wearkit.base.utils.media.AbsMediaController
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import timber.log.Timber

@SuppressLint("CheckResult")
class CoreMonitor(private val context: Context, private val wearKit: WKWearKit) {

    private val applicationScope = CoroutineScope(SupervisorJob() + Dispatchers.Main)

    val mediaController = MyMediaController(context)

    val telephonyController = MyTelephonyController(context, mediaController)


    init {
        ProcessLifecycleOwner.get().lifecycle.addObserver(object : DefaultLifecycleObserver {
                override fun onStart(owner: LifecycleOwner) {
                    telephonyController.initialize()
                }

                override fun onStop(owner: LifecycleOwner) {}
            })

        //        NLSWorker.executeOnce(context)
        //        NLSWorker.execute(context)

        wearKit.mediaAbility.observeMediaMessage().subscribe {
            when (it) {
                is WKMediaMessage.KeyCode -> mediaController.applyKeyEvent(it.keyCode)
                is WKMediaMessage.SetVolume -> mediaController.setVolume(
                    AudioManager.STREAM_MUSIC,
                    it.volume
                )

                is WKMediaMessage.SetSilentMode -> mediaController.setSilentMode(it.enabled)
                is WKMediaMessage.Others -> {
                    if (it.type == FwMediaMessage.OtherType.REQUEST_MUSIC_INFO) {
                        mediaController.requestMusicInfo()
                    } else if (it.type == FwMediaMessage.OtherType.REQUEST_MUSIC_STATE) {
                        mediaController.requestMusicState()
                    }
                }
            }
        }
        mediaController.setOnMusicChangeListener(object : AbsMediaController.OnMusicChangeListener {
            override fun onMusicInfoChange(title: String, artist: String, duration: Long) {
                wearKit.mediaAbility.setMusicInfo(title, artist, duration).onErrorComplete()
                    .subscribe()
            }

            override fun onMusicStateChange(state: Int, position: Long, speed: Float) {
                wearKit.mediaAbility.setMusicState(state, position, speed).onErrorComplete()
                    .subscribe()
            }
        })

        context.registerReceiver(
            object : BroadcastReceiver() {
                override fun onReceive(context: Context?, intent: Intent?) {
                    try {
                        Timber.i("receive:%s", intent?.action)
                        applicationScope.launch {
                            // 当更改时间时，检测时间格式是否需要设置
                            val functionConfig = wearKit.functionAbility.getConfig()
                            functionConfig.toBuilder().applyTimeFormat(TimeFormat.FOLLOW_SYSTEM)
                                .create().let { newConfig ->
                                    if (newConfig != functionConfig) {
                                        wearKit.functionAbility.setConfig(newConfig)
                                            .onErrorComplete().subscribe()
                                    }
                                }
                        }
                    } catch (e: Exception) {
                    }
                }
            }, IntentFilter(Intent.ACTION_TIME_CHANGED)
        )
    }

    private fun WKFunctionConfig.Builder.applyTimeFormat(
        @TimeFormat timeFormat: Int
    ): WKFunctionConfig.Builder {
        val isStyle24 = when (timeFormat) {
            TimeFormat.FOLLOW_SYSTEM -> DateFormat.is24HourFormat(context)
            TimeFormat.CLOCK_12H -> false
            else -> true
        }
        return setFlagEnabled(WKFunctionConfig.Flag.TIME_FORMAT, isStyle24)
    }

    companion object {
        private const val TAG = "CoreMonitor"
    }
}
