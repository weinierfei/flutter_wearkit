import 'package:json_annotation/json_annotation.dart';
import 'wk_base_alarm_config.dart';

part 'wk_heart_rate_alarm_config.g.dart';

@JsonSerializable()
class WkHeartRateAlarmConfig {
  final WkBaseAlarmConfig exercise;
  final WkBaseAlarmConfig resting;

  WkHeartRateAlarmConfig({
    required this.exercise,
    required this.resting,
  });

  factory WkHeartRateAlarmConfig.fromJson(Map<String, dynamic> json) =>
      _$WkHeartRateAlarmConfigFromJson(json);

  Map<String, dynamic> toJson() => _$WkHeartRateAlarmConfigToJson(this);

  @override
  String toString() {
    return 'WkHeartRateAlarmConfig(exercise: $exercise, resting: $resting)';
  }
}
