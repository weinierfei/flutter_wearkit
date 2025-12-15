// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_item_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SleepItemRecordBean _$SleepItemRecordBeanFromJson(Map<String, dynamic> json) =>
    SleepItemRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      type: (json['type'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      belongDay: (json['belongDay'] as num).toInt(),
      deviceType: (json['deviceType'] as num).toInt(),
    );

Map<String, dynamic> _$SleepItemRecordBeanToJson(
  SleepItemRecordBean instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'source': instance.source,
  'timestamp': instance.timestamp,
  'type': instance.type,
  'duration': instance.duration,
  'belongDay': instance.belongDay,
  'deviceType': instance.deviceType,
};
