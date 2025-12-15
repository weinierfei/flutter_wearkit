import 'package:json_annotation/json_annotation.dart';

part 'device_battery.g.dart';


@JsonSerializable()
class DeviceBattery {

  bool isCharging;

  int percentage;

  DeviceBattery(this.isCharging,this.percentage,);

  factory DeviceBattery.fromJson(Map<String, dynamic> srcJson) => _$DeviceBatteryFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceBatteryToJson(this);

}


