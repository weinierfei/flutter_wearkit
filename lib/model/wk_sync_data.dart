import 'package:flutter_wearkit/model/wk_sync_data_type.dart';
import 'package:flutter_wearkit/model/activity_item.dart';
import 'package:flutter_wearkit/model/wk_blood_oxygen_item.dart';
import 'package:flutter_wearkit/model/wk_blood_pressure_item.dart';
import 'package:flutter_wearkit/model/wk_heart_rate_item.dart';
import 'package:flutter_wearkit/model/wk_pressure_item.dart';
import 'package:flutter_wearkit/model/wk_sleep_daily.dart';
import 'package:flutter_wearkit/model/wk_sport_record.dart';
import 'package:flutter_wearkit/model/wk_temperature_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wk_sync_data.g.dart';

/// 从设备同步的数据。
@JsonSerializable()
class WKSyncData {

  final String deviceType;

  final String deviceAddress;

  final String deviceToken;

  final int type;

  final dynamic rawData;

  WKSyncData({
    required this.deviceType,
    required this.deviceAddress,
    required this.deviceToken,
    required this.type,
    required this.rawData,
  });

  factory WKSyncData.fromJson(Map<String, dynamic> srcJson) => _$WKSyncDataFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKSyncDataToJson(this);

  bool isEmpty() {
    return (rawData as List?)?.isEmpty ?? true;
  }

  List<ActivityItem>? toActivity() {
    if (type == WKSyncDataType.ACTIVITY) {
      return (rawData as List)
          .map((item) => ActivityItem.fromJson(item))
          .toList();
    }
    return null;
  }

  ActivityItem? toActivityTodayAll() {
    if (type == WKSyncDataType.ACTIVITY_TODAY_ALL) {
      return ActivityItem.fromJson(rawData);
    }
    return null;
  }

  List<WKBloodOxygenItem>? toBloodOxygen() {
    if (type == WKSyncDataType.BLOOD_OXYGEN ||
        type == WKSyncDataType.BLOOD_OXYGEN_MANUAL) {
      return (rawData as List)
          .map((item) => WKBloodOxygenItem.fromJson(item))
          .toList();
    }
    return null;
  }

  List<WKBloodPressureItem>? toBloodPressure() {
    if (type == WKSyncDataType.BLOOD_PRESSURE ||
        type == WKSyncDataType.BLOOD_PRESSURE_MANUAL) {
      return (rawData as List)
          .map((item) => WKBloodPressureItem.fromJson(item))
          .toList();
    }
    return null;
  }

  List<WKHeartRateItem>? toHeartRate() {
    if (type == WKSyncDataType.HEART_RATE ||
        type == WKSyncDataType.HEART_RATE_RESTING ||
        type == WKSyncDataType.HEART_RATE_MANUAL) {
      return (rawData as List)
          .map((item) => WKHeartRateItem.fromJson(item))
          .toList();
    }
    return null;
  }

  List<WKPressureItem>? toPressure() {
    if (type == WKSyncDataType.PRESSURE ||
        type == WKSyncDataType.PRESSURE_MANUAL) {
      return (rawData as List)
          .map((item) => WKPressureItem.fromJson(item))
          .toList();
    }
    return null;
  }

  List<WKSleepDaily>? toSleep() {
    if (type == WKSyncDataType.SLEEP) {
      return (rawData as List)
          .map((item) => WKSleepDaily.fromJson(item))
          .toList();
    }
    return null;
  }


  List<WKTemperatureItem>? toTemperature() {
    if (type == WKSyncDataType.TEMPERATURE ||
        type == WKSyncDataType.TEMPERATURE_MANUAL) {
      return (rawData as List)
          .map((item) => WKTemperatureItem.fromJson(item))
          .toList();
    }
    return null;
  }

  List<WKSportRecord>? toSport() {
    if (type == WKSyncDataType.SPORT) {
      if (rawData == null) {
        return null;
      }
      return (rawData as List)
          .map((item) => WKSportRecord.fromJson(item))
          .toList();
    }
    return null;
  }
}
