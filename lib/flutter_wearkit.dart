import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_wearkit_platform_interface.dart';
import 'model/alarm_bean.dart';
import 'model/contact.dart';
import 'model/device_ability_bean.dart';
import 'model/device_battery.dart';
import 'model/device_health_ability_bean.dart';
import 'model/device_info.dart';
import 'model/dial_info.dart';
import 'model/exercise_goal.dart';
import 'model/progress_result_bean.dart';
import 'model/remind_bean.dart';
import 'model/sport_push_bean.dart';
import 'model/unit_config.dart';
import 'model/weather_info.dart';
import 'model/women_health_config.dart';
import 'model/wk_activity_attribute.dart';
import 'model/wk_blood_pressure_item.dart';
import 'model/wk_heart_rate_alarm_config.dart';
import 'model/wk_monitor_config.dart';
import 'model/wk_raise_wakeup_config.dart';
import 'model/wk_sleep_algorithm.dart';
import 'model/wk_sleep_daily.dart';
import 'model/wk_sleep_item.dart';
import 'model/wk_sync_data.dart';
import 'model/wk_base_alarm_config.dart';

class FlutterWearKit {
  static final FlutterWearKit _instance = FlutterWearKit._internal();

  FlutterWearKit._internal();

  factory FlutterWearKit() {
    return _instance;
  }

  Future<String?> getPlatformVersion() {
    return FlutterWearkitPlatform.instance.getPlatformVersion();
  }

  static const MethodChannel _channel = MethodChannel(
    'com.topStep.flywear/native',
  );

  // Event Channels
  static const EventChannel _eventChannel = EventChannel(
    'com.topStep.flywear/event',
  );
  static const EventChannel _findChannel = EventChannel(
    'com.topStep.flywear/find',
  );
  static const EventChannel _batteryChannel = EventChannel(
    'com.topStep.flywear/battery',
  );
  static const EventChannel _cameraChannel = EventChannel(
    'com.topStep.flywear/camera',
  );
  static const EventChannel _syncDataChannel = EventChannel(
    'com.topStep.flywear/syncData',
  );
  static const EventChannel _syncDataStatusChannel = EventChannel(
    'com.topStep.flywear/syncDataStatus',
  );
  static const EventChannel _hrMeasureChannel = EventChannel(
    'com.topStep.flywear/hrMeasure',
  );
  static const EventChannel _bpMeasureChannel = EventChannel(
    'com.topStep.flywear/bpMeasure',
  );
  static const EventChannel _boMeasureChannel = EventChannel(
    'com.topStep.flywear/boMeasure',
  );
  static const EventChannel _pressureMeasureChannel = EventChannel(
    'com.topStep.flywear/pressureMeasure',
  );
  static const EventChannel _dialChannel = EventChannel(
    'com.topStep.flywear/dial',
  );
  static const EventChannel _otaChannel = EventChannel(
    'com.topStep.flywear/ota',
  );
  static const EventChannel _customDialProgressChannel = EventChannel(
    'com.topStep.flywear/customDialProgress',
  );
  static const EventChannel _alarmsChangeChannel = EventChannel(
    'com.topStep.flywear/alarmsChange',
  );
  static const EventChannel _wakeupChangeChannel = EventChannel(
    'com.topStep.flywear/wakeupChange',
  );
  static const EventChannel _weatherChangeChannel = EventChannel(
    'com.topStep.flywear/weatherChange',
  );
  static const EventChannel _deviceLogChannel = EventChannel(
    'com.topStep.flywear/deviceLog',
  );
  static const EventChannel _initializedChannel = EventChannel(
    'com.topStep.flywear/initialized',
  );

  // Streams

  /// Stream for SDK initialization completion
  /// Emits true when the native SDK initialization is complete
  /// The upper layer application can listen to this Stream and perform other initialization work after receiving the callback
  Stream<bool>? _initializedStream;
  Stream<bool> get initializedStream {
    _initializedStream ??= _initializedChannel.receiveBroadcastStream().map(
      (event) => event as bool,
    );
    return _initializedStream!;
  }

  Stream<String>? _bleStatusStream;
  Stream<String> get bleStatusStream {
    _bleStatusStream ??= _eventChannel.receiveBroadcastStream().map(
      (event) => event as String,
    );
    return _bleStatusStream!;
  }

  ///  find device status
  Stream<int>? _findStatusStream;
  Stream<int> get findStatusStream {
    _findStatusStream ??= _findChannel.receiveBroadcastStream().map(
      (event) => event as int,
    );
    return _findStatusStream!;
  }

  /// Monitor battery status
  Stream<DeviceBattery>? _batteryStream;
  Stream<DeviceBattery> get batteryStream {
    _batteryStream ??= _batteryChannel.receiveBroadcastStream().map((event) {
      return DeviceBattery.fromJson(jsonDecode(event));
    });
    return _batteryStream!;
  }

  /// Camera status stream
  /// 1: Camera close
  /// 2: Camera open
  /// 3: Camera take photo(shutter)
  /// 4: Switch to camera back
  /// 5: Switch to camera front
  /// 6: Switch flash off
  /// 7: Switch flash auto
  /// 8: Switch flash on
  Stream<int>? _cameraStatusStream;
  Stream<int> get cameraStatusStream {
    _cameraStatusStream ??= _cameraChannel.receiveBroadcastStream().cast<int>();
    return _cameraStatusStream!;
  }

  /// Sync data stream
  Stream<WKSyncData>? _syncDataStream;
  Stream<WKSyncData> get syncDataStream {
    _syncDataStream ??= _syncDataChannel.receiveBroadcastStream().map((event) {
      return WKSyncData.fromJson(jsonDecode(event));
    });
    return _syncDataStream!;
  }

  /// Sync data status stream
  /// -1: Sync failed because wristband disconnect.
  /// 0: Sync state start
  /// 127: Sync state success
  /// -128: Unknown error
  Stream<int>? _syncDataStatusStream;
  Stream<int> get syncDataStatusStream {
    _syncDataStatusStream ??= _syncDataStatusChannel
        .receiveBroadcastStream()
        .cast<int>();
    return _syncDataStatusStream!;
  }

  Stream<int>? _heartRateMeasureStream;
  Stream<int> get heartRateMeasureStream {
    _heartRateMeasureStream ??= _hrMeasureChannel
        .receiveBroadcastStream()
        .cast<int>();
    return _heartRateMeasureStream!;
  }

  Stream<WKBloodPressureItem>? _bpMeasureStream;
  Stream<WKBloodPressureItem> get bpMeasureStream {
    _bpMeasureStream ??= _bpMeasureChannel.receiveBroadcastStream().map((
      event,
    ) {
      return WKBloodPressureItem.fromJson(jsonDecode(event));
    });
    return _bpMeasureStream!;
  }

  Stream<int>? _boMeasureStream;
  Stream<int> get boMeasureStream {
    _boMeasureStream ??= _boMeasureChannel.receiveBroadcastStream().cast<int>();
    return _boMeasureStream!;
  }

  Stream<int>? _pressureMeasureStream;
  Stream<int> get pressureMeasureStream {
    _pressureMeasureStream ??= _pressureMeasureChannel
        .receiveBroadcastStream()
        .cast<int>();
    return _pressureMeasureStream!;
  }

  /// Cloud dial push progress
  Stream<int>? _dialStatusStream;
  Stream<int> get dialStatusStream {
    _dialStatusStream ??= _dialChannel.receiveBroadcastStream().cast<int>();
    return _dialStatusStream!;
  }

  /// OTA push progress
  Stream<int>? _otaStatusStream;
  Stream<int> get otaStatusStream {
    _otaStatusStream ??= _otaChannel.receiveBroadcastStream().cast<int>();
    return _otaStatusStream!;
  }

  /// custom dial push progress
  Stream<ProgressResultBean>? _dialProgressStream;
  Stream<ProgressResultBean> get dialProgressStream {
    _dialProgressStream ??= _customDialProgressChannel
        .receiveBroadcastStream()
        .map((event) {
          final Map<String, dynamic> resultMap = jsonDecode(event);
          return ProgressResultBean.fromJson(resultMap);
        });
    return _dialProgressStream!;
  }

  Stream<List<AlarmBean>?>? _alarmsChangeStream;
  Stream<List<AlarmBean>?> get alarmsChangeStream {
    _alarmsChangeStream ??= _alarmsChangeChannel.receiveBroadcastStream().map((
      event,
    ) {
      final List<dynamic> jsonList = jsonDecode(event);
      return jsonList.map((json) => AlarmBean.fromJson(json)).toList();
    });
    return _alarmsChangeStream!;
  }

  Stream<WKRaiseWakeupConfig>? _wakeupChangeStream;
  Stream<WKRaiseWakeupConfig> get wakeupChangeStream {
    _wakeupChangeStream ??= _wakeupChangeChannel.receiveBroadcastStream().map((
      event,
    ) {
      return WKRaiseWakeupConfig.fromJson(jsonDecode(event));
    });
    return _wakeupChangeStream!;
  }

  /// Weather configuration changes
  Stream<bool>? _weatherChangeStream;
  Stream<bool> get weatherChangeStream {
    _weatherChangeStream ??= _weatherChangeChannel
        .receiveBroadcastStream()
        .cast<bool>();
    return _weatherChangeStream!;
  }

  /// Pull log file from device.
  Stream<ProgressResultBean>? _deviceLogStream;
  Stream<ProgressResultBean> get deviceLogStream {
    _deviceLogStream ??= _deviceLogChannel.receiveBroadcastStream().map((
      event,
    ) {
      final Map<String, dynamic> resultMap = jsonDecode(event);
      return ProgressResultBean.fromJson(resultMap);
    });
    return _deviceLogStream!;
  }

  // Methods

  /// Bind or connect device
  Future<void> connectDevice(
    int deviceType,
    int authType,
    String? authCode,
    String mac,
    String userId,
    bool sex,
    int age,
    double height,
    double weight,
  ) async {
    try {
      final Map<String, dynamic> args = {
        'deviceType': deviceType,
        'authType': authType, // 0 bind,1 login
        'authCode': authCode,
        'mac': mac,
        'userId': userId,
        'sex': sex,
        'age': age,
        'height': height,
        'weight': weight,
      };
      return await _channel.invokeMethod('connectDevice', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native connectDevice: ${e.message}");
    }
  }

  /// Unbind device
  /// [mac] Device MAC address
  Future<void> unbind(String mac) async {
    try {
      final Map<String, dynamic> args = {'mac': mac};
      return await _channel.invokeMethod('unbind', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native unbind: ${e.message}");
    }
  }

  /// Cancel binding
  /// [mac] Device MAC address
  Future<void> cancelBind(String mac) async {
    try {
      final Map<String, dynamic> args = {'mac': mac};
      return await _channel.invokeMethod('cancelBind', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native cancelBind: ${e.message}");
    }
  }

  /// Disconnect device
  Future<void> disConnectDevice() async {
    try {
      return await _channel.invokeMethod('disConnectDevice');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native disConnectDevice: ${e.message}");
    }
  }

  /// Reconnect device
  Future<void> reconnectDevice() async {
    try {
      return await _channel.invokeMethod('reconnectDevice');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native disConnectDevice: ${e.message}");
    }
  }

  /// Reset device (Factory reset)
  Future<void> resetDevice() async {
    try {
      return await _channel.invokeMethod('resetDevice');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method resetDevice: '${e.message}'.");
    }
  }

  /// Shutdown device
  Future<void> shutdown() async {
    try {
      return await _channel.invokeMethod('shutdown');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method shutdown: '${e.message}'.");
    }
  }

  /// Get device information
  /// Returns [DeviceInfo] object containing firmware version, model, etc.
  Future<DeviceInfo?> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod('getDeviceInfo');
      if (Platform.isAndroid) {
        final Map<String, dynamic> resultMap = jsonDecode(result);
        return DeviceInfo.fromJson(resultMap);
      } else {
        return DeviceInfo.fromJson(jsonDecode(result));
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getDeviceInfo: '${e.message}'.");
      return null;
    }
  }

  /// Get device battery and status
  /// Returns [DeviceBattery] object
  Future<DeviceBattery?> getDeviceBattery() async {
    try {
      final result = await _channel.invokeMethod('getDeviceBattery');
      if (Platform.isAndroid) {
        final Map<String, dynamic> resultMap = jsonDecode(result);
        return DeviceBattery.fromJson(resultMap);
      } else {
        return DeviceBattery.fromJson(jsonDecode(result));
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getDeviceBattery: ${e.message}");
    }
    return null;
  }

  /// Get device basic ability configuration
  /// Returns [DeviceAbilityBean] object describing supported features
  Future<DeviceAbilityBean> getDeviceAbility() async {
    try {
      final result = await _channel.invokeMethod('getDeviceAbility');
      if (Platform.isAndroid) {
        final Map<String, dynamic> resultMap = jsonDecode(result);
        return DeviceAbilityBean.fromJson(resultMap);
      } else {
        return DeviceAbilityBean.fromJson(jsonDecode(result));
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getDeviceAbility:${e.message}");
    }
    return DeviceAbilityBean();
  }

  /// Get device health monitoring ability configuration
  /// Returns [DeviceHealthAbilityBean] object
  Future<DeviceHealthAbilityBean> getDeviceHealthAbility() async {
    try {
      final result = await _channel.invokeMethod('getDeviceHealthAbility');
      if (Platform.isAndroid) {
        final Map<String, dynamic> resultMap = jsonDecode(result);
        return DeviceHealthAbilityBean.fromJson(resultMap);
      } else {
        return DeviceHealthAbilityBean.fromJson(jsonDecode(result));
      }
    } on PlatformException catch (e) {
      debugPrint(" getDeviceHealthAbility error :${e.message}");
    }
    return DeviceHealthAbilityBean();
  }

  /// Send camera status message
  /// [status] Camera status code
  Future<void> sendCameraMessage(int status) async {
    try {
      final Map<String, dynamic> args = {'status': status};
      return await _channel.invokeMethod('sendCameraMessage', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native sendCameraMessage:${e.message}");
    }
  }

  /// Check if device supports camera preview
  Future<bool> isCameraSupportPreview() async {
    try {
      final result = await _channel.invokeMethod('isCameraSupportPreview');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isCameraSupportPreview:${e.message}");
      return false;
    }
  }

  /// Start camera preview
  /// [fps] Preview frame rate
  Future<void> startCameraPreview(int fps) async {
    try {
      final Map<String, dynamic> args = {'fps': fps};
      return await _channel.invokeMethod('startCameraPreview', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native startCameraPreview:${e.message}");
    }
  }

  /// Stop camera preview
  Future<void> stopCameraPreview() async {
    try {
      return await _channel.invokeMethod('stopCameraPreview');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native stopCameraPreview:${e.message}");
    }
  }

  /// Update camera preview data
  /// [args] Preview data arguments
  Future<void> updateCameraPreview(Map<String, dynamic> args) async {
    try {
      return await _channel.invokeMethod('updateCameraPreview', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native updateCameraPreview:${e.message}");
    }
  }

  /// Find watch (Device vibrates or rings)
  Future<void> findWatch() async {
    try {
      return await _channel.invokeMethod('findWatch');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native findWatch: '${e.message}'.");
    }
  }

  /// Stop finding watch
  Future<void> stopFindWatch() async {
    try {
      return await _channel.invokeMethod('stopFindWatch');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native stopFindWatch: '${e.message}'.");
    }
  }

  /// Get maximum number of common contacts
  Future<int> getContactsCommonMaxNumber() async {
    try {
      final result = await _channel.invokeMethod('getContactsCommonMaxNumber');
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("Failed to call getContactsCommonMaxNumber: ${e.message}");
      return 0;
    }
  }

  /// Get maximum number of emergency contacts
  Future<int> getContactsEmergencyMaxNumber() async {
    try {
      final result = await _channel.invokeMethod(
        'getContactsEmergencyMaxNumber',
      );
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native EmergencyMaxNumber:${e.message}");
      return 0;
    }
  }

  /// Request common contacts list
  Future<CommonContactList?> requestContactsCommon() async {
    try {
      final result = await _channel.invokeMethod('requestContactsCommon');
      if (result != null && result.isNotEmpty) {
        return CommonContactList.fromJson(<String, dynamic>{
          "items": jsonDecode(result),
        });
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to call native requestContactsCommon: ${e.message}");
      return null;
    }
  }

  /// Request emergency contacts list
  Future<EmergencyContactList?> requestContactsEmergency() async {
    try {
      final result = await _channel.invokeMethod('requestContactsEmergency');
      if (result != null && result.isNotEmpty) {
        return EmergencyContactList.fromJson(<String, dynamic>{
          "items": jsonDecode(result),
        });
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to call requestContactsEmergency:${e.message}");
      return null;
    }
  }

  /// Set common contacts
  /// [commonContacts] List of contacts
  Future<void> setContactsCommon(List<Contacts> commonContacts) async {
    try {
      if (Platform.isAndroid) {
        return await _channel.invokeMethod(
          'setContactsCommon',
          <String, dynamic>{'items': jsonEncode(commonContacts)},
        );
      } else {
        final iOSStyleResult = jsonEncode(commonContacts);
        return await _channel.invokeMethod(
          'setContactsCommon',
          <String, dynamic>{'items': jsonDecode(iOSStyleResult)},
        );
      }
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method setContactsCommon: '${e.message}'.",
      );
    }
  }

  /// Set emergency contacts
  /// [emergencyContacts] List of contacts
  Future<void> setContactsEmergency(List<Contacts> emergencyContacts) async {
    try {
      if (Platform.isAndroid) {
        return await _channel.invokeMethod(
          'setEmergencyContacts',
          <String, dynamic>{'items': jsonEncode(emergencyContacts)},
        );
      } else {
        final iOSStyleResult = jsonEncode(emergencyContacts);
        return await _channel.invokeMethod(
          'setEmergencyContacts',
          <String, dynamic>{'items': jsonDecode(iOSStyleResult)},
        );
      }
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method setContactsEmergency: '${e.message}'.",
      );
    }
  }

  /// Start OTA update
  /// [filePath] Firmware file path
  Future<void> ota(String filePath) async {
    try {
      final Map<String, dynamic> args = {'filePath': filePath};
      return await _channel.invokeMethod('ota', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method ota: '${e.message}'.");
    }
  }

  /// Check if song push is supported
  Future<bool> isSupportSongPush() async {
    try {
      final result = await _channel.invokeMethod('isSupportSongPush');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method isSupportSongPush: '${e.message}'.",
      );
      return false;
    }
  }

  /// Check if raise-to-wake period setting is supported
  Future<bool> isSupportWakeupPeriod() async {
    try {
      final result = await _channel.invokeMethod('isSupportWakeupPeriod');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportWakeupPeriod :${e.message}");
      return false;
    }
  }

  /// Get raise-to-wake configuration
  Future<WKRaiseWakeupConfig> getRaiseWakeupConfig() async {
    try {
      final result = await _channel.invokeMethod('getRaiseWakeupConfig');
      return WKRaiseWakeupConfig.fromJson(jsonDecode(result));
    } on PlatformException catch (e) {
      debugPrint("Failed to call getRaiseWakeupConfig:${e.message}");
      return WKRaiseWakeupConfig(isEnabled: false, start: 0, end: 0);
    }
  }

  /// Update raise-to-wake configuration
  /// [config] Raise-to-wake configuration object
  Future<void> updateRaiseWakeupConfig(WKRaiseWakeupConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      return await _channel.invokeMethod('updateWakeupConfig', args);
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method updateWakeupConfig: '${e.message}'.",
      );
    }
  }

  /// Check if a specific function is enabled
  /// [flag] Function flag
  Future<bool> isEnabledFunctionAbility(int flag) async {
    try {
      final Map<String, dynamic> args = {'flag': flag};
      final result = await _channel.invokeMethod(
        'isEnabledFunctionAbility',
        args,
      );
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isEnabledFunctionAbility:${e.message}");
      return false;
    }
  }

  /// Update enablement status of a specific function
  /// [flag] Function flag
  /// [isEnabled] Whether to enable
  Future<void> updateFunctionAbility(int flag, bool isEnabled) async {
    try {
      final Map<String, dynamic> args = {'flag': flag, 'isEnabled': isEnabled};
      return await _channel.invokeMethod('updateFunctionAbility', args);
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method updateFunctionAbility: '${e.message}'.",
      );
    }
  }

  /// Check if weather function is supported
  Future<bool> isSupportWeather() async {
    try {
      final result = await _channel.invokeMethod('isSupportWeather');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportWeather: ${e.message}");
      return false;
    }
  }

  /// Send weather data
  /// [bean] Weather info object
  Future<void> sendWeatherData(WeatherInfo bean) async {
    try {
      final Map<String, dynamic> args = {'weatherData': jsonEncode(bean)};
      debugPrint("发送天气数据到设备: $args");
      return await _channel.invokeMethod('weatherData', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call sendWeatherData: ${e.message}");
    }
  }

  /// Set telephony function switch
  /// [flag] true: Enable, false: Disable
  Future<bool> setTelephonyConfig(bool flag) async {
    try {
      final Map<String, dynamic> args = {'telephonyEnabled': flag};
      final result = await _channel.invokeMethod('setTelephonyConfig', args);
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native setTelephonyConfig: '${e.message}'.");
      return false;
    }
  }

  /// Fetch DataStore data from Native (For migration)
  Future<Map<String, dynamic>> fetchAndroidData() async {
    try {
      final result = await _channel.invokeMethod('getPreferencesData');
      if (result is Map) {
        return Map<String, dynamic>.from(
          result.map((key, value) => MapEntry(key.toString(), value)),
        );
      }
      debugPrint("迁移数据类型错误: ${result.runtimeType}");
      return {};
    } on PlatformException catch (e) {
      debugPrint("迁移失败: ${e.message}");
      return {};
    }
  }

  /// Get maximum number of alarms
  Future<int> getMaxAlarmCount() async {
    try {
      final result = await _channel.invokeMethod('getMaxAlarmCount');
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("获取最大闹钟数量失败: ${e.message}");
      return 1;
    }
  }

  /// Get maximum bytes for alarm label
  Future<int> getLabelMaxBytes() async {
    try {
      final result = await _channel.invokeMethod('getLabelMaxBytes');
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("获取最大闹钟标签失败: ${e.message}");
      return 1;
    }
  }

  /// Get alarm list
  Future<List<AlarmBean>?> getAlarms() async {
    try {
      final String jsonString = await _channel.invokeMethod('getAlarmList');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => AlarmBean.fromJson(json)).toList();
    } on PlatformException catch (e) {
      debugPrint("获取闹钟列表失败: ${e.message}");
      return null;
    }
  }

  /// Update alarm list
  /// [alarmData] Alarm list data
  Future<void> updateAlarm(List<AlarmBean>? alarmData) async {
    try {
      if (Platform.isAndroid) {
        return await _channel.invokeMethod('setAlarms', <String, dynamic>{
          'alarms': jsonEncode(alarmData),
        });
      } else {
        final iOSStyle = jsonEncode(alarmData);
        return await _channel.invokeMethod('setAlarms', <String, dynamic>{
          'alarms': jsonDecode(iOSStyle),
        });
      }
    } on PlatformException catch (e) {
      debugPrint("添加闹钟失败: ${e.message}");
    }
  }

  /// Delete specific alarm
  /// [alarmId] Alarm ID
  Future<bool> deleteAlarm(int alarmId) async {
    try {
      final Map<String, dynamic> args = {'id': alarmId};
      final result = await _channel.invokeMethod('deleteAlarm', args);
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("删除闹钟失败: ${e.message}");
      return false;
    }
  }

  /// Get activity data attributes supported by device (steps, distance, calories, etc.)
  Future<List<WKActivityAttribute>> getActivityAttributes() async {
    try {
      String jsonString = await _channel.invokeMethod('getActivityAttributes');
      if (jsonString.trim() == '[]') {
        jsonString = '["STEPS","SPORT_DURATION","NUMBER"]';
      }
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((attributeStr) {
        switch (attributeStr.toString().toUpperCase()) {
          case 'STEPS':
            return WKActivityAttribute.STEPS;
          case 'DISTANCE':
            return WKActivityAttribute.DISTANCE;
          case 'CALORIES':
            return WKActivityAttribute.CALORIES;
          case 'DURATION':
            return WKActivityAttribute.DURATION;
          case 'NUMBER':
            return WKActivityAttribute.NUMBER;
          case 'SPORT_DURATION':
            return WKActivityAttribute.SPORT_DURATION;
          default:
            return WKActivityAttribute.STEPS;
        }
      }).toList();
    } on PlatformException catch (e) {
      debugPrint("获取设备活动数据类型失败: ${e.message}");
      return [
        WKActivityAttribute.STEPS,
        WKActivityAttribute.SPORT_DURATION,
        WKActivityAttribute.NUMBER,
      ];
    }
  }

  /// Calculate sleep data
  /// [list] Raw sleep data
  /// [algorithm] Algorithm version
  Future<WKSleepDaily> sleepCalculate(
    List<WKSleepItem> list,
    int algorithm,
  ) async {
    try {
      final Map<String, dynamic> args = {
        'jsonList': jsonEncode(list),
        'algorithm': algorithm,
      };
      final result = await _channel.invokeMethod('sleepCalculate', args);
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKSleepDaily.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method sleepCalculate: '${e.message}'.",
      );
      // Fallback default
      return WKSleepDaily(
        timestampSeconds: DateTime.now().millisecondsSinceEpoch ~/ 1000,
        algorithm: WKSleepAlgorithm.FLYWEAR_DEFAULT,
      );
    }
  }

  /// Check if data is syncing
  Future<bool> isDataSyncing() async {
    try {
      final result = await _channel.invokeMethod('isDataSyncing');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method syncData: '${e.message}'");
      return false;
    }
  }

  /// Trigger data sync
  Future<void> syncData() async {
    try {
      return await _channel.invokeMethod('syncData');
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method syncData: '${e.message}'");
    }
  }

  /// Write log
  /// [tag] Log tag
  /// [log] Log content
  /// [level] Log level
  Future<void> writeLog(String tag, String log, int level) async {
    try {
      final Map<String, dynamic> args = {
        'tag': tag,
        'log': log,
        'level': level,
      };
      _channel.invokeMethod('writeLog', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method writeLog: '${e.message}'.");
    }
  }

  /// Flush log buffer
  Future<bool> flushLog() async {
    try {
      final result = await _channel.invokeMethod('flushLog');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method readLog: '${e.message}'.");
      return false;
    }
  }

  /// Get monitor configuration (sedentary/drink water, etc.)
  Future<WKMonitorConfig> getMonitorConfig() async {
    try {
      final result = await _channel.invokeMethod('getMonitorConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKMonitorConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method getMonitorConfig: ${e.message}");
      return WKMonitorConfig(false, 0, 0, 10);
    }
  }

  /// Set monitor configuration
  /// [config] Monitor configuration object
  Future<void> setMonitorConfig(WKMonitorConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setMonitorConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method setMonitorConfig: ${e.message}");
    }
  }

  /// Check if time period configuration is supported
  Future<bool> isSupportTimePeriod() async {
    try {
      final result = await _channel.invokeMethod('isSupportTimePeriod');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method isSupportTimePeriod: ${e.message}",
      );
      return false;
    }
  }

  /// Check if time interval configuration is supported
  Future<bool> isSupportTimeInterval() async {
    try {
      final result = await _channel.invokeMethod('isSupportTimeInterval');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native method isSupportTimeInterval: ${e.message}",
      );
      return false;
    }
  }

  /// Check if alarm configuration is supported
  Future<bool> isSupportAlarmConfig() async {
    try {
      final result = await _channel.invokeMethod('isSupportAlarmConfig');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportAlarmConfig: ${e.message}");
      return false;
    }
  }

  /// Get heart rate alarm configuration
  Future<WkHeartRateAlarmConfig> getHeartAlarmConfig() async {
    try {
      final result = await _channel.invokeMethod('getHeartAlarmConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WkHeartRateAlarmConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getHeartAlarmConfig: ${e.message}");
      return WkHeartRateAlarmConfig(
        exercise: WkBaseAlarmConfig(),
        resting: WkBaseAlarmConfig(),
      );
    }
  }

  /// Set heart rate alarm configuration
  /// [config] Heart rate alarm configuration object
  Future<void> setHeartAlarmConfig(WkHeartRateAlarmConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setHeartAlarmConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native setHeartAlarmConfig: ${e.message}");
    }
  }

  /// Check if max heart rate threshold is supported
  Future<bool> isSupportHRMaxThreshold() async {
    try {
      final result = await _channel.invokeMethod('isSupportHRMaxThreshold');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to native isSupportHRMaxThreshold: ${e.message}");
      return false;
    }
  }

  /// Check if min heart rate configuration is supported
  Future<bool> isSupportHRMinValueConfig() async {
    try {
      final result = await _channel.invokeMethod('isSupportHRMinValueConfig');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to native isSupportHRMinValueConfig: ${e.message}");
      return false;
    }
  }

  /// Get blood oxygen monitor configuration
  Future<WKMonitorConfig> getBOMonitorConfig() async {
    try {
      final result = await _channel.invokeMethod('getBOMonitorConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKMonitorConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getBOMonitorConfig: ${e.message}");
      return WKMonitorConfig(false, 0, 0, 10);
    }
  }

  /// Set blood oxygen monitor configuration
  /// [config] Monitor configuration object
  Future<void> setBOMonitorConfig(WKMonitorConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setBOMonitorConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native setBOMonitorConfig: ${e.message}");
    }
  }

  /// Check if blood oxygen monitor time period is supported
  Future<bool> isSupportBOTimePeriod() async {
    try {
      final result = await _channel.invokeMethod('isSupportBOTimePeriod');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportBOTimePeriod: ${e.message}");
      return false;
    }
  }

  /// Check if blood oxygen monitor time interval is supported
  Future<bool> isSupportBOTimeInterval() async {
    try {
      final result = await _channel.invokeMethod('isSupportBOTimeInterval');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportBOTimeInterval: ${e.message}");
      return false;
    }
  }

  /// Get blood pressure monitor configuration
  Future<WKMonitorConfig> getBPMonitorConfig() async {
    try {
      final result = await _channel.invokeMethod('getBPMonitorConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKMonitorConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getBPMonitorConfig: ${e.message}");
      return WKMonitorConfig(false, 0, 0, 10);
    }
  }

  /// Set blood pressure monitor configuration
  /// [config] Monitor configuration object
  Future<void> setBPMonitorConfig(WKMonitorConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setBPMonitorConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native setBPMonitorConfig: ${e.message}");
    }
  }

  /// Check if blood pressure monitor time period is supported
  Future<bool> isSupportBPTimePeriod() async {
    try {
      final result = await _channel.invokeMethod('isSupportBPTimePeriod');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportBPTimePeriod: ${e.message}");
      return false;
    }
  }

  /// Check if blood pressure monitor time interval is supported
  Future<bool> isSupportBPTimeInterval() async {
    try {
      final result = await _channel.invokeMethod('isSupportBPTimeInterval');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isSupportBPTimeInterval: ${e.message}");
      return false;
    }
  }

  /// Get pressure monitor configuration
  Future<WKMonitorConfig> getPressureMonitorConfig() async {
    try {
      final result = await _channel.invokeMethod('getPressureMonitorConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKMonitorConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint(
        "Failed to call native getPressureMonitorConfig: ${e.message}",
      );
      return WKMonitorConfig(false, 0, 0, 10);
    }
  }

  /// Set pressure monitor configuration
  /// [config] Monitor configuration object
  Future<void> setPressureMonitorConfig(WKMonitorConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setPressureMonitorConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to setPressureMonitorConfig: ${e.message}");
    }
  }

  /// Check if pressure monitor time period is supported
  Future<bool> isSupportPressureTimePeriod() async {
    try {
      final result = await _channel.invokeMethod('isSupportPressureTimePeriod');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isSupportPressureTimePeriod: ${e.message}");
      return false;
    }
  }

  /// Check if pressure monitor time interval is supported
  Future<bool> isSupportPressureTimeInterval() async {
    try {
      final result = await _channel.invokeMethod(
        'isSupportPressureTimeInterval',
      );
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isSupportPressureTimeInterval: ${e.message}");
      return false;
    }
  }

  /// Check if isolate monitor configuration (independent configuration)
  Future<bool> isIsolateMonitorConfig() async {
    try {
      final result = await _channel.invokeMethod('isIsolateMonitorConfig');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isIsolateMonitorConfig: ${e.message}");
      return false;
    }
  }

  /// Sync exercise goal configuration
  /// [exerciseGoal] Exercise goal object
  Future<void> syncGoalConfig(ExerciseGoal exerciseGoal) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(exerciseGoal)};
      await _channel.invokeMethod('syncGoalConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method syncGoalConfig: ${e.message}");
    }
  }

  /// Get exercise goal configuration
  Future<ExerciseGoal> getGoalConfig() async {
    try {
      final result = await _channel.invokeMethod('getGoalConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return ExerciseGoal.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native getGoalConfig: ${e.message}");
      return ExerciseGoal();
    }
  }

  /// Sync unit configuration (Metric/Imperial)
  /// [config] Unit configuration object
  Future<void> syncUnitConfig(UnitConfig config) async {
    try {
      final Map<String, bool> args = {
        'isMetric': config.isWeightMetric,
        'isCentigrade': config.isTemperatureCentigrade,
      };
      await _channel.invokeMethod('syncUnitConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method syncUnitConfig: ${e.message}");
    }
  }

  /// Check if disabled reminders check is supported
  Future<bool> isSupportDisabledReminds() async {
    try {
      final result = await _channel.invokeMethod('isSupportDisabledReminds');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isSupportDisabledReminds: ${e.message}");
      return false;
    }
  }

  /// Start heart rate measurement
  Future<void> startHeartRateMeasure() async {
    try {
      return await _channel.invokeMethod('startHeartRateMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call startHeartRateMeasure: '${e.message}'");
    }
  }

  /// Stop heart rate measurement
  Future<void> stopHeartRateMeasure() async {
    try {
      return await _channel.invokeMethod('stopHeartRateMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call stopHeartRateMeasure: '${e.message}'");
    }
  }

  /// Start blood pressure measurement
  Future<void> startBPMeasure() async {
    try {
      return await _channel.invokeMethod('startBPMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call startBPMeasure: '${e.message}'");
    }
  }

  /// Stop blood pressure measurement
  Future<void> stopBPMeasure() async {
    try {
      return await _channel.invokeMethod('stopBPMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call stopBPMeasure: '${e.message}'");
    }
  }

  /// Start blood oxygen measurement
  Future<void> startBOMeasure() async {
    try {
      return await _channel.invokeMethod('startBOMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call startBOMeasure: '${e.message}'");
    }
  }

  /// Stop blood oxygen measurement
  Future<void> stopBOMeasure() async {
    try {
      return await _channel.invokeMethod('stopBOMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call stopBOMeasure: '${e.message}'");
    }
  }

  /// Start pressure measurement
  Future<void> startPressureMeasure() async {
    try {
      return await _channel.invokeMethod('startPressureMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call startPressureMeasure: '${e.message}'");
    }
  }

  /// Stop pressure measurement
  Future<void> stopPressureMeasure() async {
    try {
      return await _channel.invokeMethod('stopPressureMeasure');
    } on PlatformException catch (e) {
      debugPrint("Failed to call stopPressureMeasure: '${e.message}'");
    }
  }

  /// Check if heart rate measurement is supported
  Future<bool> isSupportHRMeasure() async {
    try {
      final result = await _channel.invokeMethod('isSupportHRMeasure');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call isSupportHRMeasure: ${e.message}");
      return false;
    }
  }

  /// Check if blood pressure measurement is supported
  Future<bool> isSupportBPMeasure() async {
    try {
      final result = await _channel.invokeMethod('isSupportBPMeasure');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to isSupportBPMeasure: ${e.message}");
      return false;
    }
  }

  /// Check if blood oxygen measurement is supported
  Future<bool> isSupportBOMeasure() async {
    try {
      final result = await _channel.invokeMethod('isSupportBOMeasure');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call isSupportBOMeasure: ${e.message}");
      return false;
    }
  }

  /// Check if pressure measurement is supported
  Future<bool> isSupportPressureMeasure() async {
    try {
      final result = await _channel.invokeMethod('isSupportPressureMeasure');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call isSupportPressureMeasure: ${e.message}");
      return false;
    }
  }

  /// Get temperature monitor configuration
  Future<WKMonitorConfig> getTemperatureConfig() async {
    try {
      final result = await _channel.invokeMethod('getTemperatureConfig');
      final Map<String, dynamic> resultMap = jsonDecode(result);
      return WKMonitorConfig.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("Failed to call getTemperatureConfig: ${e.message}");
      return WKMonitorConfig(false, 0, 0, 10);
    }
  }

  /// Set temperature monitor configuration
  /// [config] Monitor configuration object
  Future<void> setTemperatureConfig(WKMonitorConfig config) async {
    try {
      final Map<String, dynamic> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('setTemperatureConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call setTemperatureConfig: ${e.message}");
    }
  }

  /// Check if temperature monitor time period is supported
  Future<bool> isSupportTemperatureTimePeriod() async {
    try {
      final result = await _channel.invokeMethod(
        'isSupportTemperatureTimePeriod',
      );
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method isSTTPeriod: ${e.message}");
      return false;
    }
  }

  /// Check if temperature monitor time interval is supported
  Future<bool> isSupportTemperatureTimeInterval() async {
    try {
      final result = await _channel.invokeMethod(
        'isSupportTemperatureTimeInterval',
      );
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method isSTTimeInterval: ${e.message}");
      return false;
    }
  }

  /// Check if dial function is supported
  Future<bool> isSupportDial() async {
    try {
      final result = await _channel.invokeMethod('isSupportDial');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportDial: ${e.message}");
      return false;
    }
  }

  /// Set as main dial
  /// [dialId] Dial ID
  Future<void> setAsMainDial(String dialId) async {
    try {
      final Map<String, dynamic> args = {'dialId': dialId};
      return await _channel.invokeMethod('setAsMainDial', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native setAsMainDial: ${e.message}");
    }
  }

  /// Uninstall dial
  /// [dialId] Dial ID
  Future<void> uninstallDial(String dialId) async {
    try {
      final Map<String, dynamic> args = {'dialId': dialId};
      return await _channel.invokeMethod('uninstallDial', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native uninstallDial: ${e.message}");
    }
  }

  /// Install dial
  /// [dialId] Dial ID
  /// [filePath] Dial file path
  Future<void> installDial(String dialId, String filePath) async {
    try {
      final Map<String, dynamic> args = {
        'dialId': dialId,
        'filePath': filePath,
      };
      return await _channel.invokeMethod('installDial', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native installDial: ${e.message}");
    }
  }

  /// Request online dial list
  Future<DialInfoList?> requestDials() async {
    try {
      final result = await _channel.invokeMethod('requestDials');
      if (result == null || result.isEmpty) {
        return null;
      }
      return DialInfoList.fromJson(<String, dynamic>{
        "items": jsonDecode(result),
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to call native requestDials: ${e.message}");
      return null;
    }
  }

  /// Check if carousel dial is supported
  Future<bool> isSupportCarouselDial() async {
    try {
      final result = await _channel.invokeMethod('isSupportCarouselDial');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native isSupportCarouselDial: ${e.message}");
      return false;
    }
  }

  /// Request dial resources (constraint configuration)
  Future<DialStyleConstraint?> requestResources() async {
    try {
      var result = await _channel.invokeMethod('requestResources');
      return DialStyleConstraint.fromJson(jsonDecode(result));
    } on PlatformException catch (e) {
      debugPrint("Failed to call native method requestResources: ${e.message}");
      return null;
    }
  }

  /// Create and install custom dial
  /// [dialStyleConstraint] Dial style constraint
  /// [styleIndex] Style index
  /// [positionIndex] Position index
  /// [customImageUrl] Custom background image URL
  /// [cropRect] Crop area
  /// [duration] Duration
  /// [trimStart] Trim start time
  Future<bool> createAndInstall(
    DialStyleConstraint dialStyleConstraint,
    List<int> styleIndex,
    List<int> positionIndex,
    List<String> customImageUrl, {
    Rect? cropRect,
    int? duration,
    int? trimStart,
  }) async {
    try {
      final Map<String, dynamic> args = {
        "dialStyleConstraint": jsonEncode(dialStyleConstraint),
        "styleIndex": styleIndex,
        "positionIndex": positionIndex,
        "customImageUrl": customImageUrl,
      };

      if (cropRect != null) {
        args['videoRect'] = {
          'x': cropRect.left.toInt(),
          'y': cropRect.top.toInt(),
          'width': cropRect.width.toInt(),
          'height': cropRect.height.toInt(),
        };
      }
      if (duration != null) {
        args['videoDuration'] = duration;
      }
      if (trimStart != null) {
        args['videoTrimStart'] = trimStart;
      }

      await _channel.invokeMethod('createAndInstall', args);
      return true;
    } on PlatformException catch (e) {
      debugPrint("Failed to call native createAndInstall: ${e.message}");
      return false;
    }
  }

  /// Get maximum number of custom reminders
  Future<int> getCustomRemindMaxNumber() async {
    try {
      final result = await _channel.invokeMethod('getCustomRemindMaxNumber');
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("提醒设置--获取可自定义最大数 失败: ${e.message}");
      return 0;
    }
  }

  /// Get reminder list
  Future<List<RemindBean>?> getReminds() async {
    try {
      final String jsonString = await _channel.invokeMethod('getReminds');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => RemindBean.fromJson(json)).toList();
    } on PlatformException catch (e) {
      debugPrint("获取提醒列表失败: ${e.message}");
      return null;
    }
  }

  /// Update reminder list
  /// [data] Reminder list data
  Future<void> updateReminds(List<RemindBean>? data) async {
    try {
      return await _channel.invokeMethod('setReminds', <String, dynamic>{
        'reminds': jsonEncode(data),
      });
    } on PlatformException catch (e) {
      debugPrint("更新提醒设置 失败: ${e.message}");
    }
  }

  /// Delete custom reminder
  /// [typeId] Reminder type ID
  Future<bool> deleteRemind(int typeId) async {
    try {
      final Map<String, dynamic> args = {'typeId': typeId};
      final result = await _channel.invokeMethod('deleteRemind', args);
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("删除自定义提醒 失败: ${e.message}");
      return false;
    }
  }

  /// Update or add single reminder
  /// [bean] Reminder object
  Future<bool> updateRemind(RemindBean bean) async {
    try {
      return await _channel.invokeMethod('updateRemind', <String, dynamic>{
        'remind': jsonEncode(bean),
      });
    } on PlatformException catch (e) {
      debugPrint("新增或更新 失败: ${e.message}");
      return false;
    }
  }

  /// Create custom reminder
  /// [data] Reminder list data
  Future<RemindBean?> createCustomRemind(List<RemindBean>? data) async {
    try {
      String jsonString = await _channel.invokeMethod(
        'createCustomRemind',
        <String, dynamic>{'reminds': jsonEncode(data)},
      );
      final Map<String, dynamic> resultMap = jsonDecode(jsonString);
      return RemindBean.fromJson(resultMap);
    } on PlatformException catch (e) {
      debugPrint("创建自定义提醒 失败: ${e.message}");
      return null;
    }
  }

  /// Check if Notification Listener Service (NLS) is enabled
  Future<bool> isEnabledNLS() async {
    try {
      final result = await _channel.invokeMethod('isEnabledNLS');
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("检查是否启用通知监听 失败: ${e.message}");
      return false;
    }
  }

  /// Check if app notification is supported
  /// [packageName] App package name
  Future<bool> isSupportAppNotification(String packageName) async {
    try {
      final Map<String, dynamic> args = {'packageName': packageName};
      final result = await _channel.invokeMethod(
        'isSupportAppNotification',
        args,
      );
      return result as bool;
    } on PlatformException catch (e) {
      debugPrint("是否支持该应用通知 失败: ${e.message}");
      return false;
    }
  }

  /// Set app notification switch
  /// [flags] Notification switch flags
  Future<void> setAppNotifications(int flags) async {
    try {
      await _channel.invokeMethod('setAppNotifications', flags);
    } on PlatformException catch (e) {
      debugPrint("设置应用通知支持状态失败: ${e.message}");
    }
  }

  /// Get app notification support status
  /// [packageTypes] App type list
  /// Returns Map, key is app type, value is whether supported
  Future<Map<int, bool>> getSupportAppNotifications(
    List<int> packageTypes,
  ) async {
    try {
      final result = await _channel.invokeMethod(
        'getSupportAppNotifications',
        packageTypes,
      );

      if (result is Map) {
        final Map<int, bool> typedResult = {};
        result.forEach((key, value) {
          if (key is int && value is bool) {
            typedResult[key] = value;
          }
        });
        return typedResult;
      }
      return {};
    } on PlatformException catch (e) {
      debugPrint("获取应用通知支持状态失败: ${e.message}");
      return {};
    }
  }

  /// Open system notification settings page (Request NLS permission)
  Future<void> openNotificationSetting() async {
    try {
      return await _channel.invokeMethod('requestNLSPermission');
    } on PlatformException catch (e) {
      debugPrint("Failed to call openNotificationSetting: '${e.message}'");
    }
  }

  /// Get business card list
  /// Returns Map, key is card type, value is content
  Future<Map<String, String>?> getBusinessCard() async {
    try {
      final String response = await _channel.invokeMethod('getBusinessCard');
      return Map<String, String>.from(jsonDecode(response));
    } on PlatformException catch (e) {
      debugPrint("获取名片列表失败: ${e.message}");
      return null;
    }
  }

  /// Set business card
  /// [data] Business card data Map
  Future<void> setBusinessCard(Map<String, String>? data) async {
    try {
      return await _channel.invokeMethod('setBusinessCard', <String, dynamic>{
        'cards': jsonEncode(data),
      });
    } on PlatformException catch (e) {
      debugPrint("设置名片 失败: ${e.message}");
    }
  }

  /// Get wallet data
  /// Returns Map, key is wallet type, value is content
  Future<Map<String, String>?> getWallet() async {
    try {
      final String response = await _channel.invokeMethod('getWallet');
      return Map<String, String>.from(jsonDecode(response));
    } on PlatformException catch (e) {
      debugPrint("获取名片列表失败: ${e.message}");
      return null;
    }
  }

  /// Set wallet data
  /// [data] Wallet data Map
  Future<void> setWallet(Map<String, String>? data) async {
    try {
      return await _channel.invokeMethod('setWallet', <String, dynamic>{
        'cards': jsonEncode(data),
      });
    } on PlatformException catch (e) {
      debugPrint(" Set wallet data fail: ${e.message}");
    }
  }

  /// Get list of sports types supported by device
  Future<List<int>?> getSupportSports() async {
    try {
      return await _channel.invokeMethod('getSupportSports');
    } on PlatformException catch (e) {
      debugPrint("获取设备支持的所有运动类型 失败: ${e.message}");
      return null;
    }
  }

  /// Get list of sports currently installed on device
  Future<List<SportPushBean>?> getDeviceSports() async {
    try {
      final String jsonString = await _channel.invokeMethod('getDeviceSports');
      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList.map((json) => SportPushBean.fromJson(json)).toList();
    } on PlatformException catch (e) {
      debugPrint("获取设备上已有的运动 失败: ${e.message}");
      return null;
    }
  }

  /// Push sport to device
  /// [filePath] Sport file path
  Future<bool> pushSport(String filePath) async {
    try {
      final Map<String, dynamic> args = {'filePath': filePath};
      return await _channel.invokeMethod('pushSport', args);
    } on PlatformException catch (e) {
      debugPrint("推送运动 失败: ${e.message}");
      return false;
    }
  }

  /// Check if device log extraction is supported
  Future<bool> isSupportDeviceLog() async {
    try {
      return await _channel.invokeMethod('isSupportDeviceLog');
    } on PlatformException catch (e) {
      debugPrint("是否支持设备日志 失败: ${e.message}");
      return false;
    }
  }

  /// Get device log
  Future<void> getDeviceLog() async {
    try {
      return await _channel.invokeMethod('getDeviceLog');
    } on PlatformException catch (e) {
      debugPrint("get device log failed : ${e.message}");
    }
  }

  /// Check if women health function is supported
  Future<bool> isSupportWomenHealth() async {
    try {
      return await _channel.invokeMethod('isSupportWomenHealth');
    } on PlatformException catch (e) {
      debugPrint("设备是否支持女性健康 失败: ${e.message}");
      return false;
    }
  }

  /// Sync women health configuration
  /// [config] Women health configuration object
  Future<void> syncWomenHealthConfig(WomenHealthConfig? config) async {
    try {
      final Map<String, String?> args = {'config': jsonEncode(config)};
      await _channel.invokeMethod('syncWomenHealthConfig', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call syncWomenHealthConfig: ${e.message}");
    }
  }

  /// Update user info
  /// [sex] Sex (true: Male, false: Female)
  /// [age] Age 0:male 1:female
  /// [height] Height (cm)
  /// [weight] Weight (kg)
  Future<void> updateUserInfo(
    bool sex,
    int age,
    double height,
    double weight,
  ) async {
    try {
      final Map<String, dynamic> args = {
        'sex': sex,
        'age': age,
        'height': height,
        'weight': weight,
      };
      debugPrint("update user info : $args");
      return await _channel.invokeMethod('updateUserInfo', args);
    } on PlatformException catch (e) {
      debugPrint("Failed to call native updateUserInfo: ${e.message}");
    }
  }

  /// Check if dynamic video background is supported
  Future<bool> isSupportVideoBackground() async {
    try {
      return await _channel.invokeMethod('isSupportVideoBackground');
    } on PlatformException catch (e) {
      return false;
    }
  }

  /// Get max duration for video dial
  Future<int> getVideoDialDuration() async {
    try {
      final result = await _channel.invokeMethod('getVideoDialDuration');
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("get max duration for video dial fail: ${e.message}");
      return 0;
    }
  }

  /// Get free space for dials
  Future<int> getDialFree() async {
    try {
      final result = await _channel.invokeMethod('getDialFree');
      debugPrint("free space : $result");
      return result as int;
    } on PlatformException catch (e) {
      debugPrint("get free space for dials fail: ${e.message}");
      return 0;
    }
  }
}
