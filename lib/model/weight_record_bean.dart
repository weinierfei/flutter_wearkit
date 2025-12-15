import 'package:json_annotation/json_annotation.dart';

part 'weight_record_bean.g.dart';

/// 体重记录上传数据模型
@JsonSerializable()
class WeightRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 体重值（千克）
  final double value;

  /// 设备类型
  final int deviceType;

  WeightRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.value,
    required this.deviceType,
  });

  factory WeightRecordBean.fromJson(Map<String, dynamic> json) =>
      _$WeightRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$WeightRecordBeanToJson(this);
}
