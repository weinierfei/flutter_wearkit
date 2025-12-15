package com.topstep.flutter_wearkit.model

import com.topstep.wearkit.apis.model.data.WKSportHeartRateItem
import com.topstep.wearkit.apis.model.data.WKSportItem

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/29 18:38
 */
data class SportRecordBean(
    val timestampSeconds: Long,
    val sportType: Int,
    val endTimestampSeconds: Long,
    val duration: Int,
    val distance: Double,
    val calories: Double,
    val steps: Int,
    val heartRateDuration: HeartRateDurationBean,
    val heartRate: IntMaxMinAvgBean,
    val cadence: IntMaxMinAvgBean,
    val pace: IntMaxMinAvgBean,
    val speed: IntMaxMinAvgBean,
    var items: List<WKSportItem>?,
    var heartRateItems: List<WKSportHeartRateItem>? = null,
    var displayConfigs: List<Int>? = null,
    val extraJson: String? = null,
)
