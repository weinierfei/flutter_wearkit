import 'package:json_annotation/json_annotation.dart';

part 'notification_other_bean.g.dart';

@JsonSerializable()
class NotificationOtherBean {
  String appName;

  String packageName;

  NotificationOtherBean(
    this.appName,
    this.packageName,
  );

  factory NotificationOtherBean.fromJson(Map<String, dynamic> srcJson) =>
      _$NotificationOtherBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$NotificationOtherBeanToJson(this);

  @override
  String toString() {
    return 'NotificationOtherBean{appName: $appName, packageName: $packageName}';
  }
}
