// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sleep_segment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSleepSegment _$WKSleepSegmentFromJson(Map<String, dynamic> json) =>
    WKSleepSegment(
      timestampSeconds: (json['timestampSeconds'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      isNap: json['isNap'] as bool,
      deep: (json['deep'] as num?)?.toInt() ?? 0,
      light: (json['light'] as num?)?.toInt() ?? 0,
      awake: (json['awake'] as num?)?.toInt() ?? 0,
      rem: (json['rem'] as num?)?.toInt() ?? 0,
      awakeCount: (json['awakeCount'] as num?)?.toInt() ?? 0,
      remCount: (json['remCount'] as num?)?.toInt() ?? 0,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => WKSleepItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WKSleepSegmentToJson(WKSleepSegment instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'duration': instance.duration,
      'isNap': instance.isNap,
      'deep': instance.deep,
      'light': instance.light,
      'awake': instance.awake,
      'rem': instance.rem,
      'awakeCount': instance.awakeCount,
      'remCount': instance.remCount,
      'items': instance.items,
    };
