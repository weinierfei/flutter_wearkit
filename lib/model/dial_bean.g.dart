// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dial_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DialListBean _$DialListBeanFromJson(Map<String, dynamic> json) => DialListBean(
  pageIndex: (json['page_index'] as num).toInt(),
  pageSize: (json['page_size'] as num).toInt(),
  isNext: (json['is_next'] as num).toInt(),
  dataList: (json['data_list'] as List<dynamic>)
      .map((e) => DialBean.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DialListBeanToJson(DialListBean instance) =>
    <String, dynamic>{
      'page_index': instance.pageIndex,
      'page_size': instance.pageSize,
      'is_next': instance.isNext,
      'data_list': instance.dataList,
    };

DialTypeListBean _$DialTypeListBeanFromJson(Map<String, dynamic> json) =>
    DialTypeListBean(
      (json['page_index'] as num).toInt(),
      (json['page_size'] as num).toInt(),
      (json['is_next'] as num).toInt(),
      (json['type_list'] as List<dynamic>)
          .map((e) => TypeList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DialTypeListBeanToJson(DialTypeListBean instance) =>
    <String, dynamic>{
      'page_index': instance.pageIndex,
      'page_size': instance.pageSize,
      'is_next': instance.isNext,
      'type_list': instance.typeList,
    };

TypeList _$TypeListFromJson(Map<String, dynamic> json) => TypeList(
  (json['type_id'] as num).toInt(),
  json['type_name'] as String,
  (json['dial_list'] as List<dynamic>)
      .map((e) => DialBean.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['is_more'] as num).toInt(),
);

Map<String, dynamic> _$TypeListToJson(TypeList instance) => <String, dynamic>{
  'type_id': instance.typeId,
  'type_name': instance.typeName,
  'dial_list': instance.dialList,
  'is_more': instance.isMore,
};

DialBean _$DialBeanFromJson(Map<String, dynamic> json) => DialBean(
  (json['id'] as num).toInt(),
  json['dial_name'] as String,
  json['dial_number'] as String,
  json['thumbnail'] as String,
  (json['bin_file_size'] as num).toInt(),
);

Map<String, dynamic> _$DialBeanToJson(DialBean instance) => <String, dynamic>{
  'id': instance.id,
  'dial_name': instance.dialName,
  'dial_number': instance.dialNumber,
  'thumbnail': instance.thumbnail,
  'bin_file_size': instance.binFileSize,
};
