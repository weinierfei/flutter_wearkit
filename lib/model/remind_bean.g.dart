// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemindBean _$RemindBeanFromJson(Map<String, dynamic> json) => RemindBean(
  type: (json['type'] as num).toInt(),
  name: json['name'] as String? ?? "",
  note: json['note'] as String? ?? "",
  isEnabled: json['isEnabled'] as bool? ?? false,
  dnd: json['dnd'] == null
      ? null
      : TimeRangeConfig.fromJson(json['dnd'] as Map<String, dynamic>),
  mode: $enumDecodeNullable(_$ModeEnumMap, json['mode']) ?? Mode.PERIOD,
  times:
      (json['times'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  start: (json['start'] as num?)?.toInt() ?? 0,
  end: (json['end'] as num?)?.toInt() ?? 0,
  interval: (json['interval'] as num?)?.toInt() ?? 60,
  repeat: (json['repeat'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$RemindBeanToJson(RemindBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'name': instance.name,
      'note': instance.note,
      'isEnabled': instance.isEnabled,
      'dnd': instance.dnd,
      'mode': _$ModeEnumMap[instance.mode]!,
      'times': instance.times,
      'start': instance.start,
      'end': instance.end,
      'interval': instance.interval,
      'repeat': instance.repeat,
    };

const _$ModeEnumMap = {Mode.TIMES: 'TIMES', Mode.PERIOD: 'PERIOD'};
