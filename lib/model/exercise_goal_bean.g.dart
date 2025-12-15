// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_goal_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseGoalBean _$ExerciseGoalBeanFromJson(Map<String, dynamic> json) =>
    ExerciseGoalBean(
      step: (json['step'] as num?)?.toInt() ?? 8000,
      distance: (json['distance'] as num?)?.toDouble() ?? 5000,
      calorie: (json['calorie'] as num?)?.toInt() ?? 250,
      duration: (json['duration'] as num).toInt(),
      number: (json['number'] as num).toInt(),
      sportDuration: (json['sportDuration'] as num).toInt(),
      targetLastModifyTime: (json['lastModifyTime'] as num).toInt(),
    );

Map<String, dynamic> _$ExerciseGoalBeanToJson(ExerciseGoalBean instance) =>
    <String, dynamic>{
      'step': instance.step,
      'distance': instance.distance,
      'calorie': instance.calorie,
      'duration': instance.duration,
      'number': instance.number,
      'sportDuration': instance.sportDuration,
      'lastModifyTime': instance.targetLastModifyTime,
    };
