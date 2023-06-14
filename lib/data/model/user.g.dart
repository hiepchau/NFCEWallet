// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      json['_id'] as String,
      json['gender'] as int,
      json['email'] as String,
      json['fullname'] as String,
      json['phonenumber'] as String,
      json['address'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'gender': instance.gender,
      'email': instance.email,
      'fullname': instance.fullname,
      'phonenumber': instance.phonenumber,
      'address': instance.address,
    };
