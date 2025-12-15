// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_record_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportRecordBean _$SportRecordBeanFromJson(Map<String, dynamic> json) =>
    SportRecordBean(
      userId: (json['userId'] as num).toInt(),
      source: json['source'] as String?,
      sportType: (json['sportType'] as num).toInt(),
      beginTime: (json['beginTime'] as num).toInt(),
      endTime: (json['endTime'] as num).toInt(),
      duration: (json['duration'] as num).toDouble(),
      distance: (json['distance'] as num).toDouble(),
      calories: (json['calories'] as num).toDouble(),
      heartRate: (json['heartRate'] as num).toInt(),
      step: (json['step'] as num).toInt(),
      warmTime: (json['warmTime'] as num).toInt(),
      lightTime: (json['lightTime'] as num).toInt(),
      highTime: (json['highTime'] as num).toInt(),
      criticalTime: (json['criticalTime'] as num).toInt(),
      limitTime: (json['limitTime'] as num).toInt(),
      displayConfigs: json['displayConfigs'] as String?,
      deviceType: (json['deviceType'] as num).toInt(),
      sportId: json['sportId'] as String,
      heartRateMax: (json['heartRateMax'] as num).toInt(),
      heartRateMin: (json['heartRateMin'] as num).toInt(),
      sportDataSource: (json['sportDataSource'] as num).toInt(),
    );

Map<String, dynamic> _$SportRecordBeanToJson(SportRecordBean instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'source': instance.source,
      'sportType': instance.sportType,
      'beginTime': instance.beginTime,
      'endTime': instance.endTime,
      'duration': instance.duration,
      'distance': instance.distance,
      'calories': instance.calories,
      'heartRate': instance.heartRate,
      'step': instance.step,
      'warmTime': instance.warmTime,
      'lightTime': instance.lightTime,
      'highTime': instance.highTime,
      'criticalTime': instance.criticalTime,
      'limitTime': instance.limitTime,
      'displayConfigs': instance.displayConfigs,
      'deviceType': instance.deviceType,
      'sportId': instance.sportId,
      'heartRateMax': instance.heartRateMax,
      'heartRateMin': instance.heartRateMin,
      'sportDataSource': instance.sportDataSource,
    };
