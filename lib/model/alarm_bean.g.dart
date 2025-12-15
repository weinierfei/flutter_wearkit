// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlarmBean _$AlarmBeanFromJson(Map<String, dynamic> json) => AlarmBean(
  (json['_alarmId'] as num).toInt(),
  (json['hour'] as num).toInt(),
  (json['minute'] as num).toInt(),
  json['label'] as String?,
  json['isEnabled'] as bool,
  (json['repeat'] as num).toInt(),
);

Map<String, dynamic> _$AlarmBeanToJson(AlarmBean instance) => <String, dynamic>{
  '_alarmId': instance.alarmId,
  'hour': instance.hour,
  'minute': instance.minute,
  'label': instance.label,
  'isEnabled': instance.isEnabled,
  'repeat': instance.repeat,
};
