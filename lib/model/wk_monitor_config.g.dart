// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_monitor_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKMonitorConfig _$WKMonitorConfigFromJson(Map<String, dynamic> json) =>
    WKMonitorConfig(
      json['isEnabled'] as bool,
      (json['start'] as num).toInt(),
      (json['end'] as num).toInt(),
      (json['interval'] as num).toInt(),
    );

Map<String, dynamic> _$WKMonitorConfigToJson(WKMonitorConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'start': instance.start,
      'end': instance.end,
      'interval': instance.interval,
    };
