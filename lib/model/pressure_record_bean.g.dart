// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pressure_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PressureRecordBean _$PressureRecordBeanFromJson(Map<String, dynamic> json) =>
    PressureRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      value: (json['value'] as num).toInt(),
      deviceType: (json['deviceType'] as num).toInt(),
    );

Map<String, dynamic> _$PressureRecordBeanToJson(PressureRecordBean instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'source': instance.source,
      'timestamp': instance.timestamp,
      'value': instance.value,
      'deviceType': instance.deviceType,
    };
