// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_bind_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceBindBean _$DeviceBindBeanFromJson(Map<String, dynamic> json) =>
    DeviceBindBean(
      json['name'] as String,
      json['address'] as String,
      (json['type'] as num).toInt(),
      json['hardwareInfo'] as String,
      json['productType'] as String,
      (json['isUnBind'] as num).toInt(),
      (json['lastModifyTime'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceBindBeanToJson(DeviceBindBean instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'type': instance.type,
      'hardwareInfo': instance.hardwareInfo,
      'productType': instance.productType,
      'isUnBind': instance.isUnBind,
      'lastModifyTime': instance.lastModifyTime,
    };
