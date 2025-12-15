import 'package:json_annotation/json_annotation.dart';

part 'wk_monitor_config.g.dart';

@JsonSerializable()
class WKMonitorConfig {

  bool isEnabled;

  int start;

  int end;

  int interval;

  WKMonitorConfig(this.isEnabled,this.start,this.end,this.interval,);

  factory WKMonitorConfig.fromJson(Map<String, dynamic> srcJson) => _$WKMonitorConfigFromJson(srcJson);

  Map<String, dynamic> toJson() => _$WKMonitorConfigToJson(this);

  @override
  String toString() {
    return 'WKMonitorConfig{isEnabled: $isEnabled, start: $start, end: $end, interval: $interval}';
  }
}


