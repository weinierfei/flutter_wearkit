// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_upgrade_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpgradeBean _$AppUpgradeBeanFromJson(Map<String, dynamic> json) =>
    AppUpgradeBean(
      (json['status'] as num).toInt(),
      json['android'] == null
          ? null
          : AppUpgradeInfo.fromJson(json['android'] as Map<String, dynamic>),
      json['ios'] == null
          ? null
          : AppUpgradeInfo.fromJson(json['ios'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppUpgradeBeanToJson(AppUpgradeBean instance) =>
    <String, dynamic>{
      'status': instance.status,
      'android': instance.android,
      'ios': instance.ios,
    };

AppUpgradeInfo _$AppUpgradeInfoFromJson(Map<String, dynamic> json) =>
    AppUpgradeInfo(
      json['version'] as String,
      json['file'] as String,
      (json['file_size'] as num).toInt(),
      json['file_md5'] as String,
      json['content'] as String,
      (json['force'] as num).toInt(),
      (json['skippable'] as num).toInt(),
    );

Map<String, dynamic> _$AppUpgradeInfoToJson(AppUpgradeInfo instance) =>
    <String, dynamic>{
      'version': instance.version,
      'file': instance.file,
      'file_size': instance.fileSize,
      'file_md5': instance.fileMd5,
      'content': instance.content,
      'force': instance.force,
      'skippable': instance.skippable,
    };
