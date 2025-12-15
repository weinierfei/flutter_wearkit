// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sport_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSportRecord _$WKSportRecordFromJson(Map<String, dynamic> json) =>
    WKSportRecord(
      timestampSeconds: (json['timestampSeconds'] as num).toInt(),
      sportType: (json['sportType'] as num).toInt(),
      launchType: (json['launchType'] as num?)?.toInt() ?? 0,
      endTimestampSeconds: (json['endTimestampSeconds'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      distance: (json['distance'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      steps: (json['steps'] as num).toInt(),
      heartRateDuration: HeartRateDuration.fromJson(
        json['heartRateDuration'] as Map<String, dynamic>,
      ),
      heartRate: IntMaxMinAvg.fromJson(
        json['heartRate'] as Map<String, dynamic>,
      ),
      cadence: IntMaxMinAvg.fromJson(json['cadence'] as Map<String, dynamic>),
      pace: IntMaxMinAvg.fromJson(json['pace'] as Map<String, dynamic>),
      speed: IntMaxMinAvg.fromJson(json['speed'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => WKSportItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      heartRateItems: (json['heartRateItems'] as List<dynamic>?)
          ?.map((e) => WKSportHeartRateItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      displayConfigs: (json['displayConfigs'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      extraJson: json['extraJson'] as String?,
    );

Map<String, dynamic> _$WKSportRecordToJson(WKSportRecord instance) =>
    <String, dynamic>{
      'timestampSeconds': instance.timestampSeconds,
      'sportType': instance.sportType,
      'launchType': instance.launchType,
      'endTimestampSeconds': instance.endTimestampSeconds,
      'duration': instance.duration,
      'distance': instance.distance,
      'calories': instance.calories,
      'steps': instance.steps,
      'heartRateDuration': instance.heartRateDuration,
      'heartRate': instance.heartRate,
      'cadence': instance.cadence,
      'pace': instance.pace,
      'speed': instance.speed,
      'items': instance.items,
      'heartRateItems': instance.heartRateItems,
      'displayConfigs': instance.displayConfigs,
      'extraJson': instance.extraJson,
    };
