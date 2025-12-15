import 'package:json_annotation/json_annotation.dart';

part 'pressure_record_bean.g.dart';

/// 压力记录上传数据模型
@JsonSerializable()
class PressureRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 压力值
  final int value;

  /// 设备类型
  final int deviceType;

  PressureRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.value,
    required this.deviceType,
  });

  factory PressureRecordBean.fromJson(Map<String, dynamic> json) =>
      _$PressureRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$PressureRecordBeanToJson(this);
}
