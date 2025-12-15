/// 数据同步状态枚举
class DirtyStatus {
  /// 没有更改，不是脏数据
  static const int FALSE = 0;

  /// 有更改，是脏数据，需要去上传
  static const int TRUE = 1;

  /// 有更改，是脏数据，但是数据时间错误，导致无法上传(lastModifyTime时间错误)
  static const int ERROR_TIME = 2;
}
