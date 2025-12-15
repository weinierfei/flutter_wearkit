// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_pressure_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKPressureItem _$WKPressureItemFromJson(Map<String, dynamic> json) =>
    WKPressureItem(
      (json['pressure'] as num).toInt(),
      (json['timestampSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$WKPressureItemToJson(WKPressureItem instance) =>
    <String, dynamic>{
      'pressure': instance.pressure,
      'timestampSeconds': instance.timestampSeconds,
    };
