// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'heart_rate_duration.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HeartRateDuration _$HeartRateDurationFromJson(Map<String, dynamic> json) =>
    HeartRateDuration(
      warmUp: (json['warmUp'] as num?)?.toInt() ?? 0,
      fatBurning: (json['fatBurning'] as num?)?.toInt() ?? 0,
      aerobic: (json['aerobic'] as num?)?.toInt() ?? 0,
      anaerobic: (json['anaerobic'] as num?)?.toInt() ?? 0,
      heartLimit: (json['heartLimit'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$HeartRateDurationToJson(HeartRateDuration instance) =>
    <String, dynamic>{
      'warmUp': instance.warmUp,
      'fatBurning': instance.fatBurning,
      'aerobic': instance.aerobic,
      'anaerobic': instance.anaerobic,
      'heartLimit': instance.heartLimit,
    };
