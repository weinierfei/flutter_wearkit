/// 睡眠算法枚举
enum WKSleepAlgorithm {
  /// [WKDeviceType.FIT_CLOUD] 默认睡眠算法。
  /// 小睡 (不支持)
  /// REM (不支持)
  FITCLOUD_DEFAULT(1),

  /// [WKDeviceType.FIT_CLOUD] 支持小睡的睡眠算法。
  /// 小睡 (支持)
  /// REM (不支持)
  FITCLOUD_NAP(2),

  /// [WKDeviceType.FLY_WEAR] 默认睡眠算法。
  /// 小睡 (支持)
  /// REM (支持)
  FLYWEAR_DEFAULT(10001),

  /// [WKDeviceType.FLY_WEAR] 用于 oraimo-app 的睡眠算法。
  /// 小睡 (支持)
  /// REM (支持)
  FLYWEAR_ORAIMO(10002),

  /// [WKDeviceType.SHEN_JU] 默认睡眠算法。
  /// 小睡 (不支持)
  /// REM (支持)
  SHENJU_DEFAULT(20001);

  /// 枚举对应的 ID
  final int id;

  /// 枚举的常量构造函数
  const WKSleepAlgorithm(this.id);
}
