package com.topstep.flutter_wearkit.config

/**
 * Simplify FcConnectorState and add additional states required by the application layer
 */
enum class ConnectorState {
    /**
     * No device set
     */
    NO_DEVICE,

    /**
     * Bluetooth adapter is disabled
     */
    BT_DISABLED,

    /**
     * Disconnect
     */
    DISCONNECTED,

    /**
     * Although the device is not connected at this time, it will make the next connection after waiting for a certain period of time.
     */
    PRE_CONNECTING,

    /**
     * Connecting
     */
    CONNECTING,

    PRE_CONNECTED,

    /**
     * Connected
     */
    CONNECTED;
}