import 'package:json_annotation/json_annotation.dart';

part 'sport_record_bean.g.dart';

@JsonSerializable()
class SportRecordBean {
  final int userId;

  final String? source;

  final int sportType;

  final int beginTime;

  final int endTime;

  final double duration;

  final double distance;

  final double calories;

  final int heartRate;

  final int step;

  final int warmTime;

  final int lightTime;

  final int highTime;

  final int criticalTime;

  final int limitTime;

  final String? displayConfigs;

  final int deviceType;

  final String sportId;

  final int heartRateMax;

  final int heartRateMin;

  final int sportDataSource;

  SportRecordBean({
    required this.userId,
    this.source,
    required this.sportType,
    required this.beginTime,
    required this.endTime,
    required this.duration,
    required this.distance,
    required this.calories,
    required this.heartRate,
    required this.step,
    required this.warmTime,
    required this.lightTime,
    required this.highTime,
    required this.criticalTime,
    required this.limitTime,
    this.displayConfigs,
    required this.deviceType,
    required this.sportId,
    required this.heartRateMax,
    required this.heartRateMin,
    required this.sportDataSource,
  });

  factory SportRecordBean.fromJson(Map<String, dynamic> srcJson) =>
      _$SportRecordBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SportRecordBeanToJson(this);
}
