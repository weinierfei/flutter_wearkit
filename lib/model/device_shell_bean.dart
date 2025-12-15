import 'package:json_annotation/json_annotation.dart';

part 'device_shell_bean.g.dart';

@JsonSerializable()
class DeviceShellBean {
  @JsonKey(name: 'image_type')
  int imageType;

  @JsonKey(name: 'image_file')
  String imageFile;

  DeviceShellBean(
    this.imageType,
    this.imageFile,
  );

  factory DeviceShellBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DeviceShellBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceShellBeanToJson(this);
}
