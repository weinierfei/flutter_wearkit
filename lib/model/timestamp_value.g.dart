// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timestamp_value.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimestampValue _$TimestampValueFromJson(Map<String, dynamic> json) =>
    TimestampValue(
      (json['timestamp'] as num).toInt(),
      (json['value'] as num).toDouble(),
      (json['value2'] as num).toDouble(),
    );

Map<String, dynamic> _$TimestampValueToJson(TimestampValue instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      'value': instance.value,
      'value2': instance.value2,
    };
