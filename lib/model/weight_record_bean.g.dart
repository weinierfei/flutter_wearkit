// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weight_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeightRecordBean _$WeightRecordBeanFromJson(Map<String, dynamic> json) =>
    WeightRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      value: (json['value'] as num).toDouble(),
      deviceType: (json['deviceType'] as num).toInt(),
    );

Map<String, dynamic> _$WeightRecordBeanToJson(WeightRecordBean instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'source': instance.source,
      'timestamp': instance.timestamp,
      'value': instance.value,
      'deviceType': instance.deviceType,
    };
