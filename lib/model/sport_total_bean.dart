import 'package:flutter_wearkit/model/dirty_status.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sport_total_bean.g.dart';

@JsonSerializable()
class SportTotalBean {
  int count;

  double distance;

  /// 是否是脏数据
  int dirty;

  /// 同步成功时间
  int syncSuccessTime;

  SportTotalBean({
    this.count = 0,
    this.distance = 0.0,
    this.dirty = DirtyStatus.FALSE,
    this.syncSuccessTime = 0,
  });

  factory SportTotalBean.fromJson(Map<String, dynamic> srcJson) =>
      _$SportTotalBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SportTotalBeanToJson(this);

  @override
  String toString() {
    return 'SportTotalBean{count: $count, distance: $distance, dirty: $dirty, syncSuccessTime: $syncSuccessTime}';
  }
}
