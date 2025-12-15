// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_base_alarm_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WkBaseAlarmConfig _$WkBaseAlarmConfigFromJson(Map<String, dynamic> json) =>
    WkBaseAlarmConfig(
      isEnabled: json['isEnabled'] as bool? ?? false,
      min: (json['min'] as num?)?.toInt() ?? 0,
      max: (json['max'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WkBaseAlarmConfigToJson(WkBaseAlarmConfig instance) =>
    <String, dynamic>{
      'isEnabled': instance.isEnabled,
      'min': instance.min,
      'max': instance.max,
    };
