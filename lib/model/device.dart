import 'package:json_annotation/json_annotation.dart';

import 'device_info.dart';

part 'device.g.dart';

@JsonSerializable()
class Device {
  final String name;
  final String mac;
  final String type;
  final String productType;
  final String? code;
  final int rssi;
  @JsonKey(name: 'deviceid')
  final String deviceId;
  bool isTryingBind;
  DeviceInfo? deviceInfo;

  Map<String, dynamic> toJson() => _$DeviceToJson(this);

  factory Device.fromJson(Map<String, dynamic> json) => _$DeviceFromJson(json);

  Device({
    required this.name,
    required this.mac,
    required this.type,
    required this.productType,
    required this.deviceId,
    this.code,
    this.rssi = 0,
    this.deviceInfo,
    this.isTryingBind = false,
  });

  @override
  String toString() {
    return 'Device(  address:$mac, name:$name, type:$type, productType:$productType, isTryingBind:$isTryingBind  )';
  }
}

class WKDeviceType {
  static const String FIT_CLOUD = "FIT_CLOUD";
  static const String FLY_WEAR = "FLY_WEAR";
  static const String SHEN_JU = "SHEN_JU";
  static const String PROTO_TB = "PROTO_TB";
}
