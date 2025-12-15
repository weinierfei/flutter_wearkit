package com.topstep.flutter_wearkit.helper

import com.topstep.flutter_wearkit.config.TimeRangeConfigBean
import com.topstep.flutter_wearkit.model.RemindBean
import com.topstep.wearkit.apis.model.WKRemind
import com.topstep.wearkit.base.model.config.TimeRangeConfig

/**
 * Description:提醒设置辅助
 * @author: guoyongping
 * @date:  2025/8/9 16:42
 */
class RemindHelper {

    companion object {

        /**
         * 将Type转换为可以传输的id类型
         */
        fun type2TransId(type: WKRemind.Type): Int {
            return when (type) {
                WKRemind.Type.Sedentary -> -1
                WKRemind.Type.DrinkWater -> -2
                WKRemind.Type.TakeMedicine -> -3
                is WKRemind.Type.Custom -> type.id
            }
        }

        fun transId2Type(id: Int): WKRemind.Type? {
            return when (id) {
                -1 -> WKRemind.Type.Sedentary
                -2 -> WKRemind.Type.DrinkWater
                -3 -> WKRemind.Type.TakeMedicine
                else -> WKRemind.Type.Custom(id)
            }
        }

        fun convertBeanToWkData(data: List<RemindBean>?): List<WKRemind> {
            val wkRemindList = arrayListOf<WKRemind>()
            data?.map {
                val wkRemind = WKRemind(type = transId2Type(it.type)!!)
                wkRemind.isEnabled = it.isEnabled
                wkRemind.name = it.name
                wkRemind.note = it.note
                wkRemind.dnd = TimeRangeConfig(it.dnd.isEnabled, it.dnd.start, it.dnd.end)
                wkRemind.mode = it.mode
                wkRemind.times = it.times
                wkRemind.start = it.start
                wkRemind.end = it.end
                wkRemind.interval = it.interval
                wkRemind.repeat = it.repeat
                wkRemindList.add(wkRemind)
            }
            return wkRemindList
        }

        fun convertWkToBeanData(data: WKRemind?): RemindBean? {
            data?.let {
                return RemindBean(
                    type = type2TransId(data.type),
                    name = data.name,
                    note = data.note,
                    isEnabled = data.isEnabled,
                    dnd = TimeRangeConfigBean(data.dnd.isEnabled, data.dnd.start, data.dnd.end),
                    mode = data.mode,
                    times = data.times,
                    start = data.start,
                    end = data.end,
                    interval = data.interval,
                    repeat = data.repeat,
                )
            }
            return null
        }
    }
}
