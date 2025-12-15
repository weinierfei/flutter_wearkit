import 'package:json_annotation/json_annotation.dart';

part 'timestamp_value.g.dart';

@JsonSerializable()
class TimestampValue {
  int timestamp;

  double value;

  double value2;

  TimestampValue(
    this.timestamp,
    this.value,
    this.value2,
  );

  factory TimestampValue.fromJson(Map<String, dynamic> srcJson) =>
      _$TimestampValueFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TimestampValueToJson(this);

  @override
  String toString() {
    return 'TimestampValue(timestamp: $timestamp, value: $value, value2: $value2)';
  }
}
