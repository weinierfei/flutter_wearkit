import 'package:flutter_wearkit/model/timestamp_value.dart';

class TemperateDayBean {
  final DateTime date;
  final List<TimestampValue> value;
  final double lastValue;

  TemperateDayBean({
    required this.date,
    required this.value,
    required this.lastValue,
  });

  @override
  String toString() {
    return 'PressureDayBean(date: $date, lastValue: $lastValue, values: ${value.length} hours)';
  }
}
