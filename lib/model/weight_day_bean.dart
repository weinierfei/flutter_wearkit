import 'package:flutter_wearkit/model/position_max_min_avg.dart';

class WeightDayBean {
  final DateTime date;
  final List<PositionMaxMinAvg> value;
  final DateTime startDate;
  final DateTime endDate;
  final int lastValue;

  WeightDayBean({
    required this.date,
    required this.value,
    required this.startDate,
    required this.endDate,
    required this.lastValue,
  });

  @override
  String toString() {
    return 'WeightDayBean(date: $date, startDate: $startDate,endDate: $endDate,lastValue: $lastValue, values: ${value.length} hours)';
  }
}
