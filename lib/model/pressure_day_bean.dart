import 'package:flutter_wearkit/model/timestamp_value.dart';

class PressureDayBean {
  final DateTime date;
  final List<TimestampValue> value;
  final int lastValue;

  PressureDayBean({
    required this.date,
    required this.value,
    required this.lastValue,
  });

  @override
  String toString() {
    return 'PressureDayBean(date: $date, lastValue: $lastValue, values: ${value.length} hours)';
  }
}
