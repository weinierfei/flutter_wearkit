import 'package:json_annotation/json_annotation.dart';

part 'wk_blood_pressure_item.g.dart';

@JsonSerializable()
class WKBloodPressureItem {
  int sbp;

  int dbp;

  int timestampSeconds;

  WKBloodPressureItem({this.sbp = 0, this.dbp = 0, this.timestampSeconds = 0});

  factory WKBloodPressureItem.fromJson(Map<String, dynamic> srcJson) =>
      _$WKBloodPressureItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKBloodPressureItemToJson(this);

  @override
  String toString() {
    return 'WKBloodPressureItem{sbp: $sbp, dbp: $dbp, timestampSeconds: $timestampSeconds}';
  }
}
