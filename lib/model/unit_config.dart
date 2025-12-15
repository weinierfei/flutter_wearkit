/// 长度单位类型
class LengthUnit {
  static const int METRIC = 0; // 公制单位（米/公里）
  static const int IMPERIAL = 1; // 英制单位（英尺/英里）
}

/// 重量单位类型
class WeightUnit {
  static const int METRIC = 0; // 公制单位（千克）
  static const int IMPERIAL = 1; // 英制单位（磅）
}

/// 温度单位类型
class TemperatureUnit {
  static const int CENTIGRADE = 0; // 摄氏度
  static const int FAHRENHEIT = 1; // 华氏度
}

class UnitConfig {
  final int length;
  final int temperature;

  /// 创建单位配置
  UnitConfig({
    this.length = LengthUnit.METRIC,
    this.temperature = TemperatureUnit.CENTIGRADE,
  });

  bool get isMetric => length == LengthUnit.METRIC;

  bool get isLengthMetric => length == LengthUnit.METRIC;

  bool get isWeightMetric => length == LengthUnit.METRIC;

  bool get isTemperatureCentigrade => temperature == TemperatureUnit.CENTIGRADE;

  // --- 重写操作符和打印 ---
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UnitConfig &&
          runtimeType == other.runtimeType &&
          length == other.length &&
          temperature == other.temperature;

  @override
  int get hashCode => length.hashCode ^ temperature.hashCode;

  /// 复制并修改配置
  UnitConfig copyWith({
    int? length,
    int? temperature,
  }) {
    return UnitConfig(
      length: length ?? this.length,
      temperature: temperature ?? this.temperature,
    );
  }

  @override
  String toString() =>
      'UnitConfig{长度单位: ${length == LengthUnit.METRIC ? "公制" : "英制"}, '
      '温度单位: ${temperature == TemperatureUnit.CENTIGRADE ? "摄氏度" : "华氏度"}}';
}
