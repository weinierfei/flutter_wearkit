// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aigc_type_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AIgcTypeBean _$AIgcTypeBeanFromJson(Map<String, dynamic> json) => AIgcTypeBean(
  (json['id'] as num).toInt(),
  json['name'] as String,
  (json['algorithm'] as List<dynamic>)
      .map((e) => Algorithm.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AIgcTypeBeanToJson(AIgcTypeBean instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'algorithm': instance.algorithm,
    };

Algorithm _$AlgorithmFromJson(Map<String, dynamic> json) => Algorithm(
  json['Id'] as String,
  json['Url'] as String,
  json['Name'] as String,
);

Map<String, dynamic> _$AlgorithmToJson(Algorithm instance) => <String, dynamic>{
  'Id': instance.id,
  'Url': instance.url,
  'Name': instance.name,
};
