import 'package:json_annotation/json_annotation.dart';

part 'dial_bean.g.dart';

@JsonSerializable()
class DialListBean {
  @JsonKey(name: 'page_index')
  final int pageIndex;
  @JsonKey(name: 'page_size')
  final int pageSize;
  @JsonKey(name: 'is_next')
  final int isNext;
  @JsonKey(name: 'data_list')
  final List<DialBean> dataList;

  Map<String, dynamic> toJson() => _$DialListBeanToJson(this);

  factory DialListBean.fromJson(Map<String, dynamic> json) =>
      _$DialListBeanFromJson(json);

  DialListBean({
    required this.pageIndex,
    required this.pageSize,
    required this.isNext,
    required this.dataList,
  });
}

@JsonSerializable()
class DialTypeListBean {
  @JsonKey(name: 'page_index')
  int pageIndex;

  @JsonKey(name: 'page_size')
  int pageSize;

  @JsonKey(name: 'is_next')
  int isNext;

  @JsonKey(name: 'type_list')
  List<TypeList> typeList;

  DialTypeListBean(this.pageIndex, this.pageSize, this.isNext, this.typeList);

  factory DialTypeListBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DialTypeListBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DialTypeListBeanToJson(this);
}

@JsonSerializable()
class TypeList extends Object {
  @JsonKey(name: 'type_id')
  int typeId;

  @JsonKey(name: 'type_name')
  String typeName;

  @JsonKey(name: 'dial_list')
  List<DialBean> dialList;

  @JsonKey(name: 'is_more')
  int isMore;

  TypeList(this.typeId, this.typeName, this.dialList, this.isMore);

  factory TypeList.fromJson(Map<String, dynamic> srcJson) =>
      _$TypeListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$TypeListToJson(this);
}

@JsonSerializable()
class DialBean {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'dial_name')
  String dialName;

  @JsonKey(name: 'dial_number')
  String dialNumber;

  @JsonKey(name: 'thumbnail')
  String thumbnail;

  @JsonKey(name: 'bin_file_size')
  int binFileSize;

  DialBean(
    this.id,
    this.dialName,
    this.dialNumber,
    this.thumbnail,
    this.binFileSize,
  );

  factory DialBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DialBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DialBeanToJson(this);
}
