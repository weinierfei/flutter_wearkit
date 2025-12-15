import 'package:json_annotation/json_annotation.dart';

part 'blood_oxygen_record_bean.g.dart';

/// 血氧记录上传数据模型
@JsonSerializable()
class BloodOxygenRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 血氧饱和度值
  final int value;

  /// 设备类型
  final int deviceType;

  BloodOxygenRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.value,
    required this.deviceType,
  });

  factory BloodOxygenRecordBean.fromJson(Map<String, dynamic> json) =>
      _$BloodOxygenRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BloodOxygenRecordBeanToJson(this);
}
