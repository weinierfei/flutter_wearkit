import 'package:json_annotation/json_annotation.dart';

part 'wk_temperature_item.g.dart';


@JsonSerializable()
class WKTemperatureItem extends Object {

  double body;

  double wrist;

  int timestampSeconds;

  WKTemperatureItem(this.body,this.wrist,this.timestampSeconds,);

  factory WKTemperatureItem.fromJson(Map<String, dynamic> srcJson) => _$WKTemperatureItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKTemperatureItemToJson(this);

  @override
  String toString() {
    return 'WKTemperatureItem{body: $body, wrist: $wrist, timestampSeconds: $timestampSeconds}';
  }

}


