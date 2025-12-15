import 'package:json_annotation/json_annotation.dart';

part 'wk_raise_wakeup_config.g.dart';

/// 翻腕亮屏配置模型
@JsonSerializable()
class WKRaiseWakeupConfig {
  /// 是否开启翻腕亮屏
  final bool isEnabled;

  /// 开始时间（以分钟为单位，从00:00开始计算）
  final int start;

  /// 结束时间（以分钟为单位，从00:00开始计算）
  final int end;

  const WKRaiseWakeupConfig({
    required this.isEnabled,
    required this.start,
    required this.end,
  });

  factory WKRaiseWakeupConfig.fromJson(Map<String, dynamic> json) =>
      _$WKRaiseWakeupConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WKRaiseWakeupConfigToJson(this);

  WKRaiseWakeupConfig copyWith({
    bool? isEnabled,
    int? start,
    int? end,
  }) {
    return WKRaiseWakeupConfig(
      isEnabled: isEnabled ?? this.isEnabled,
      start: start ?? this.start,
      end: end ?? this.end,
    );
  }

  @override
  String toString() {
    return 'WKRaiseWakeupConfig(isEnabled: $isEnabled, start: $start, end: $end)';
  }
}
