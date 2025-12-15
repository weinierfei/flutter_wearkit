// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_blood_oxygen_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKBloodOxygenItem _$WKBloodOxygenItemFromJson(Map<String, dynamic> json) =>
    WKBloodOxygenItem(
      (json['oxygen'] as num).toInt(),
      (json['timestampSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$WKBloodOxygenItemToJson(WKBloodOxygenItem instance) =>
    <String, dynamic>{
      'oxygen': instance.oxygen,
      'timestampSeconds': instance.timestampSeconds,
    };
