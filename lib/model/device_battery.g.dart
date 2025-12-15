// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_battery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceBattery _$DeviceBatteryFromJson(Map<String, dynamic> json) =>
    DeviceBattery(
      json['isCharging'] as bool,
      (json['percentage'] as num).toInt(),
    );

Map<String, dynamic> _$DeviceBatteryToJson(DeviceBattery instance) =>
    <String, dynamic>{
      'isCharging': instance.isCharging,
      'percentage': instance.percentage,
    };
