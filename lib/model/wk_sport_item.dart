import 'package:json_annotation/json_annotation.dart';

part 'wk_sport_item.g.dart';

@JsonSerializable()
class WKSportItem {
  int timestampSeconds;

  int duration;

  double distance;

  double calories;

  int steps;

  WKSportItem(
    this.timestampSeconds,
    this.duration,
    this.distance,
    this.calories,
    this.steps,
  );

  factory WKSportItem.fromJson(Map<String, dynamic> srcJson) =>
      _$WKSportItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSportItemToJson(this);
}
