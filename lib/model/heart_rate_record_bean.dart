import 'package:json_annotation/json_annotation.dart';

part 'heart_rate_record_bean.g.dart';

/// 心率记录上传数据模型
@JsonSerializable()
class HeartRateRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 心率值
  final int value;

  /// 设备类型
  final int deviceType;

  HeartRateRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.value,
    required this.deviceType,
  });

  factory HeartRateRecordBean.fromJson(Map<String, dynamic> json) =>
      _$HeartRateRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$HeartRateRecordBeanToJson(this);
}
