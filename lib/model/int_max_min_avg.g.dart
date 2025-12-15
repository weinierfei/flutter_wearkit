// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'int_max_min_avg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IntMaxMinAvg _$IntMaxMinAvgFromJson(Map<String, dynamic> json) => IntMaxMinAvg(
  max: (json['max'] as num?)?.toInt() ?? 0,
  min: (json['min'] as num?)?.toInt() ?? 0,
  avg: (json['avg'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$IntMaxMinAvgToJson(IntMaxMinAvg instance) =>
    <String, dynamic>{
      'max': instance.max,
      'min': instance.min,
      'avg': instance.avg,
    };
