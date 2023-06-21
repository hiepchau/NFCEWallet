// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['id'] as int,
      json['birthday'] == null
          ? null
          : DateTime.parse(json['birthday'] as String),
      json['identifyId'] as String?,
      json['full_name'] as String,
      json['phone_number'] as String,
      json['city'] as String?,
      json['job'] as String?,
      json['device'] as String?,
      json['devicetoken'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'birthday': instance.birthday?.toIso8601String(),
      'identifyId': instance.identifyId,
      'full_name': instance.full_name,
      'phone_number': instance.phone_number,
      'city': instance.city,
      'job': instance.job,
      'device': instance.device,
      'devicetoken': instance.devicetoken,
    };
