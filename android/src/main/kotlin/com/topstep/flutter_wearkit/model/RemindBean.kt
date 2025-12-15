package com.topstep.flutter_wearkit.model

import com.topstep.flutter_wearkit.config.TimeRangeConfigBean
import com.topstep.wearkit.apis.model.WKRemind

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/8/8 17:37
 */
data class RemindBean(
    val type: Int,
    val name: String,
    var note: String = "",
    var isEnabled: Boolean = false,
    var dnd: TimeRangeConfigBean = TimeRangeConfigBean(false, 0, 0),
    var mode: WKRemind.Mode = WKRemind.Mode.PERIOD,
    var times: ArrayList<Int> = arrayListOf(),
    var start: Int = 0,
    var end: Int = 0,
    var interval: Int = 60,
    var repeat: Int = 0,
)