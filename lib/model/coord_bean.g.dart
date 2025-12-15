// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coord_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoordBean _$CoordBeanFromJson(Map<String, dynamic> json) => CoordBean(
  json['ip'] as String,
  (json['lon'] as num).toDouble(),
  (json['lat'] as num).toDouble(),
  json['country'] as String,
  json['city_name'] as String,
);

Map<String, dynamic> _$CoordBeanToJson(CoordBean instance) => <String, dynamic>{
  'ip': instance.ip,
  'lon': instance.lon,
  'lat': instance.lat,
  'country': instance.country,
  'city_name': instance.cityName,
};
