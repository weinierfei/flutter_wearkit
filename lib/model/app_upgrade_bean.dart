import 'package:json_annotation/json_annotation.dart';

part 'app_upgrade_bean.g.dart';

@JsonSerializable()
class AppUpgradeBean extends Object {

  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'android')
  AppUpgradeInfo? android;

  @JsonKey(name: 'ios')
  AppUpgradeInfo? ios;

  AppUpgradeBean(this.status, this.android, this.ios);

  factory AppUpgradeBean.fromJson(Map<String, dynamic> srcJson) =>
      _$AppUpgradeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppUpgradeBeanToJson(this);

}

@JsonSerializable()
class AppUpgradeInfo extends Object {

  @JsonKey(name: 'version')
  String version;

  @JsonKey(name: 'file')
  String file;

  @JsonKey(name: 'file_size')
  int fileSize;

  @JsonKey(name: 'file_md5')
  String fileMd5;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'force')
  int force;

  @JsonKey(name: 'skippable')
  int skippable;

  AppUpgradeInfo(this.version, this.file, this.fileSize, this.fileMd5, this.content,
      this.force, this.skippable,);

  factory AppUpgradeInfo.fromJson(Map<String, dynamic> srcJson) =>
      _$AppUpgradeInfoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$AppUpgradeInfoToJson(this);

  bool isForceUpgrade() {
    return force == 1;
  }
}


