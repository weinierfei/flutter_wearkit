# Flutter WearKit Integration Guide

This guide details how to integrate the `flutter_wearkit` plugin into your Flutter project.

## Integration

Add the following dependency to your `pubspec.yaml`:

```yaml
  flutter_wearkit:
    git:
      url: https://github.com/weinierfei/flutter_wearkit.git
      ref: v1.0.0
```

## 1. Android Native Configuration Guide

Before using this plugin, you need to configure the corresponding permissions in your Android project. Please modify the `android/app/src/main/AndroidManifest.xml` file.

### Permission Configuration

Add the following permissions inside the `<manifest>` tag (add according to the features you use):

```xml
<!-- Used for camera selection or scanning features -->
<uses-permission android:name="android.permission.CAMERA" />
<!-- Used for querying network status -->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<!-- Used for scanning, weather, sports features, etc. -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<!-- Used for querying contact names based on numbers when listening for SMS/calls -->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<!-- Used for phone listening features -->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<!-- Used for answering (hanging up) phone calls -->
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ANSWER_PHONE_CALLS" />
<!-- Used for auto-replying SMS when hanging up calls -->
<uses-permission android:name="android.permission.SEND_SMS" />
<!-- Used for find phone vibration feature -->
<uses-permission android:name="android.permission.VIBRATE" />

<!-- Bluetooth Permissions -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<!-- New permissions required for Android 12 (API 31) and above -->
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<!-- Location permissions (Required for Bluetooth scanning on Android 6.0 - Android 11) -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!-- Used for reading/writing calendar events for Women's Health features -->
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />
<!-- Used for launching CameraActivity in the background -->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
```

### Dynamic Permission Request

For Android 6.0 and above, especially Android 12+, you need to request the above permissions dynamically in your code. It is recommended to use the `permission_handler` plugin to handle permission requests.

## 2. iOS Native Configuration Guide

> (None yet)

## 3. Usage Instructions

### 3.1 Initialization

First import the package:

```dart
import 'package:flutter_wearkit/flutter_wearkit.dart';
```

Get the plugin instance:

```dart
final wearkit = FlutterWearKit();
```

### 3.2 Bluetooth Connection

Connecting to a device requires the device's MAC address and user information. This process needs to be implemented by yourself. It is recommended to use the `flutter_blue_plus` plugin for Bluetooth scanning.

**Parameter Description:**

*   `deviceType`: Device Type (0:FIT_CLOUD, 1:FLY_WEAR, 2:SHEN_JU, 3:PROTO_TB)
*   `authType`: Auth Type (0: Bind, 1: Login)
*   `authCode`: Verification Code (Optional)
*   `mac`: Device MAC Address
*   `userId`: User ID
*   `sex`: Gender (true: Male, false: Female)
*   `age`: Age
*   `height`: Height (cm)
*   `weight`: Weight (kg)

**Example Code:**

```dart
await wearkit.connectDevice(
  deviceType,
  0, // Bind
  null,
  "AA:BB:CC:DD:EE:FF", // MAC Address
  "user_123",
  true, // Male
  25,
  175.0,
  70.0,
);
```

### 3.3 Listen to Connection Status

Listen to changes in Bluetooth connection status via `bleStatusStream`.

```dart
wearkit.bleStatusStream.listen((status) {
  debugPrint("Current Bluetooth Status: $status");
  // The value of status needs to refer to the specific definition, usually including 'CONNECTED', 'DISCONNECTED', 'CONNECTING', etc.
});
```

### 3.4 Other Common Features

*   **Disconnect**: `await wearkit.disConnectDevice();`
*   **Find Device**: `await wearkit.findWatch();`
*   **Get Battery**: `await wearkit.getDeviceBattery();` (can also listen via `batteryStream`)

### 3.5 There is a simple implementation in the example for reference, which you can refer to briefly. For other interfaces, please check the interface comments in `lib/flutter_wearkit.dart`. We will verify and update the interface documentation subsequently.

## 4. Troubleshooting

### Q1: Unable to scan or connect to device

*   **Check Permissions**: Ensure all necessary Bluetooth and Location permissions are declared in `AndroidManifest.xml`.
*   **Dynamic Permissions**: For Android 6.0+, ensure Location permission (if targetSdkVersion < 31) or Bluetooth Scan/Connect permissions (if targetSdkVersion >= 31) are requested and granted at runtime.
*   **Location Services**: On some Android phones, Bluetooth scanning requires system Location Services (GPS) to be enabled.

### Q2: No callback for connection status

*   Ensure you have started listening to `bleStatusStream` before calling `connectDevice`.
*   Check native logs (`adb logcat`) to see if there are any underlying Bluetooth connection errors.
