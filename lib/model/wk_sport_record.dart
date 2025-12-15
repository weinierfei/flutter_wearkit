import 'package:flutter_wearkit/model/sport_bean.dart';
import 'package:flutter_wearkit/model/wk_sport_heart_rate_item.dart';
import 'package:flutter_wearkit/model/wk_sport_item.dart';
import 'package:json_annotation/json_annotation.dart';

import 'heart_rate_duration.dart';
import 'int_max_min_avg.dart';

part 'wk_sport_record.g.dart';

@JsonSerializable()
class WKSportRecord {
  int timestampSeconds;

  int sportType;

  int launchType;

  int endTimestampSeconds;

  int duration;

  double distance;

  double calories;

  int steps;

  HeartRateDuration heartRateDuration;

  IntMaxMinAvg heartRate;

  IntMaxMinAvg cadence;

  IntMaxMinAvg pace;

  IntMaxMinAvg speed;

  List<WKSportItem>? items;

  List<WKSportHeartRateItem>? heartRateItems;

  List<int>? displayConfigs;

  String? extraJson;

  WKSportRecord({
    required this.timestampSeconds,
    required this.sportType,
    this.launchType = 0,
    required this.endTimestampSeconds,
    required this.duration,
    required this.distance,
    required this.calories,
    required this.steps,
    required this.heartRateDuration,
    required this.heartRate,
    required this.cadence,
    required this.pace,
    required this.speed,
    this.items,
    this.heartRateItems,
    this.displayConfigs,
    this.extraJson,
  });

  factory WKSportRecord.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSportRecordFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSportRecordToJson(this);

  @override
  String toString() {
    return "sportType: $sportType, timestampSeconds: $timestampSeconds, endTimestampSeconds: $endTimestampSeconds, duration: $duration, distance: $distance, calories: $calories, steps: $steps, heartRateDuration: $heartRateDuration, heartRate: $heartRate, cadence: $cadence, pace: $pace, speed: $speed, displayConfigs: $displayConfigs, extraJson: $extraJson";
  }

  static const int SPORT_OUTDOOR_WALK = 0; //户外健走
  static const int SPORT_OUTDOOR_RUN = 1; //户外跑步
  static const int SPORT_CLIMB = 2; //登山
  static const int SPORT_OUTDOOR_RIDE = 3; //户外骑行

  static const int DISPLAY_DURATION = 1; //持续时间
  static const int DISPLAY_HEART_RATE = 2; //心率
  static const int DISPLAY_STEP = 3; //步数
  static const int DISPLAY_DISTANCE = 4; //距离
  static const int DISPLAY_CALORIES = 5; //卡路里
  static const int DISPLAY_AVG_SPEED = 6; //平均速度
  static const int DISPLAY_AVG_PACE = 7; //平均配速
  static const int DISPLAY_AVG_STEP_FREQUENCY = 8; //平均步频
  static const int DISPLAY_AVG_STEP_LENGTH = 9; //平均步幅
  static const int DISPLAY_SUM_RISE = 10; //累计上升
  static const int DISPLAY_SUM_DECLINE = 11; //累计下降
  static const int DISPLAY_SWIM_TRIPS = 12; //游泳趟数
  static const int DISPLAY_SWIM_STROKES = 13; //游泳划水次数
  static const int DISPLAY_SWIM_STYLE = 14; //泳姿
  static const int DISPLAY_SWIM_STROKE_RATE = 15; //划水频率
  static const int DISPLAY_SWIM_EFFICIENCY = 16; //游泳效率

  /// 是否有距离属性
  bool hasDistanceAttr() {
    if (sportType == SportType.OUTDOOR_RUN ||
        sportType == SportType.OUTDOOR_WALK ||
        sportType == SportType.INDOOR_RUN ||
        sportType == SportType.INDOOR_WALK) {
      return true;
    }
    if (sportType == SportType.OUTDOOR_RIDE ||
        sportType == SportType.INDOOR_RIDE) {
      return distance > 0;
    }
    return false;
  }

  /// 是否有步数这个属性
  bool hasStepAttr() {
    if (sportType == SportType.OUTDOOR_RUN ||
        sportType == SportType.OUTDOOR_WALK ||
        sportType == SportType.INDOOR_RUN ||
        sportType == SportType.INDOOR_WALK ||
        sportType == SportType.MOUNTAINEERING) {
      return true;
    }
    return false;
  }

  /// 获取运动数据的显示配置（
  List<int> getDisplayConfig() {
    // 情况1：配置字符串为空或空，动态生成配置
    if (displayConfigs == null || displayConfigs!.isEmpty) {
      final configList = <int>[];

      // 根据属性添加基础数据项
      if (hasDistanceAttr()) {
        configList.add(DISPLAY_DISTANCE);
      }
      if (hasStepAttr()) {
        configList.add(DISPLAY_STEP);
      }
      configList.add(DISPLAY_CALORIES);
      // 确保时长始终在第二位
      configList.insert(1, DISPLAY_DURATION);

      // 添加心率数据（条件判断）
      if (heartRate.avg > 0) {
        configList.add(DISPLAY_HEART_RATE);
      }

      // 根据属性添加高级数据项
      if (hasDistanceAttr()) {
        configList.add(DISPLAY_AVG_SPEED);
        configList.add(DISPLAY_AVG_PACE);
      }
      if (hasStepAttr()) {
        configList.add(DISPLAY_AVG_STEP_FREQUENCY);
      }
      if (hasDistanceAttr() && hasStepAttr()) {
        configList.add(DISPLAY_AVG_STEP_LENGTH);
      }

      return configList;
    } else {
      return displayConfigs!;
    }
  }
}
