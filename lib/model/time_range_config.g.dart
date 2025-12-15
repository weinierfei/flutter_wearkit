// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_range_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeRangeConfig _$TimeRangeConfigFromJson(Map<String, dynamic> json) =>
    TimeRangeConfig(
      isEnabled: json['isEnabled'] as bool? ?? false,
      start: (json['start'] as num?)?.toInt() ?? 0,
      end: (json['end'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$TimeRangeConfigToJson(TimeRangeConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'start': instance.start,
      'end': instance.end,
    };
