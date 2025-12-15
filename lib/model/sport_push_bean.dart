import 'package:json_annotation/json_annotation.dart';

part 'sport_push_bean.g.dart';

@JsonSerializable()
class SportPushBean extends Object {
  int sportType;

  bool replaceable;

  SportPushBean(
    this.sportType,
    this.replaceable,
  );

  factory SportPushBean.fromJson(Map<String, dynamic> srcJson) =>
      _$SportPushBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SportPushBeanToJson(this);
}
