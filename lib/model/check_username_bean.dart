import 'package:json_annotation/json_annotation.dart';

part 'check_username_bean.g.dart';


@JsonSerializable()
class CheckUsernameBean  {

  @JsonKey(name: 'is_exist')
  int isExist;

  CheckUsernameBean(this.isExist,);

  factory CheckUsernameBean.fromJson(Map<String, dynamic> srcJson) => _$CheckUsernameBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CheckUsernameBeanToJson(this);

}


