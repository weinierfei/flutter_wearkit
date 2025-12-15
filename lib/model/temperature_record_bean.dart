import 'package:json_annotation/json_annotation.dart';

part 'temperature_record_bean.g.dart';

/// 体温记录上传数据模型
@JsonSerializable()
class TemperatureRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  final double body;

  final double wrist;

  /// 设备类型
  final int deviceType;

  TemperatureRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.body,
    required this.wrist,
    required this.deviceType,
  });

  factory TemperatureRecordBean.fromJson(Map<String, dynamic> json) =>
      _$TemperatureRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$TemperatureRecordBeanToJson(this);
}
