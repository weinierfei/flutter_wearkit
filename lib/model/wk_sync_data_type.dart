/// 定义可以同步的数据类型常量。
class WKSyncDataType {
  WKSyncDataType._(); // 私有构造函数，防止实例化。

  static const int ERROR = 0;

  static const int ACTIVITY = 1;

  static const int SLEEP = 2;

  static const int HEART_RATE = 3;

  static const int HEART_RATE_RESTING = 4;

  static const int BLOOD_OXYGEN = 5;

  static const int BLOOD_PRESSURE = 6;

  static const int PRESSURE = 7;

  static const int SPORT = 8;

  static const int HEART_RATE_MANUAL = 9;

  static const int BLOOD_PRESSURE_MANUAL = 10;

  static const int BLOOD_OXYGEN_MANUAL = 11;

  static const int PRESSURE_MANUAL = 12;

  static const int TEMPERATURE = 13;

  static const int TEMPERATURE_MANUAL = 14;

  /// 此类型总是返回今天的总活动数据。
  static const int ACTIVITY_TODAY_ALL = 99;
}