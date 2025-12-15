import 'package:json_annotation/json_annotation.dart';

part 'wk_sport_heart_rate_item.g.dart';

@JsonSerializable()
class WKSportHeartRateItem extends Object {
  int timestampSeconds;

  int duration;

  int heartRate;

  WKSportHeartRateItem(
    this.timestampSeconds,
    this.duration,
    this.heartRate,
  );

  factory WKSportHeartRateItem.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSportHeartRateItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSportHeartRateItemToJson(this);
}
