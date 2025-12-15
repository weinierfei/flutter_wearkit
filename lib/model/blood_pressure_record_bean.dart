import 'package:json_annotation/json_annotation.dart';

part 'blood_pressure_record_bean.g.dart';

/// 血压记录上传数据模型
@JsonSerializable()
class BloodPressureRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 收缩压
  final int sbp;

  /// 舒张压
  final int dbp;

  /// 设备类型
  final int deviceType;

  BloodPressureRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    required this.sbp,
    required this.dbp,
    required this.deviceType,
  });

  factory BloodPressureRecordBean.fromJson(Map<String, dynamic> json) =>
      _$BloodPressureRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$BloodPressureRecordBeanToJson(this);
}
