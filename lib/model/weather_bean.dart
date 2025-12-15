import 'package:json_annotation/json_annotation.dart';

part 'weather_bean.g.dart';

@JsonSerializable()
class WeatherBean {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'now')
  Now now;

  @JsonKey(name: 'expired_time')
  int expiredTime;

  @JsonKey(name: 'city_id')
  String cityId;

  @JsonKey(name: 'country')
  String country;

  @JsonKey(name: 'city_name')
  String cityName;

  @JsonKey(name: 'time_zone')
  String timeZone;

  @JsonKey(name: 'lon')
  String lon;

  @JsonKey(name: 'lat')
  String lat;

  @JsonKey(name: 'source')
  String source;

  @JsonKey(name: 'daily')
  List<Daily> daily;

  @JsonKey(name: 'hourly')
  List<Hourly>? hourly;

  WeatherBean(
    this.type,
    this.now,
    this.expiredTime,
    this.cityId,
    this.country,
    this.cityName,
    this.timeZone,
    this.lon,
    this.lat,
    this.source,
    this.daily,
    this.hourly,
  );

  factory WeatherBean.fromJson(Map<String, dynamic> srcJson) =>
      _$WeatherBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WeatherBeanToJson(this);
}

@JsonSerializable()
class Now {
  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'temp')
  String temp;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'windDir')
  String windDir;

  @JsonKey(name: 'windScale')
  String windScale;

  @JsonKey(name: 'windSpeed')
  String windSpeed;

  @JsonKey(name: 'humidity')
  String humidity;

  @JsonKey(name: 'pressure')
  String pressure;

  @JsonKey(name: 'vis')
  String vis;

  Now(
    this.time,
    this.temp,
    this.text,
    this.code,
    this.windDir,
    this.windScale,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.vis,
  );

  factory Now.fromJson(Map<String, dynamic> srcJson) => _$NowFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NowToJson(this);
}

@JsonSerializable()
class Daily {
  @JsonKey(name: 'time')
  String time;

  @JsonKey(name: 'sunrise')
  String sunrise;

  @JsonKey(name: 'sunset')
  String sunset;

  @JsonKey(name: 'moonrise')
  String moonrise;

  @JsonKey(name: 'moonset')
  String moonset;

  @JsonKey(name: 'moonPhase')
  String moonPhase;

  @JsonKey(name: 'tempMax')
  String tempMax;

  @JsonKey(name: 'tempMin')
  String tempMin;

  @JsonKey(name: 'text')
  String text;

  @JsonKey(name: 'code')
  int code;

  @JsonKey(name: 'windDir')
  String windDir;

  @JsonKey(name: 'windScale')
  String windScale;

  @JsonKey(name: 'windSpeed')
  String windSpeed;

  @JsonKey(name: 'humidity')
  String humidity;

  @JsonKey(name: 'pressure')
  String pressure;

  @JsonKey(name: 'vis')
  String vis;

  Daily(
    this.time,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.tempMax,
    this.tempMin,
    this.text,
    this.code,
    this.windDir,
    this.windScale,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.vis,
  );

  factory Daily.fromJson(Map<String, dynamic> srcJson) =>
      _$DailyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DailyToJson(this);
}

@JsonSerializable()
class Hourly {
  String time;

  String temp;

  String text;

  int code;

  String windDir;

  String windScale;

  String windSpeed;

  String humidity;

  String pressure;

  String vis;

  Hourly(
    this.time,
    this.temp,
    this.text,
    this.code,
    this.windDir,
    this.windScale,
    this.windSpeed,
    this.humidity,
    this.pressure,
    this.vis,
  );

  factory Hourly.fromJson(Map<String, dynamic> srcJson) =>
      _$HourlyFromJson(srcJson);

  Map<String, dynamic> toJson() => _$HourlyToJson(this);
}
