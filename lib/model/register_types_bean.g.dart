// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_types_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterTypesBean _$RegisterTypesBeanFromJson(Map<String, dynamic> json) =>
    RegisterTypesBean(
      (json['reg_way'] as List<dynamic>).map((e) => e as String).toList(),
      json['ip'] as String,
    );

Map<String, dynamic> _$RegisterTypesBeanToJson(RegisterTypesBean instance) =>
    <String, dynamic>{'reg_way': instance.regWay, 'ip': instance.ip};
