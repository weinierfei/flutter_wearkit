import 'package:json_annotation/json_annotation.dart';

part 'alarm_bean.g.dart';

@JsonSerializable()
class AlarmBean {
  @JsonKey(name: '_alarmId')
  int alarmId = -1;

  int hour;

  int minute;

  String? label;

  bool isEnabled;

  int repeat;

  AlarmBean(
    this.alarmId,
    this.hour,
    this.minute,
    this.label,
    this.isEnabled,
    this.repeat,
  );

  factory AlarmBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AlarmBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlarmBeanToJson(this);
}
