// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfo _$DeviceInfoFromJson(Map<String, dynamic> json) => DeviceInfo(
  type: json['type'] as String,
  model: json['model'] as String,
  version: json['version'] as String,
  project: json['project'] as String,
  shape: WkShape.fromJson(json['shape'] as Map<String, dynamic>),
  lcd: (json['lcd'] as num?)?.toInt(),
  toolVersion: json['toolVersion'] as String?,
  platform: json['platform'] as String?,
  isNextGUI: json['isNextGUI'] as bool?,
);

Map<String, dynamic> _$DeviceInfoToJson(DeviceInfo instance) =>
    <String, dynamic>{
      'type': instance.type,
      'model': instance.model,
      'version': instance.version,
      'project': instance.project,
      'shape': instance.shape,
      'lcd': instance.lcd,
      'toolVersion': instance.toolVersion,
      'platform': instance.platform,
      'isNextGUI': instance.isNextGUI,
    };

WkShape _$WkShapeFromJson(Map<String, dynamic> json) => WkShape(
  shape: (json['shape'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  corners: (json['corners'] as num).toInt(),
);

Map<String, dynamic> _$WkShapeToJson(WkShape instance) => <String, dynamic>{
  'shape': instance.shape,
  'width': instance.width,
  'height': instance.height,
  'corners': instance.corners,
};
