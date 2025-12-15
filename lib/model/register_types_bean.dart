import 'package:json_annotation/json_annotation.dart';

part 'register_types_bean.g.dart';

@JsonSerializable()
class RegisterTypesBean {
  @JsonKey(name: 'reg_way')
  List<String> regWay;

  @JsonKey(name: 'ip')
  String ip;

  RegisterTypesBean(
    this.regWay,
    this.ip,
  );

  factory RegisterTypesBean.fromJson(Map<String, dynamic> srcJson) =>
      _$RegisterTypesBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$RegisterTypesBeanToJson(this);
}
