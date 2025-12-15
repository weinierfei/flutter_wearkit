package com.topstep.flutter_wearkit.model

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/9/4 15:57
 */
data class WKResourcesDto(
    val uri: String,

    /**
     * The bytes of this resources
     */
    val size: Long = 0,
)
