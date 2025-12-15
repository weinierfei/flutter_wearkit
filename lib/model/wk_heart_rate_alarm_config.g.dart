// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_heart_rate_alarm_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WkHeartRateAlarmConfig _$WkHeartRateAlarmConfigFromJson(
  Map<String, dynamic> json,
) => WkHeartRateAlarmConfig(
  exercise: WkBaseAlarmConfig.fromJson(
    json['exercise'] as Map<String, dynamic>,
  ),
  resting: WkBaseAlarmConfig.fromJson(json['resting'] as Map<String, dynamic>),
);

Map<String, dynamic> _$WkHeartRateAlarmConfigToJson(
  WkHeartRateAlarmConfig instance,
) => <String, dynamic>{
  'exercise': instance.exercise,
  'resting': instance.resting,
};
