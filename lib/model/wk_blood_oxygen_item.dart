import 'package:json_annotation/json_annotation.dart';

part 'wk_blood_oxygen_item.g.dart';


@JsonSerializable()
class WKBloodOxygenItem {

  int oxygen;

  int timestampSeconds;

  WKBloodOxygenItem(this.oxygen,this.timestampSeconds,);

  factory WKBloodOxygenItem.fromJson(Map<String, dynamic> srcJson) => _$WKBloodOxygenItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKBloodOxygenItemToJson(this);

  @override
  String toString() {
    return 'WKBloodOxygenItem{oxygen: $oxygen, timestampSeconds: $timestampSeconds}';
  }
}


