// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_health_ability_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceHealthAbilityBean _$DeviceHealthAbilityBeanFromJson(
  Map<String, dynamic> json,
) => DeviceHealthAbilityBean(
  isSleepAbility: json['isSleepAbility'] as bool? ?? true,
  isHeartRateAbility: json['isHeartRateAbility'] as bool? ?? false,
  isBloodOxygenAbility: json['isBloodOxygenAbility'] as bool? ?? false,
  isBloodPressureAbility: json['isBloodPressureAbility'] as bool? ?? false,
  isPressureAbility: json['isPressureAbility'] as bool? ?? false,
  isWeightAbility: json['isWeightAbility'] as bool? ?? true,
  isTemperatureAbility: json['isTemperatureAbility'] as bool? ?? false,
  isWomenHealthAbility: json['isWomenHealthAbility'] as bool? ?? false,
);

Map<String, dynamic> _$DeviceHealthAbilityBeanToJson(
  DeviceHealthAbilityBean instance,
) => <String, dynamic>{
  'isSleepAbility': instance.isSleepAbility,
  'isHeartRateAbility': instance.isHeartRateAbility,
  'isBloodOxygenAbility': instance.isBloodOxygenAbility,
  'isBloodPressureAbility': instance.isBloodPressureAbility,
  'isPressureAbility': instance.isPressureAbility,
  'isWeightAbility': instance.isWeightAbility,
  'isTemperatureAbility': instance.isTemperatureAbility,
  'isWomenHealthAbility': instance.isWomenHealthAbility,
};
