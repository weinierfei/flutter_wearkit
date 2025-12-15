package com.topstep.flutter_wearkit.model

import com.topstep.wearkit.apis.model.config.WKShape

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/4/22 14:16
 */
data class DeviceInfoEntity(
    val type: String,
    val project: String,
    val model: String,
    val version: String,
    val shape: WKShape,
)
