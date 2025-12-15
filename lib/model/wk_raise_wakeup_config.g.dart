// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_raise_wakeup_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKRaiseWakeupConfig _$WKRaiseWakeupConfigFromJson(Map<String, dynamic> json) =>
    WKRaiseWakeupConfig(
      isEnabled: json['isEnabled'] as bool,
      start: (json['start'] as num).toInt(),
      end: (json['end'] as num).toInt(),
    );

Map<String, dynamic> _$WKRaiseWakeupConfigToJson(
  WKRaiseWakeupConfig instance,
) => <String, dynamic>{
  'isEnabled': instance.isEnabled,
  'start': instance.start,
  'end': instance.end,
};
