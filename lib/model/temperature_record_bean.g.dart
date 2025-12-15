// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'temperature_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TemperatureRecordBean _$TemperatureRecordBeanFromJson(
  Map<String, dynamic> json,
) => TemperatureRecordBean(
  userId: (json['userId'] as num).toInt(),
  source: json['source'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  body: (json['body'] as num).toDouble(),
  wrist: (json['wrist'] as num).toDouble(),
  deviceType: (json['deviceType'] as num).toInt(),
);

Map<String, dynamic> _$TemperatureRecordBeanToJson(
  TemperatureRecordBean instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'source': instance.source,
  'timestamp': instance.timestamp,
  'body': instance.body,
  'wrist': instance.wrist,
  'deviceType': instance.deviceType,
};
