import 'package:json_annotation/json_annotation.dart';

part 'wk_heart_rate_item.g.dart';

@JsonSerializable()
class WKHeartRateItem {

  int heartRate;

  int timestampSeconds;

  WKHeartRateItem(this.heartRate,this.timestampSeconds,);

  factory WKHeartRateItem.fromJson(Map<String, dynamic> srcJson) => _$WKHeartRateItemFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKHeartRateItemToJson(this);

  @override
  String toString() {
    return 'WKHeartRateItem{heartRate: $heartRate, timestampSeconds: $timestampSeconds}';
  }
}


