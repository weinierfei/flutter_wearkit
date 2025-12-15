// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseGoal _$ExerciseGoalFromJson(Map<String, dynamic> json) => ExerciseGoal(
  steps: (json['steps'] as num?)?.toInt() ?? 8000,
  distance: (json['distance'] as num?)?.toDouble() ?? 1.0,
  calories: (json['calories'] as num?)?.toInt() ?? 50,
  duration: (json['duration'] as num?)?.toInt() ?? 720,
  number: (json['number'] as num?)?.toInt() ?? 1,
  sportDuration: (json['sportDuration'] as num?)?.toInt() ?? 30,
  lastModifyTime: (json['lastModifyTime'] as num?)?.toInt() ?? 0,
  disabledReminds: (json['disabledReminds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ExerciseGoalToJson(ExerciseGoal instance) =>
    <String, dynamic>{
      'steps': instance.steps,
      'distance': instance.distance,
      'calories': instance.calories,
      'duration': instance.duration,
      'number': instance.number,
      'sportDuration': instance.sportDuration,
      'lastModifyTime': instance.lastModifyTime,
      'disabledReminds': instance.disabledReminds,
    };
