import 'package:json_annotation/json_annotation.dart';

part 'device_health_ability_bean.g.dart';

@JsonSerializable()
class DeviceHealthAbilityBean {
  bool isSleepAbility;

  bool isHeartRateAbility;

  bool isBloodOxygenAbility;

  bool isBloodPressureAbility;

  bool isPressureAbility;

  bool isWeightAbility;

  bool isTemperatureAbility;

  bool isWomenHealthAbility;

  DeviceHealthAbilityBean({
    this.isSleepAbility = true,
    this.isHeartRateAbility = false,
    this.isBloodOxygenAbility = false,
    this.isBloodPressureAbility = false,
    this.isPressureAbility = false,
    this.isWeightAbility = true,
    this.isTemperatureAbility = false,
    this.isWomenHealthAbility = false,
  });

  factory DeviceHealthAbilityBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DeviceHealthAbilityBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceHealthAbilityBeanToJson(this);

  @override
  String toString() {
    return 'DeviceHealthAbilityBean{isSleepAbility: $isSleepAbility, isHeartRateAbility: $isHeartRateAbility, isBloodOxygenAbility: $isBloodOxygenAbility, isBloodPressureAbility: $isBloodPressureAbility, isPressureAbility: $isPressureAbility, isWeightAbility: $isWeightAbility, isTemperatureAbility: $isTemperatureAbility, isWomenHealthAbility: $isWomenHealthAbility}';
  }
}
