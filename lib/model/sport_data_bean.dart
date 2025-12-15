import 'package:json_annotation/json_annotation.dart';

part 'sport_data_bean.g.dart';

@JsonSerializable()
class SportDataBean {
  int type;

  String value;

  String unit;

  String text;

  SportDataBean({
    required this.type,
    this.value = "",
    this.unit = "",
    this.text = "",
  });

  factory SportDataBean.fromJson(Map<String, dynamic> srcJson) =>
      _$SportDataBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SportDataBeanToJson(this);
}
