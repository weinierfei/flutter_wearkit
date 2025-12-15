import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'contact.g.dart';

@JsonSerializable()
class Contacts {
  @JsonKey(name: '_name') final String name;
  @JsonKey(name: '_number') final String number;

  Map<String, dynamic> toJson() => _$ContactsToJson(this);

  factory Contacts.fromJson(Map<String, dynamic> json) =>
      _$ContactsFromJson(json);

  Contacts({required this.name, required this.number});

  @override
  String toString() {
    return 'Contacts{name: $name, number: $number}';
  }
}

@JsonSerializable()
class CommonContactList {
  final List<Contacts> items;

  Map<String, dynamic> toJson() => _$CommonContactListToJson(this);

  factory CommonContactList.fromJson(Map<String, dynamic> json) =>
      _$CommonContactListFromJson(json);

  CommonContactList({required this.items});
}

@JsonSerializable()
class EmergencyContactList {
  final List<Contacts> items;

  Map<String, dynamic> toJson() => _$EmergencyContactListToJson(this);

  factory EmergencyContactList.fromJson(Map<String, dynamic> json) =>
      _$EmergencyContactListFromJson(json);

  EmergencyContactList({required this.items});
}

@JsonSerializable()
class WKContactsAll {
  final CommonContactList common;
  final EmergencyContactList emergency;

  Map<String, dynamic> toJson() => _$WKContactsAllToJson(this);

  factory WKContactsAll.fromJson(Map<String, dynamic> json) =>
      _$WKContactsAllFromJson(json);

  WKContactsAll({required this.common, required this.emergency});
}
