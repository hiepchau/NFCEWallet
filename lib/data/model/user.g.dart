// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['_id'] as String,
      DateTime.parse(json['birthday'] as String),
      json['identifyId'] as String,
      json['fullname'] as String,
      json['phonenumber'] as String,
      json['city'] as String?,
      json['job'] as String?,
      json['device'] as String?,
      json['devicetoken'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'birthday': instance.birthday.toIso8601String(),
      'identifyId': instance.identifyId,
      'fullname': instance.fullname,
      'phonenumber': instance.phonenumber,
      'city': instance.city,
      'job': instance.job,
      'device': instance.device,
      'devicetoken': instance.devicetoken,
    };
