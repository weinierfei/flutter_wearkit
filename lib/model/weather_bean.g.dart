// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_bean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherBean _$WeatherBeanFromJson(Map<String, dynamic> json) => WeatherBean(
  json['type'] as String,
  Now.fromJson(json['now'] as Map<String, dynamic>),
  (json['expired_time'] as num).toInt(),
  json['city_id'] as String,
  json['country'] as String,
  json['city_name'] as String,
  json['time_zone'] as String,
  json['lon'] as String,
  json['lat'] as String,
  json['source'] as String,
  (json['daily'] as List<dynamic>)
      .map((e) => Daily.fromJson(e as Map<String, dynamic>))
      .toList(),
  (json['hourly'] as List<dynamic>?)
      ?.map((e) => Hourly.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$WeatherBeanToJson(WeatherBean instance) =>
    <String, dynamic>{
      'type': instance.type,
      'now': instance.now,
      'expired_time': instance.expiredTime,
      'city_id': instance.cityId,
      'country': instance.country,
      'city_name': instance.cityName,
      'time_zone': instance.timeZone,
      'lon': instance.lon,
      'lat': instance.lat,
      'source': instance.source,
      'daily': instance.daily,
      'hourly': instance.hourly,
    };

Now _$NowFromJson(Map<String, dynamic> json) => Now(
  json['time'] as String,
  json['temp'] as String,
  json['text'] as String,
  (json['code'] as num).toInt(),
  json['windDir'] as String,
  json['windScale'] as String,
  json['windSpeed'] as String,
  json['humidity'] as String,
  json['pressure'] as String,
  json['vis'] as String,
);

Map<String, dynamic> _$NowToJson(Now instance) => <String, dynamic>{
  'time': instance.time,
  'temp': instance.temp,
  'text': instance.text,
  'code': instance.code,
  'windDir': instance.windDir,
  'windScale': instance.windScale,
  'windSpeed': instance.windSpeed,
  'humidity': instance.humidity,
  'pressure': instance.pressure,
  'vis': instance.vis,
};

Daily _$DailyFromJson(Map<String, dynamic> json) => Daily(
  json['time'] as String,
  json['sunrise'] as String,
  json['sunset'] as String,
  json['moonrise'] as String,
  json['moonset'] as String,
  json['moonPhase'] as String,
  json['tempMax'] as String,
  json['tempMin'] as String,
  json['text'] as String,
  (json['code'] as num).toInt(),
  json['windDir'] as String,
  json['windScale'] as String,
  json['windSpeed'] as String,
  json['humidity'] as String,
  json['pressure'] as String,
  json['vis'] as String,
);

Map<String, dynamic> _$DailyToJson(Daily instance) => <String, dynamic>{
  'time': instance.time,
  'sunrise': instance.sunrise,
  'sunset': instance.sunset,
  'moonrise': instance.moonrise,
  'moonset': instance.moonset,
  'moonPhase': instance.moonPhase,
  'tempMax': instance.tempMax,
  'tempMin': instance.tempMin,
  'text': instance.text,
  'code': instance.code,
  'windDir': instance.windDir,
  'windScale': instance.windScale,
  'windSpeed': instance.windSpeed,
  'humidity': instance.humidity,
  'pressure': instance.pressure,
  'vis': instance.vis,
};

Hourly _$HourlyFromJson(Map<String, dynamic> json) => Hourly(
  json['time'] as String,
  json['temp'] as String,
  json['text'] as String,
  (json['code'] as num).toInt(),
  json['windDir'] as String,
  json['windScale'] as String,
  json['windSpeed'] as String,
  json['humidity'] as String,
  json['pressure'] as String,
  json['vis'] as String,
);

Map<String, dynamic> _$HourlyToJson(Hourly instance) => <String, dynamic>{
  'time': instance.time,
  'temp': instance.temp,
  'text': instance.text,
  'code': instance.code,
  'windDir': instance.windDir,
  'windScale': instance.windScale,
  'windSpeed': instance.windSpeed,
  'humidity': instance.humidity,
  'pressure': instance.pressure,
  'vis': instance.vis,
};
