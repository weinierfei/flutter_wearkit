import 'package:json_annotation/json_annotation.dart';

part 'aigc_type_bean.g.dart';


@JsonSerializable()
class AIgcTypeBean extends Object {

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'algorithm')
  List<Algorithm> algorithm;

  AIgcTypeBean(this.id,this.name,this.algorithm,);

  factory AIgcTypeBean.fromJson(Map<String, dynamic> srcJson) => _$AIgcTypeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AIgcTypeBeanToJson(this);

}


@JsonSerializable()
class Algorithm extends Object {

  @JsonKey(name: 'Id')
  String id;

  @JsonKey(name: 'Url')
  String url;

  @JsonKey(name: 'Name')
  String name;

  Algorithm(this.id,this.url,this.name,);

  factory Algorithm.fromJson(Map<String, dynamic> srcJson) => _$AlgorithmFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AlgorithmToJson(this);

}


