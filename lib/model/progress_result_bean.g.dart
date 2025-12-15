// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_result_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressResultBean _$ProgressResultBeanFromJson(Map<String, dynamic> json) =>
    ProgressResultBean(
      (json['progress'] as num).toInt(),
      json['result'] as String?,
    );

Map<String, dynamic> _$ProgressResultBeanToJson(ProgressResultBean instance) =>
    <String, dynamic>{'progress': instance.progress, 'result': instance.result};
