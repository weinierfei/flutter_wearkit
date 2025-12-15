// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blood_pressure_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BloodPressureRecordBean _$BloodPressureRecordBeanFromJson(
  Map<String, dynamic> json,
) => BloodPressureRecordBean(
  userId: (json['userId'] as num).toInt(),
  source: json['source'] as String,
  timestamp: (json['timestamp'] as num).toInt(),
  sbp: (json['sbp'] as num).toInt(),
  dbp: (json['dbp'] as num).toInt(),
  deviceType: (json['deviceType'] as num).toInt(),
);

Map<String, dynamic> _$BloodPressureRecordBeanToJson(
  BloodPressureRecordBean instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'source': instance.source,
  'timestamp': instance.timestamp,
  'sbp': instance.sbp,
  'dbp': instance.dbp,
  'deviceType': instance.deviceType,
};
