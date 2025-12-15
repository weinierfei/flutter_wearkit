# Flutter WearKit 集成指南

本指南详细说明如何将 `flutter_wearkit` 插件集成到您的 Flutter 项目中。

## 集成

在 `pubspec.yaml` 中添加以下依赖：

```yaml
  flutter_wearkit:
    git:
      url: https://github.com/weinierfei/flutter_wearkit.git
      ref: v1.0.0
```

## 1. Android 原生配置指南

在使用本插件之前，需要在 Android 项目中配置相应的权限。请修改 `android/app/src/main/AndroidManifest.xml` 文件。

### 权限配置

在 `<manifest>` 标签内添加以下权限(你可以根据所用功能添加)：

```xml
<!--用于选择拍照功能或扫码功能-->
<uses-permission android:name="android.permission.CAMERA" />
<!--用于查询网络状态-->
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<!--用于扫描，天气，运动等功能-->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<!--用于监听短信电话时候根据号码查询联系人名称-->
<uses-permission android:name="android.permission.READ_CONTACTS" />
<!--用于电话监听功能-->
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<!--用于应答(挂断)电话功能-->
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.ANSWER_PHONE_CALLS" />
<!--用于挂断电话自动回复短信-->
<uses-permission android:name="android.permission.SEND_SMS" />
<!--用于查找手机震动功能-->
<uses-permission android:name="android.permission.VIBRATE" />

<!-- 蓝牙权限 -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<!-- Android 12 (API 31) 及以上需要的新权限 -->
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_ADVERTISE" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<!-- 位置权限 (Android 6.0 - Android 11 扫描蓝牙需要) -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />

<!--用于女性健康功能读写日历事件-->
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />
<!--用于后台启动CameraActivity-->
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
```

### 动态权限申请

对于 Android 6.0 及以上版本，特别是 Android 12+，您需要在代码中动态申请上述权限。建议使用 `permission_handler` 插件来处理权限请求。

## 2. iOS 原生配置指南

> （暂无）

## 3. 使用说明

### 3.1 初始化

首先导入插件包：

```dart
import 'package:flutter_wearkit/flutter_wearkit.dart';
```

获取插件实例：

```dart
final wearkit = FlutterWearKit();
```

### 3.2 蓝牙连接

连接设备需要提供设备的 MAC 地址以及用户信息，这个过程需要自行实现，蓝牙扫描建议使用 `flutter_blue_plus` 插件。

**参数说明：**

*   `deviceType`: 设备类型 (0:FIT_CLOUD,1:FLY_WEAR,2:SHEN_JU,3:PROTO_TB)
*   `authType`: 认证类型 (0: 绑定, 1: 登录)
*   `authCode`: 验证码 (可选)
*   `mac`: 设备 MAC 地址
*   `userId`: 用户 ID
*   `sex`: 性别 (true: 男, false: 女)
*   `age`: 年龄
*   `height`: 身高 (cm)
*   `weight`: 体重 (kg)

**示例代码：**

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

### 3.3 监听连接状态

通过 `bleStatusStream` 监听蓝牙连接状态的变化。

```dart
wearkit.bleStatusStream.listen((status) {
  debugPrint("当前蓝牙状态: $status");
  // status 可能的值需要参考具体定义，通常包括 'CONNECTED', 'DISCONNECTED', 'CONNECTING' 等
});
```

### 3.4 其他常用功能

*   **断开连接**: `await wearkit.disConnectDevice();`
*   **查找设备**: `await wearkit.findWatch();`
*   **获取电量**: `await wearkit.getDeviceBattery();` (也可通过 `batteryStream` 监听)

### 3.5 example中有简单的调用实现，可以简单参考。其他的接口可以查看`lib/flutter_wearkit.dart`中的接口注释，后续我们会持续更新接口文档。

## 4. 常见问题排查

### Q1: 无法扫描或连接设备

*   **检查权限**: 确保已在 `AndroidManifest.xml` 中声明所有必要的蓝牙和位置权限。
*   **动态权限**: 对于 Android 6.0+，确保已在运行时请求并授予了位置权限（若 targetSdkVersion < 31）或蓝牙扫描/连接权限（若 targetSdkVersion >= 31）。
*   **位置服务**: 在部分 Android 手机上，蓝牙扫描需要开启系统位置服务（GPS）。

### Q2: 连接状态没有回调

*   确保在调用 `connectDevice` 之前已经开始监听 `bleStatusStream`。
*   检查原生日志 (`adb logcat`) 查看是否有底层蓝牙连接错误的报错。
