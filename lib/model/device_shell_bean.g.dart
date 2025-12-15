// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_shell_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceShellBean _$DeviceShellBeanFromJson(Map<String, dynamic> json) =>
    DeviceShellBean(
      (json['image_type'] as num).toInt(),
      json['image_file'] as String,
    );

Map<String, dynamic> _$DeviceShellBeanToJson(DeviceShellBean instance) =>
    <String, dynamic>{
      'image_type': instance.imageType,
      'image_file': instance.imageFile,
    };
