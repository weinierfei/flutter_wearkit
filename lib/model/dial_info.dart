import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'dial_info.g.dart';

@JsonSerializable()
class DialInfoList {
  final List<DialInfo> items;

  DialInfoList({
    required this.items,
  });

  factory DialInfoList.fromJson(Map<String, dynamic> json) =>
      _$DialInfoListFromJson(json);

  Map<String, dynamic> toJson() => _$DialInfoListToJson(this);
}

@JsonSerializable()
class DialInfo {
  final String dialId;
  final DialType dialType;
  final bool isSelected;

  DialInfo({
    required this.dialId,
    required this.dialType,
    required this.isSelected,
  });

  factory DialInfo.fromJson(Map<String, dynamic> json) =>
      _$DialInfoFromJson(json);

  Map<String, dynamic> toJson() => _$DialInfoToJson(this);
}

enum DialType {
  /// 内置表盘
  BUILT_IN,

  /// 普通表盘
  NORMAL,

  /// 自定义表盘
  CUSTOM,
}

@JsonSerializable()
class DialStyleConstraint {
  final List<Style> styles;
  final List<WKResources>? templates;
  final List<Position>? allowPositions;
  final bool? allowColorTint;

  DialStyleConstraint(
      {required this.styles,
      this.templates,
      this.allowPositions,
      this.allowColorTint});

  factory DialStyleConstraint.fromJson(Map<String, dynamic> json) =>
      _$DialStyleConstraintFromJson(json);

  Map<String, dynamic> toJson() => _$DialStyleConstraintToJson(this);
}

@JsonSerializable()
class Style {
  final Uri image;
  final int width;
  final int height;

  Style({required this.image, required this.width, required this.height});

  Map<String, dynamic> toJson() => _$StyleToJson(this);

  factory Style.fromJson(Map<String, dynamic> json) => _$StyleFromJson(json);
}

@JsonSerializable()
class Position {
  final int xAxis;
  final int yAxis;

  Position({required this.xAxis, required this.yAxis});

  Map<String, dynamic> toJson() => _$PositionToJson(this);

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);
}

@JsonSerializable()
class WKResources {
  final Uri uri;
  final int size;

  WKResources({required this.uri, required this.size});

  Map<String, dynamic> toJson() => _$WKResourcesToJson(this);

  factory WKResources.fromJson(Map<String, dynamic> json) =>
      _$WKResourcesFromJson(json);
}

