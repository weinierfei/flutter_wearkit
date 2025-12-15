import 'package:flutter_wearkit/model/wk_activity_attribute.dart';
import 'package:json_annotation/json_annotation.dart';

part 'exercise_goal.g.dart';

@JsonSerializable()
class ExerciseGoal {
  int steps = 8000;
  /// 距离 单位km
  double distance = 1.0;
  /// 卡路里，千卡
  int calories = 50;
  /// 活动小时数，分钟
  int duration = 720;
  /// 活动次数
  int number = 1;
  /// 锻炼时长，分钟
  int sportDuration = 30;
  /// 最后修改时间（时间戳）
  int lastModifyTime = 0;
  /// 要关闭的提醒
  List<String>? disabledReminds;

  /// 创建运动目标配置
  ///
  /// [steps] 步数目标（默认8000步）
  /// [distance] 距离目标（单位公里，默认1.0km）
  /// [calories] 卡路里目标（单位千卡，默认50kcal）
  /// [duration] 活动小时数（单位分钟，默认720分钟）
  /// [number] 活动次数（默认1次）
  /// [sportDuration] 锻炼时长（单位分钟，默认30分钟）
  /// [lastModifyTime] 最后修改时间（时间戳）
  ExerciseGoal({
    this.steps = 8000,
    this.distance = 1.0,
    this.calories = 50,
    this.duration = 720,
    this.number = 1,
    this.sportDuration = 30,
    this.lastModifyTime = 0,
    this.disabledReminds,
  });


  factory ExerciseGoal.fromJson(Map<String, dynamic> srcJson) => _$ExerciseGoalFromJson(srcJson);

  Map<String, dynamic> toJson() => _$ExerciseGoalToJson(this);


  @override
  String toString() {
    return 'ExerciseGoal(steps: $steps, distance: $distance,calories: $calories, duration: $duration, number: $number, sportDuration: $sportDuration, lastModifyTime: $lastModifyTime  disabledReminds: $disabledReminds)';
  }
}
