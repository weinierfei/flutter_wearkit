// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityItem _$ActivityItemFromJson(Map<String, dynamic> json) => ActivityItem(
  (json['timestampSeconds'] as num).toInt(),
  (json['steps'] as num).toInt(),
  (json['distance'] as num).toDouble(),
  (json['calories'] as num).toDouble(),
  (json['duration'] as num).toInt(),
  (json['number'] as num).toInt(),
  (json['sportDuration'] as num).toInt(),
);

Map<String, dynamic> _$ActivityItemToJson(ActivityItem instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'steps': instance.steps,
      'distance': instance.distance,
      'calories': instance.calories,
      'duration': instance.duration,
      'number': instance.number,
      'sportDuration': instance.sportDuration,
    };
