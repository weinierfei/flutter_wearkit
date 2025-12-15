// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_data_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportDataBean _$SportDataBeanFromJson(Map<String, dynamic> json) =>
    SportDataBean(
      type: (json['type'] as num).toInt(),
      value: json['value'] as String? ?? "",
      unit: json['unit'] as String? ?? "",
      text: json['text'] as String? ?? "",
    );

Map<String, dynamic> _$SportDataBeanToJson(SportDataBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'value': instance.value,
      'unit': instance.unit,
      'text': instance.text,
    };
