import 'package:flutter_wearkit/model/device_info.dart';
import 'package:json_annotation/json_annotation.dart';

part 'firmware_upgrade_bean.g.dart';

@JsonSerializable()
class FirmwareUpgradeBean extends Object {
  @JsonKey(name: 'status')
  int status;

  @JsonKey(name: 'firmware_version')
  String? firmwareVersion;

  @JsonKey(name: 'prc_version')
  String? prcVersion;

  @JsonKey(name: 'ota_file')
  String? otaFile;

  @JsonKey(name: 'ota_file_size')
  int? otaFileSize;

  @JsonKey(name: 'ota_file_md5')
  String? otaFileMd5;

  FirmwareUpgradeBean(
    this.status,
    this.firmwareVersion,
    this.prcVersion,
    this.otaFile,
    this.otaFileSize,
    this.otaFileMd5,
  );

  factory FirmwareUpgradeBean.fromJson(Map<String, dynamic> srcJson) =>
      _$FirmwareUpgradeBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$FirmwareUpgradeBeanToJson(this);

  @override
  String toString() {
    return 'FirmwareUpgradeBean{status: $status, firmwareVersion: $firmwareVersion, prcVersion: $prcVersion, otaFile: $otaFile, otaFileSize: $otaFileSize, otaFileMd5: $otaFileMd5}';
  }

  FirmwareUpgradeBean? convertData(DeviceInfo deviceInfo) {
    if (status == 0) {
      return null;
    }
    if (firmwareVersion == null || firmwareVersion!.isEmpty) {
      if (prcVersion== null || prcVersion!.isEmpty) {
        return null;
      } else {
        return FirmwareUpgradeBean(
          status,
          displayVersion(deviceInfo.version, prcVersion!),
          prcVersion,
          otaFile,
          otaFileSize,
          otaFileMd5,
        );
      }
    } else {
      if (prcVersion== null || prcVersion!.isEmpty) {
        return FirmwareUpgradeBean(
          status,
          displayVersion(firmwareVersion!, deviceInfo.version),
          prcVersion,
          otaFile,
          otaFileSize,
          otaFileMd5,
        );
      } else {
        return FirmwareUpgradeBean(
          status,
          displayVersion(firmwareVersion!, prcVersion!),
          prcVersion,
          otaFile,
          otaFileSize,
          otaFileMd5,
        );
      }
    }
  }
}

String displayVersion(String version, String jsVer) {
  return "$version(JS$jsVer)";
}

String getDisplayVersion(DeviceInfo deviceInfo) {
  return displayVersion(deviceInfo.version, deviceInfo.version);
}
