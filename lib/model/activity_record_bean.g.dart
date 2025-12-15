// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRecordBean _$ActivityRecordBeanFromJson(Map<String, dynamic> json) =>
    ActivityRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String,
      timestamp: (json['timestamp'] as num).toInt(),
      steps: (json['steps'] as num?)?.toInt(),
      distance: (json['distance'] as num?)?.toDouble(),
      calories: (json['calories'] as num?)?.toDouble(),
      number: (json['number'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      sportDuration: (json['sportDuration'] as num?)?.toInt(),
      deviceType: (json['deviceType'] as num).toInt(),
    );

Map<String, dynamic> _$ActivityRecordBeanToJson(ActivityRecordBean instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'source': instance.source,
      'timestamp': instance.timestamp,
      'steps': instance.steps,
      'distance': instance.distance,
      'calories': instance.calories,
      'number': instance.number,
      'duration': instance.duration,
      'sportDuration': instance.sportDuration,
      'deviceType': instance.deviceType,
    };
