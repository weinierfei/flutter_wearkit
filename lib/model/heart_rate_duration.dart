import 'package:json_annotation/json_annotation.dart';

part 'heart_rate_duration.g.dart';

@JsonSerializable()
class HeartRateDuration {
  int warmUp;

  int fatBurning;

  int aerobic;

  int anaerobic;

  int heartLimit;

  HeartRateDuration({
    this.warmUp = 0,
    this.fatBurning = 0,
    this.aerobic = 0,
    this.anaerobic = 0,
    this.heartLimit = 0,
  });

  factory HeartRateDuration.fromJson(Map<String, dynamic> srcJson) =>
      _$HeartRateDurationFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HeartRateDurationToJson(this);

  @override
  String toString() {
    return 'HeartRateDuration{warmUp: $warmUp, fatBurning: $fatBurning, aerobic: $aerobic, anaerobic: $anaerobic, heartLimit: $heartLimit}';
  }
}
