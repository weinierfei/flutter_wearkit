// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_oxygen_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodOxygenRecordBean _$BloodOxygenRecordBeanFromJson(
  Map<String, dynamic> json,
) => BloodOxygenRecordBean(
  userId: (json['userId'] as num).toInt(),
  source: json['source'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  value: (json['value'] as num).toInt(),
  deviceType: (json['deviceType'] as num).toInt(),
);

Map<String, dynamic> _$BloodOxygenRecordBeanToJson(
  BloodOxygenRecordBean instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'source': instance.source,
  'timestamp': instance.timestamp,
  'value': instance.value,
  'deviceType': instance.deviceType,
};
