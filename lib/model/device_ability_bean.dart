import 'package:json_annotation/json_annotation.dart';

part 'device_ability_bean.g.dart';

@JsonSerializable()
class DeviceAbilityBean {
  bool isSupportContact;

  bool isSupportWeather;

  bool isSupportMusic;

  bool isSupportBusinessCard;

  bool isSupportPaymentCode;

  bool isSupportRemind;

  bool isSupportEBook;

  bool isSupportAlbum;

  bool isSupportAlarm;

  bool isSupportEmergencyContact;

  bool isSupportSportPush;

  DeviceAbilityBean({
    this.isSupportContact = false,
    this.isSupportWeather = false,
    this.isSupportMusic = false,
    this.isSupportBusinessCard = false,
    this.isSupportPaymentCode = false,
    this.isSupportRemind = false,
    this.isSupportEBook = false,
    this.isSupportAlbum = false,
    this.isSupportAlarm = false,
    this.isSupportEmergencyContact = false,
    this.isSupportSportPush = false,
  });

  factory DeviceAbilityBean.fromJson(Map<String, dynamic> srcJson) =>
      _$DeviceAbilityBeanFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DeviceAbilityBeanToJson(this);
}
