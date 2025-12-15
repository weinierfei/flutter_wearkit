import 'package:json_annotation/json_annotation.dart';

part 'time_range_config.g.dart';

@JsonSerializable()
class TimeRangeConfig {
  bool isEnabled = false;

  int start = 0;

  int end = 0;

  TimeRangeConfig({
    this.isEnabled = false,
    this.start = 0,
    this.end = 0,
  });

  factory TimeRangeConfig.fromJson(Map<String, dynamic> srcJson) =>
      _$TimeRangeConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimeRangeConfigToJson(this);
}
