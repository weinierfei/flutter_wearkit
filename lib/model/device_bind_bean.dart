import 'package:json_annotation/json_annotation.dart';

part 'device_bind_bean.g.dart';

@JsonSerializable()
class DeviceBindBean {
  String name;

  String address;

  int type;

  String hardwareInfo;

  String productType;

  int isUnBind;

  int lastModifyTime;

  DeviceBindBean(
    this.name,
    this.address,
    this.type,
    this.hardwareInfo,
    this.productType,
    this.isUnBind,
    this.lastModifyTime,
  );

  factory DeviceBindBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DeviceBindBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceBindBeanToJson(this);
}
