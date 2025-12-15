import 'package:json_annotation/json_annotation.dart';

part 'activity_item.g.dart';

@JsonSerializable()
class ActivityItem {

  int timestampSeconds;

  int steps;

  double distance;

  double calories;

  int duration;

  int number;

  int sportDuration;

  ActivityItem(this.timestampSeconds,this.steps,this.distance,this.calories,this.duration,this.number,this.sportDuration,);

  factory ActivityItem.fromJson(Map<String, dynamic> srcJson) => _$ActivityItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ActivityItemToJson(this);

  @override
  String toString() {
    return 'ActivityItem{timestampSeconds: $timestampSeconds, steps: $steps, distance: $distance, calories: $calories, duration: $duration, number: $number, sportDuration: $sportDuration}';
  }
}


