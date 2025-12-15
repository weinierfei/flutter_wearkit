import 'package:json_annotation/json_annotation.dart';

part 'sleep_item_record_bean.g.dart';

@JsonSerializable()
class SleepItemRecordBean {
  final int userId;
  final String source;
  final int timestamp;
  final int type;
  final int duration;
  final int belongDay;
  final int deviceType;

  SleepItemRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.type,
    required this.duration,
    required this.belongDay,
    required this.deviceType,
  });


  factory SleepItemRecordBean.fromJson(Map<String, dynamic> srcJson) =>
      _$SleepItemRecordBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SleepItemRecordBeanToJson(this);
}
