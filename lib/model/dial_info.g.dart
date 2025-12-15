// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dial_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialInfoList _$DialInfoListFromJson(Map<String, dynamic> json) => DialInfoList(
  items: (json['items'] as List<dynamic>)
      .map((e) => DialInfo.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DialInfoListToJson(DialInfoList instance) =>
    <String, dynamic>{'items': instance.items};

DialInfo _$DialInfoFromJson(Map<String, dynamic> json) => DialInfo(
  dialId: json['dialId'] as String,
  dialType: $enumDecode(_$DialTypeEnumMap, json['dialType']),
  isSelected: json['isSelected'] as bool,
);

Map<String, dynamic> _$DialInfoToJson(DialInfo instance) => <String, dynamic>{
  'dialId': instance.dialId,
  'dialType': _$DialTypeEnumMap[instance.dialType]!,
  'isSelected': instance.isSelected,
};

const _$DialTypeEnumMap = {
  DialType.BUILT_IN: 'BUILT_IN',
  DialType.NORMAL: 'NORMAL',
  DialType.CUSTOM: 'CUSTOM',
};

DialStyleConstraint _$DialStyleConstraintFromJson(Map<String, dynamic> json) =>
    DialStyleConstraint(
      styles: (json['styles'] as List<dynamic>)
          .map((e) => Style.fromJson(e as Map<String, dynamic>))
          .toList(),
      templates: (json['templates'] as List<dynamic>?)
          ?.map((e) => WKResources.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowPositions: (json['allowPositions'] as List<dynamic>?)
          ?.map((e) => Position.fromJson(e as Map<String, dynamic>))
          .toList(),
      allowColorTint: json['allowColorTint'] as bool?,
    );

Map<String, dynamic> _$DialStyleConstraintToJson(
  DialStyleConstraint instance,
) => <String, dynamic>{
  'styles': instance.styles,
  'templates': instance.templates,
  'allowPositions': instance.allowPositions,
  'allowColorTint': instance.allowColorTint,
};

Style _$StyleFromJson(Map<String, dynamic> json) => Style(
  image: Uri.parse(json['image'] as String),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
);

Map<String, dynamic> _$StyleToJson(Style instance) => <String, dynamic>{
  'image': instance.image.toString(),
  'width': instance.width,
  'height': instance.height,
};

Position _$PositionFromJson(Map<String, dynamic> json) => Position(
  xAxis: (json['xAxis'] as num).toInt(),
  yAxis: (json['yAxis'] as num).toInt(),
);

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
  'xAxis': instance.xAxis,
  'yAxis': instance.yAxis,
};

WKResources _$WKResourcesFromJson(Map<String, dynamic> json) => WKResources(
  uri: Uri.parse(json['uri'] as String),
  size: (json['size'] as num).toInt(),
);

Map<String, dynamic> _$WKResourcesToJson(WKResources instance) =>
    <String, dynamic>{'uri': instance.uri.toString(), 'size': instance.size};
