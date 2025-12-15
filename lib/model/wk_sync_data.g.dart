// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wk_sync_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WKSyncData _$WKSyncDataFromJson(Map<String, dynamic> json) => WKSyncData(
  deviceType: json['deviceType'] as String,
  deviceAddress: json['deviceAddress'] as String,
  deviceToken: json['deviceToken'] as String,
  type: (json['type'] as num).toInt(),
  rawData: json['rawData'],
);

Map<String, dynamic> _$WKSyncDataToJson(WKSyncData instance) =>
    <String, dynamic>{
      'deviceType': instance.deviceType,
      'deviceAddress': instance.deviceAddress,
      'deviceToken': instance.deviceToken,
      'type': instance.type,
      'rawData': instance.rawData,
    };
