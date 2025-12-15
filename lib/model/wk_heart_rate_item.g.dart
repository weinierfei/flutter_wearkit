// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_heart_rate_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKHeartRateItem _$WKHeartRateItemFromJson(Map<String, dynamic> json) =>
    WKHeartRateItem(
      (json['heartRate'] as num).toInt(),
      (json['timestampSeconds'] as num).toInt(),
    );

Map<String, dynamic> _$WKHeartRateItemToJson(WKHeartRateItem instance) =>
    <String, dynamic>{
      'heartRate': instance.heartRate,
      'timestampSeconds': instance.timestampSeconds,
    };
