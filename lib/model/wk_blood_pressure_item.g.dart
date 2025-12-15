// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_blood_pressure_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKBloodPressureItem _$WKBloodPressureItemFromJson(Map<String, dynamic> json) =>
    WKBloodPressureItem(
      sbp: (json['sbp'] as num?)?.toInt() ?? 0,
      dbp: (json['dbp'] as num?)?.toInt() ?? 0,
      timestampSeconds: (json['timestampSeconds'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$WKBloodPressureItemToJson(
  WKBloodPressureItem instance,
) => <String, dynamic>{
  'sbp': instance.sbp,
  'dbp': instance.dbp,
  'timestampSeconds': instance.timestampSeconds,
};
