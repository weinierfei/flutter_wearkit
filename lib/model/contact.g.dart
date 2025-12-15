// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contacts _$ContactsFromJson(Map<String, dynamic> json) =>
    Contacts(name: json['_name'] as String, number: json['_number'] as String);

Map<String, dynamic> _$ContactsToJson(Contacts instance) => <String, dynamic>{
  '_name': instance.name,
  '_number': instance.number,
};

CommonContactList _$CommonContactListFromJson(Map<String, dynamic> json) =>
    CommonContactList(
      items: (json['items'] as List<dynamic>)
          .map((e) => Contacts.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommonContactListToJson(CommonContactList instance) =>
    <String, dynamic>{'items': instance.items};

EmergencyContactList _$EmergencyContactListFromJson(
  Map<String, dynamic> json,
) => EmergencyContactList(
  items: (json['items'] as List<dynamic>)
      .map((e) => Contacts.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$EmergencyContactListToJson(
  EmergencyContactList instance,
) => <String, dynamic>{'items': instance.items};

WKContactsAll _$WKContactsAllFromJson(Map<String, dynamic> json) =>
    WKContactsAll(
      common: CommonContactList.fromJson(
        json['common'] as Map<String, dynamic>,
      ),
      emergency: EmergencyContactList.fromJson(
        json['emergency'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$WKContactsAllToJson(WKContactsAll instance) =>
    <String, dynamic>{
      'common': instance.common,
      'emergency': instance.emergency,
    };
