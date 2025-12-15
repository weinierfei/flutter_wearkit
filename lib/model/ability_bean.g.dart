// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ability_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AbilityBean _$AbilityBeanFromJson(Map<String, dynamic> json) => AbilityBean(
  json['ablity_name'] as String,
  json['ability_provider'] as String,
  json['ablity'] as bool,
);

Map<String, dynamic> _$AbilityBeanToJson(AbilityBean instance) =>
    <String, dynamic>{
      'ablity_name': instance.abilityName,
      'ability_provider': instance.abilityProvider,
      'ablity': instance.ability,
    };
