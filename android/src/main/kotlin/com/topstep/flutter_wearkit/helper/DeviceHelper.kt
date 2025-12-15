package com.topstep.flutter_wearkit.helper

import com.topstep.flywear.sdk.model.core.FwConnectorState
import com.topstep.flutter_wearkit.config.ConnectorState
import com.topstep.wearkit.apis.model.core.WKDeviceType

/**
 * Description:
 * @author: guoyongping
 * @date:  2025/8/9 17:38
 */
class DeviceHelper {

    companion object {

        fun typeToWKDeviceType(type: Int): WKDeviceType {
            return when (type) {
                0 -> WKDeviceType.FIT_CLOUD
                1 -> WKDeviceType.FLY_WEAR
                2 -> WKDeviceType.SHEN_JU
                3 -> WKDeviceType.PROTO_TB
                else -> WKDeviceType.PROTO_TB
            }
        }

        fun simpleState(state: FwConnectorState): ConnectorState {
            return when (state) {
                FwConnectorState.DISCONNECTED -> ConnectorState.DISCONNECTED
                FwConnectorState.PRE_CONNECTING -> ConnectorState.PRE_CONNECTING
                FwConnectorState.CONNECTING -> ConnectorState.CONNECTING
                FwConnectorState.PRE_CONNECTED -> ConnectorState.PRE_CONNECTED
                FwConnectorState.CONNECTED -> ConnectorState.CONNECTED
            }
        }

        fun combineState(
            isAdapterEnabled: Boolean,
            connectorState: ConnectorState
        ): ConnectorState {
            return if (!isAdapterEnabled) {
                ConnectorState.BT_DISABLED
            } else {
                connectorState
            }
        }
    }
}