import 'package:json_annotation/json_annotation.dart';

part 'ability_bean.g.dart';

@JsonSerializable()
class AbilityBean {
  @JsonKey(name: 'ablity_name')
  String abilityName;

  @JsonKey(name: 'ability_provider')
  String abilityProvider;

  @JsonKey(name: 'ablity')
  bool ability;

  AbilityBean(
    this.abilityName,
    this.abilityProvider,
    this.ability,
  );

  factory AbilityBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AbilityBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AbilityBeanToJson(this);
}

extension AbilityListExtension on List<AbilityBean> {
  bool getAbility(String key) {
    try {
      return firstWhere((ability) => ability.abilityName == key).ability;
    } on StateError {
      return false;
    }
  }
}