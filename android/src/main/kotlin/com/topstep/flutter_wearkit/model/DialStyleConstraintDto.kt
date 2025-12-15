package com.topstep.flutter_wearkit.model

import com.topstep.wearkit.apis.model.dial.WKDialStyleConstraint.Position

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/9/4 14:45
 */
data class DialStyleConstraintDto(
    val styles: List<StyleDto>,
    val templates: List<WKResourcesDto>,
    val allowPositions: List<Position>?,
    val allowColorTint: Boolean,
)
