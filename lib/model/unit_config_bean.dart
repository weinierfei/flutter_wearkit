import 'package:json_annotation/json_annotation.dart';

part 'unit_config_bean.g.dart';

/// 单位配置实体
@JsonSerializable()
class UnitConfigBean {
  /// 长度单位
  int length;

  /// 重量单位
  int weight;

  /// 温度单位
  int temperature;

  /// 数据最后更新时间

  int lastModifyTime;

  UnitConfigBean({
    required this.length,
    required this.weight,
    required this.temperature,
    required this.lastModifyTime,
  });

  /// JSON序列化
  factory UnitConfigBean.fromJson(Map<String, dynamic> json) =>
      _$UnitConfigBeanFromJson(json);

  Map<String, dynamic> toJson() => _$UnitConfigBeanToJson(this);
}
