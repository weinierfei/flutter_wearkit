import 'package:flutter_wearkit/model/wk_sleep_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wk_sleep_segment.g.dart';

@JsonSerializable()
class WKSleepSegment {
  /// 这段睡眠的开始时间戳，单位为秒。
  final int timestampSeconds;

  /// 这段睡眠的总时长，单位为秒，包含[awake]清醒时长。
  ///
  /// 如果想获得有效总睡眠时长，请使用 [duration] 减去 [awake]。
  final int duration;

  /// 这是否是一段小睡？
  final bool isNap;

  /// 深睡时长，单位为秒。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int deep;

  /// 浅睡时长，单位为秒。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int light;

  /// 清醒时长，单位为秒。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int awake;

  /// REM（快速眼动期）时长，单位为秒。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int rem;

  /// 清醒次数。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int awakeCount;

  /// REM（快速眼动期）次数。
  ///
  /// 当 [isNap] 为 true 时，此字段为 0，表示无效。
  final int remCount;

  /// 睡眠详情项。
  ///
  /// 当 [isNap] 为 true 时，此字段为 null，表示无效。
  final List<WKSleepItem>? items;

  const WKSleepSegment({
    required this.timestampSeconds,
    required this.duration,
    required this.isNap,
    this.deep = 0,
    this.light = 0,
    this.awake = 0,
    this.rem = 0,
    this.awakeCount = 0,
    this.remCount = 0,
    this.items,
  });

  factory WKSleepSegment.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSleepSegmentFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSleepSegmentToJson(this);
}
