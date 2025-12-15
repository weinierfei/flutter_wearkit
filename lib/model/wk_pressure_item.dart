import 'package:json_annotation/json_annotation.dart';

part 'wk_pressure_item.g.dart';


@JsonSerializable()
class WKPressureItem extends Object {

  int pressure;

  int timestampSeconds;

  WKPressureItem(this.pressure,this.timestampSeconds,);

  factory WKPressureItem.fromJson(Map<String, dynamic> srcJson) => _$WKPressureItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKPressureItemToJson(this);

  @override
  String toString() {
    return 'WKPressureItem{pressure: $pressure, timestampSeconds: $timestampSeconds}';
  }
}


