import 'package:flutter_wearkit/model/exercise_goal.dart';
import 'package:flutter_wearkit/model/unit_config.dart';
import 'package:flutter_wearkit/model/activity_item.dart';
import 'package:flutter_wearkit/model/wk_activity_attribute.dart';

class ActivityDataBean {
  final List<WKActivityAttribute> activityAttributes;
  final UnitConfig unitConfig;
  final ExerciseGoal goalConfig;
  final ActivityItem activityItem;

  ActivityDataBean({
    required this.activityAttributes,
    required this.unitConfig,
    required this.goalConfig,
    required this.activityItem,
  });
}
