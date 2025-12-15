// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sleep_daily.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSleepDaily _$WKSleepDailyFromJson(Map<String, dynamic> json) => WKSleepDaily(
  timestampSeconds: (json['timestampSeconds'] as num).toInt(),
  algorithm: $enumDecode(_$WKSleepAlgorithmEnumMap, json['algorithm']),
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => WKSleepItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  duration: (json['duration'] as num?)?.toInt() ?? 0,
  deep: (json['deep'] as num?)?.toInt() ?? 0,
  light: (json['light'] as num?)?.toInt() ?? 0,
  awake: (json['awake'] as num?)?.toInt() ?? 0,
  rem: (json['rem'] as num?)?.toInt() ?? 0,
  nap: (json['nap'] as num?)?.toInt() ?? 0,
  awakeCount: (json['awakeCount'] as num?)?.toInt() ?? 0,
  remCount: (json['remCount'] as num?)?.toInt() ?? 0,
  allSegments: (json['allSegments'] as List<dynamic>?)
      ?.map((e) => WKSleepSegment.fromJson(e as Map<String, dynamic>))
      .toList(),
  nightSegments: (json['nightSegments'] as List<dynamic>?)
      ?.map((e) => WKSleepSegment.fromJson(e as Map<String, dynamic>))
      .toList(),
  napSegments: (json['napSegments'] as List<dynamic>?)
      ?.map((e) => WKSleepSegment.fromJson(e as Map<String, dynamic>))
      .toList(),
  mainSegment: json['mainSegment'] == null
      ? null
      : WKSleepSegment.fromJson(json['mainSegment'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WKSleepDailyToJson(WKSleepDaily instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'algorithm': _$WKSleepAlgorithmEnumMap[instance.algorithm]!,
      'items': instance.items,
      'duration': instance.duration,
      'deep': instance.deep,
      'light': instance.light,
      'awake': instance.awake,
      'rem': instance.rem,
      'nap': instance.nap,
      'awakeCount': instance.awakeCount,
      'remCount': instance.remCount,
      'allSegments': instance.allSegments,
      'nightSegments': instance.nightSegments,
      'napSegments': instance.napSegments,
      'mainSegment': instance.mainSegment,
    };

const _$WKSleepAlgorithmEnumMap = {
  WKSleepAlgorithm.FITCLOUD_DEFAULT: 'FITCLOUD_DEFAULT',
  WKSleepAlgorithm.FITCLOUD_NAP: 'FITCLOUD_NAP',
  WKSleepAlgorithm.FLYWEAR_DEFAULT: 'FLYWEAR_DEFAULT',
  WKSleepAlgorithm.FLYWEAR_ORAIMO: 'FLYWEAR_ORAIMO',
  WKSleepAlgorithm.SHENJU_DEFAULT: 'SHENJU_DEFAULT',
};
