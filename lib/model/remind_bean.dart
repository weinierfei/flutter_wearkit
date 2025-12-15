import 'package:flutter_wearkit/model/time_range_config.dart';
import 'package:json_annotation/json_annotation.dart';

part 'remind_bean.g.dart';

@JsonSerializable()
class RemindBean {
  int type;

  String name;

  String note;

  bool isEnabled;

  TimeRangeConfig dnd = TimeRangeConfig();

  Mode mode;

  List<int>? times;

  int start;

  int end;

  int interval;

  int repeat;

  RemindBean({
    required this.type,
    this.name = "",
    this.note = "",
    this.isEnabled = false,
    TimeRangeConfig? dnd,
    this.mode = Mode.PERIOD,
    this.times = const [],
    this.start = 0,
    this.end = 0,
    this.interval = 60,
    this.repeat = 0,
  }): dnd = dnd ?? TimeRangeConfig(isEnabled: false, start: 0, end: 0);

  factory RemindBean.fromJson(Map<String, dynamic> srcJson) =>
      _$RemindBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RemindBeanToJson(this);
}

enum Mode {
  TIMES,
  PERIOD,
}