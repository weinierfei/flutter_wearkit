package com.topstep.flutter_wearkit.model

import com.topstep.wearkit.apis.model.core.WKDeviceType

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/7/4 10:37
 */
data class SyncDataBean(
    val deviceType: WKDeviceType,

    /**
     * Data sources of device mac address
     */
    val deviceAddress: String,

    /**
     * Data sources of device token
     */

    val deviceToken: String,

    val type: Int,

    val rawData: Any?,

    )
