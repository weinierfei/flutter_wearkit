// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sport_heart_rate_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSportHeartRateItem _$WKSportHeartRateItemFromJson(
  Map<String, dynamic> json,
) => WKSportHeartRateItem(
  (json['timestampSeconds'] as num).toInt(),
  (json['duration'] as num).toInt(),
  (json['heartRate'] as num).toInt(),
);

Map<String, dynamic> _$WKSportHeartRateItemToJson(
  WKSportHeartRateItem instance,
) => <String, dynamic>{
  'timestampSeconds': instance.timestampSeconds,
  'duration': instance.duration,
  'heartRate': instance.heartRate,
};
