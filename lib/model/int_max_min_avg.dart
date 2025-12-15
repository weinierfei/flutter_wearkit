import 'package:json_annotation/json_annotation.dart';

part 'int_max_min_avg.g.dart';

@JsonSerializable()
class IntMaxMinAvg {
  int max;

  int min;

  int avg;

  IntMaxMinAvg({
    this.max = 0,
    this.min = 0,
    this.avg = 0,
  });

  factory IntMaxMinAvg.fromJson(Map<String, dynamic> srcJson) =>
      _$IntMaxMinAvgFromJson(srcJson);

  Map<String, dynamic> toJson() => _$IntMaxMinAvgToJson(this);

  @override
  String toString() {
    return 'IntMaxMinAvg{max: $max, min: $min, avg: $avg}';
  }
}
