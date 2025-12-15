import 'package:json_annotation/json_annotation.dart';
part 'wk_sleep_item.g.dart';

@JsonSerializable()
class WKSleepItem {
  /// 时间戳（秒）
  final int timestampSeconds;

  /// 睡眠类型
  final int type;

  /// 持续时间（秒）
  final int duration;

  /// 所属日期的时间戳
  final int belong;

  WKSleepItem({
    required this.timestampSeconds,
    required this.type,
    required this.duration,
    required this.belong,
  });

  factory WKSleepItem.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSleepItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSleepItemToJson(this);

  @override
  String toString() {
    return 'WKSleepItem{timestampSeconds: $timestampSeconds, type: $type, duration: $duration, belong: $belong}';
  }
}
