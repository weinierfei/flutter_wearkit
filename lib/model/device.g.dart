// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  name: json['name'] as String,
  mac: json['mac'] as String,
  type: json['type'] as String,
  productType: json['productType'] as String,
  deviceId: json['deviceid'] as String,
  code: json['code'] as String?,
  rssi: (json['rssi'] as num?)?.toInt() ?? 0,
  deviceInfo: json['deviceInfo'] == null
      ? null
      : DeviceInfo.fromJson(json['deviceInfo'] as Map<String, dynamic>),
  isTryingBind: json['isTryingBind'] as bool? ?? false,
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  'name': instance.name,
  'mac': instance.mac,
  'type': instance.type,
  'productType': instance.productType,
  'code': instance.code,
  'rssi': instance.rssi,
  'deviceid': instance.deviceId,
  'isTryingBind': instance.isTryingBind,
  'deviceInfo': instance.deviceInfo,
};
