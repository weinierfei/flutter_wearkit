import 'package:json_annotation/json_annotation.dart';

part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo {
  final String type;
  final String model;
  final String version;
  final String project;
  final WkShape shape;
  final int? lcd;
  final String? toolVersion;
  final String? platform;
  final bool? isNextGUI;

  DeviceInfo({
    required this.type,
    required this.model,
    required this.version,
    required this.project,
    required this.shape,
    this.lcd,
    this.toolVersion,
    this.platform,
    this.isNextGUI,
  });

  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);

  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
}

@JsonSerializable()
class WkShape {
  final int shape;

  /// 0是方形 1 是圆形
  final int width;
  final int height;
  final int corners;

  WkShape({
    required this.shape,
    required this.width,
    required this.height,
    required this.corners,
  });

  Map<String, dynamic> toJson() => _$WkShapeToJson(this);

  factory WkShape.fromJson(Map<String, dynamic> json) =>
      _$WkShapeFromJson(json);
}
