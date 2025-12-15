// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sleep_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSleepItem _$WKSleepItemFromJson(Map<String, dynamic> json) => WKSleepItem(
  timestampSeconds: (json['timestampSeconds'] as num).toInt(),
  type: (json['type'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
  belong: (json['belong'] as num).toInt(),
);

Map<String, dynamic> _$WKSleepItemToJson(WKSleepItem instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'type': instance.type,
      'duration': instance.duration,
      'belong': instance.belong,
    };
