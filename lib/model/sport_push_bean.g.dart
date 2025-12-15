// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sport_push_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SportPushBean _$SportPushBeanFromJson(Map<String, dynamic> json) =>
    SportPushBean(
      (json['sportType'] as num).toInt(),
      json['replaceable'] as bool,
    );

Map<String, dynamic> _$SportPushBeanToJson(SportPushBean instance) =>
    <String, dynamic>{
      'sportType': instance.sportType,
      'replaceable': instance.replaceable,
    };
