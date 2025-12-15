// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_total_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportTotalBean _$SportTotalBeanFromJson(Map<String, dynamic> json) =>
    SportTotalBean(
      count: (json['count'] as num?)?.toInt() ?? 0,
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      dirty: (json['dirty'] as num?)?.toInt() ?? DirtyStatus.FALSE,
      syncSuccessTime: (json['syncSuccessTime'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$SportTotalBeanToJson(SportTotalBean instance) =>
    <String, dynamic>{
      'count': instance.count,
      'distance': instance.distance,
      'dirty': instance.dirty,
      'syncSuccessTime': instance.syncSuccessTime,
    };
