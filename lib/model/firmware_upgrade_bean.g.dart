// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firmware_upgrade_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirmwareUpgradeBean _$FirmwareUpgradeBeanFromJson(Map<String, dynamic> json) =>
    FirmwareUpgradeBean(
      (json['status'] as num).toInt(),
      json['firmware_version'] as String?,
      json['prc_version'] as String?,
      json['ota_file'] as String?,
      (json['ota_file_size'] as num?)?.toInt(),
      json['ota_file_md5'] as String?,
    );

Map<String, dynamic> _$FirmwareUpgradeBeanToJson(
  FirmwareUpgradeBean instance,
) => <String, dynamic>{
  'status': instance.status,
  'firmware_version': instance.firmwareVersion,
  'prc_version': instance.prcVersion,
  'ota_file': instance.otaFile,
  'ota_file_size': instance.otaFileSize,
  'ota_file_md5': instance.otaFileMd5,
};
