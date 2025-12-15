import 'package:json_annotation/json_annotation.dart';

part 'coord_bean.g.dart';

@JsonSerializable()
class CoordBean {
  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'lon')
  double lon;

  @JsonKey(name: 'lat')
  double lat;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'city_name')
  String cityName;

  CoordBean(
    this.ip,
    this.lon,
    this.lat,
    this.country,
    this.cityName,
  );

  factory CoordBean.fromJson(Map<String, dynamic> srcJson) =>
      _$CoordBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CoordBeanToJson(this);
}
