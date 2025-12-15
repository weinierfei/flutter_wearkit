// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sport_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSportItem _$WKSportItemFromJson(Map<String, dynamic> json) => WKSportItem(
  (json['timestampSeconds'] as num).toInt(),
  (json['duration'] as num).toInt(),
  (json['distance'] as num).toDouble(),
  (json['calories'] as num).toDouble(),
  (json['steps'] as num).toInt(),
);

Map<String, dynamic> _$WKSportItemToJson(WKSportItem instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'duration': instance.duration,
      'distance': instance.distance,
      'calories': instance.calories,
      'steps': instance.steps,
    };
