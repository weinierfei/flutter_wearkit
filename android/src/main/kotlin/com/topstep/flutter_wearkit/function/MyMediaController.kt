package com.topstep.flutter_wearkit.function

import android.content.Context
import com.topstep.flutter_wearkit.DeviceManager.wearkit
import com.topstep.wearkit.apis.model.core.WKConnectorState
import com.topstep.wearkit.base.utils.media.AbsMediaController

class MyMediaController(context: Context) : AbsMediaController(context, true) {

    private val connector = wearkit.connector

    override fun isSupportMusicInfo(): Boolean {
        return connector.getConnectorState() == WKConnectorState.CONNECTED
    }

    override fun isSupportMusicState(): Boolean {
        return connector.getConnectorState() == WKConnectorState.CONNECTED
    }

}