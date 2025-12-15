package com.topstep.flutter_wearkit.config

import com.topstep.wearkit.apis.model.data.WKActivityAttribute

data class ExerciseGoal(
    val steps: Int = 8000,

    /**
     * 单位km
     */
    val distance: Float = 1.0f,

    /**
     * 卡路里，千卡
     */
    val calories: Int = 50,

    /**
     * 活动持续时间，分钟
     */
    val duration: Int = 720,

    /**
     * 活动次数
     */
    val number: Int = 1,

    /**
     * 运动持续时间，分钟
     */
    val sportDuration: Int = 30,

    val lastModifyTime: Long = 0,

    val disabledReminds: List<WKActivityAttribute>? = null,
)