import 'package:json_annotation/json_annotation.dart';

part 'wk_base_alarm_config.g.dart'; // This will be generated

@JsonSerializable()
class WkBaseAlarmConfig {
  final bool isEnabled;

  final int min;

  final int max;

  WkBaseAlarmConfig({
    this.isEnabled = false,
    this.min = 0,
    this.max = 0,
  });

  factory WkBaseAlarmConfig.fromJson(Map<String, dynamic> json) =>
      _$WkBaseAlarmConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WkBaseAlarmConfigToJson(this);

  @override
  String toString() {
    return 'WkBaseAlarmConfig(isEnabled: $isEnabled, min: $min, max: $max)';
  }
}
