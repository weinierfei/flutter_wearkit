import 'package:json_annotation/json_annotation.dart';

part 'activity_record_bean.g.dart';

/// 活动记录上传数据模型
@JsonSerializable()
class ActivityRecordBean {
  /// 用户ID
  final int userId;

  /// 数据来源
  final String source;

  /// 时间戳（秒）
  final int timestamp;

  /// 步数
  final int? steps;

  /// 距离（米）
  final double? distance;

  /// 活动热量（千卡）
  final double? calories;

  /// 活动次数
  final int? number;

  /// 活动时长（分钟）
  final int? duration;

  /// 锻炼时长（分钟）
  final int? sportDuration;

  /// 设备类型
  final int deviceType;

  ActivityRecordBean({
    required this.userId,
    required this.source,
    required this.timestamp,
    this.steps,
    this.distance,
    this.calories,
    this.number,
    this.duration,
    this.sportDuration,
    required this.deviceType,
  });

  factory ActivityRecordBean.fromJson(Map<String, dynamic> json) =>
      _$ActivityRecordBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRecordBeanToJson(this);
}
