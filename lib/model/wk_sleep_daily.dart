import 'package:flutter_wearkit/model/wk_sleep_item.dart';
import 'package:flutter_wearkit/model/wk_sleep_algorithm.dart';
import 'package:flutter_wearkit/model/wk_sleep_segment.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wk_sleep_daily.g.dart';

/// 每日睡眠数据模型
@JsonSerializable()
class WKSleepDaily {
  /// 某一天的秒级时间戳。例如：2022-01-01 00:00:00
  final int timestampSeconds;

  /// 使用的睡眠算法
  final WKSleepAlgorithm algorithm;

  /// 当天的原始睡眠数据项
  final List<WKSleepItem>? items;

  /// 总睡眠时长，单位为秒，包含[awake]清醒时长。
  ///
  /// 如果想获得有效总睡眠时长，请使用 [duration] 减去 [awake]。
  final int duration;

  /// 深睡时长，单位为秒。
  final int deep;

  /// 浅睡时长，单位为秒。
  final int light;

  /// 清醒时长，单位为秒。
  final int awake;

  /// REM（快速眼动期）时长，单位为秒。
  final int rem;

  /// 小睡时长，单位为秒。
  final int nap;

  /// 清醒次数。
  final int awakeCount;

  /// REM（快速眼动期）次数。
  final int remCount;

  /// 当天所有的睡眠片段。
  final List<WKSleepSegment>? allSegments;

  /// 当天的夜间睡眠片段。
  final List<WKSleepSegment>? nightSegments;

  /// 当天的小睡片段。
  final List<WKSleepSegment>? napSegments;

  /// 最主要的睡眠片段。通常是 [nightSegments] 中最长的一段。
  final WKSleepSegment? mainSegment;

  const WKSleepDaily({
    required this.timestampSeconds,
    required this.algorithm,
    this.items,
    this.duration = 0,
    this.deep = 0,
    this.light = 0,
    this.awake = 0,
    this.rem = 0,
    this.nap = 0,
    this.awakeCount = 0,
    this.remCount = 0,
    this.allSegments,
    this.nightSegments,
    this.napSegments,
    this.mainSegment,
  });

  factory WKSleepDaily.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSleepDailyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSleepDailyToJson(this);

  @override
  String toString() {
    return 'WKSleepDaily{timestampSeconds: $timestampSeconds, algorithm: $algorithm, items: $items, duration: $duration, deep: $deep, light: $light, awake: $awake, rem: $rem, nap: $nap, awakeCount: $awakeCount, remCount: $remCount, allSegments: $allSegments, nightSegments: $nightSegments, napSegments: $napSegments, mainSegment: $mainSegment}';
  }
}
