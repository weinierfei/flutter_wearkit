// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_config_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitConfigBean _$UnitConfigBeanFromJson(Map<String, dynamic> json) =>
    UnitConfigBean(
      length: (json['length'] as num).toInt(),
      weight: (json['weight'] as num).toInt(),
      temperature: (json['temperature'] as num).toInt(),
      lastModifyTime: (json['lastModifyTime'] as num).toInt(),
    );

Map<String, dynamic> _$UnitConfigBeanToJson(UnitConfigBean instance) =>
    <String, dynamic>{
      'length': instance.length,
      'weight': instance.weight,
      'temperature': instance.temperature,
      'lastModifyTime': instance.lastModifyTime,
    };
