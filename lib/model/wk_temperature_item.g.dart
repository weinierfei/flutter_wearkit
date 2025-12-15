// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_temperature_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKTemperatureItem _$WKTemperatureItemFromJson(Map<String, dynamic> json) =>
    WKTemperatureItem(
      (json['body'] as num).toDouble(),
      (json['wrist'] as num).toDouble(),
      (json['timestampSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$WKTemperatureItemToJson(WKTemperatureItem instance) =>
    <String, dynamic>{
      'body': instance.body,
      'wrist': instance.wrist,
      'timestampSeconds': instance.timestampSeconds,
    };
