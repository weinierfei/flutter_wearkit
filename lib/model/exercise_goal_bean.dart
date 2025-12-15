import 'package:json_annotation/json_annotation.dart';

part 'exercise_goal_bean.g.dart';

@JsonSerializable()
class ExerciseGoalBean {
  final int step;

  final double distance;

  final int calorie;

  final int duration;
  final int number;
  final int sportDuration;

  @JsonKey(name: 'lastModifyTime')
  final int targetLastModifyTime;

  ExerciseGoalBean({
    this.step = 8000,
    this.distance = 5000,
    this.calorie = 250,
    required this.duration,
    required this.number,
    required this.sportDuration,
    required this.targetLastModifyTime,
  });

  // JSON序列化
  factory ExerciseGoalBean.fromJson(Map<String, dynamic> json) =>
      _$ExerciseGoalBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ExerciseGoalBeanToJson(this);

  @override
  String toString() {
    return 'ExerciseGoalBean{步数: $step, 距离: ${distance}m, '
        '卡路里: $calorie, 持续时间: $duration, 次数: $number, '
        '运动时长: $sportDuration, 更新时间: $targetLastModifyTime}';
  }
}
