class ForecastInfo {
  final int min;
  final int max;
  final int code;
  final String text;
  final String time; // "yyyy-MM-dd"

  ForecastInfo({
    required this.min,
    required this.max,
    required this.code,
    required this.text,
    required this.time,
  });

  factory ForecastInfo.fromJson(Map<String, dynamic> json) => ForecastInfo(
    min: json['min'] as int,
    max: json['max'] as int,
    code: json['code'] as int,
    text: json['text'] as String,
    time: json['time'] as String,
  );

  Map<String, dynamic> toJson() => {
    'min': min,
    'max': max,
    'code': code,
    'text': text,
    'time': time,
  };
}

class WeatherHourBean {
  final int code;
  final int tempCurrent;
  final int windScale;
  final int ultraviolet;
  final int visibility;
  final String time; // "yyyy-MM-dd"
  final int? type;

  WeatherHourBean({
    required this.code,
    required this.tempCurrent,
    required this.windScale,
    required this.ultraviolet,
    required this.visibility,
    required this.type,
    required this.time,
  });

  factory WeatherHourBean.fromJson(Map<String, dynamic> json) => WeatherHourBean(
    code: json['code'] as int,
    tempCurrent: json['tempCurrent'] as int,
    windScale: json['windScale'] as int,
    ultraviolet: json['ultraviolet'] as int,
    visibility: json['visibility'] as int,
    type: json['type'] as int?,
    time: json['time'] as String,
  );

  Map<String, dynamic> toJson() => {
    'code': code,
    'tempCurrent': tempCurrent,
    'windScale': windScale,
    'ultraviolet': ultraviolet,
    'visibility': visibility,
    'type': type,
    'time': time,
  };
}

class WeatherInfo {
  final int time;
  final int expired;
  final double lat;
  final double lng;
  final String? locality;
  final int tmp;
  final int code;
  final String text;
  final List<ForecastInfo>? forecasts;
  final List<WeatherHourBean>? hourly;
  final int min;
  final int max;
  final int windSpeed;
  final int pressure;
  final int windScale;
  final int vis;

  WeatherInfo({
    required this.time,
    required this.expired,
    required this.lat,
    required this.lng,
    this.locality,
    required this.tmp,
    required this.code,
    required this.text,
    this.forecasts,
    this.hourly,
    required this.min,
    required this.max,
    required this.windSpeed,
    required this.pressure,
    required this.windScale,
    required this.vis,
  });

  // 判断天气信息是否在 maxAge 毫秒内有效
  bool isAvailable(int maxAge) {
    return (DateTime.now().millisecondsSinceEpoch - time) <= maxAge;
  }

  // 检查天气预报数据是否满足要求
  bool matchForecast(bool requireForecast) {
    if (!requireForecast) return true;
    return forecasts != null && forecasts!.isNotEmpty;
  }

  // 合并两个WeatherInfo，返回最新的一个
  static WeatherInfo? newest(WeatherInfo? a, WeatherInfo? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.time > b.time ? a : b;
  }

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => WeatherInfo(
    time: json['time'] as int,
    expired: json['expired'] as int,
    lat: (json['lat'] as num).toDouble(),
    lng: (json['lng'] as num).toDouble(),
    locality: json['locality'] as String?,
    tmp: json['tmp'] as int,
    code: json['code'] as int,
    text: json['text'] as String,
    forecasts: (json['forecasts'] as List<dynamic>?)
        ?.map((e) => ForecastInfo.fromJson(e as Map<String, dynamic>))
        .toList(),
    hourly: (json['hourly'] as List<dynamic>?)
        ?.map((e) => WeatherHourBean.fromJson(e as Map<String, dynamic>))
        .toList(),
    min: json['min'] as int,
    max: json['max'] as int,
    windSpeed: json['windSpeed'] as int,
    pressure: json['pressure'] as int,
    windScale: json['windScale'] as int,
    vis: json['vis'] as int,
  );

  Map<String, dynamic> toJson() => {
    'time': time,
    'expired': expired,
    'lat': lat,
    'lng': lng,
    'locality': locality,
    'tmp': tmp,
    'code': code,
    'text': text,
    'forecasts': forecasts?.map((e) => e.toJson()).toList(),
    'hourly': hourly?.map((e) => e.toJson()).toList(),
    'min': min,
    'max': max,
    'windSpeed': windSpeed,
    'pressure': pressure,
    'windScale': windScale,
    'vis': vis,
  };
}