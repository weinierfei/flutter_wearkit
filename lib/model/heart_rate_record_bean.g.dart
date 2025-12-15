// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_rate_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartRateRecordBean _$HeartRateRecordBeanFromJson(Map<String, dynamic> json) =>
    HeartRateRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      value: (json['value'] as num).toInt(),
      deviceType: (json['deviceType'] as num).toInt(),
    );

Map<String, dynamic> _$HeartRateRecordBeanToJson(
  HeartRateRecordBean instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'source': instance.source,
  'timestamp': instance.timestamp,
  'value': instance.value,
  'deviceType': instance.deviceType,
};
