import 'package:flutter_wearkit/model/timestamp_value.dart';

class BloodPressureDayBean {
  final DateTime date;
  final List<TimestampValue> value;
  final int sbp;
  final int dbp;

  BloodPressureDayBean({
    required this.date,
    required this.value,
    required this.sbp,
    required this.dbp,
  });

  @override
  String toString() {
    return 'BloodPressureDayBean(date: $date, sbp: $sbp,dbp: $dbp, values: ${value.length} hours)';
  }
}
