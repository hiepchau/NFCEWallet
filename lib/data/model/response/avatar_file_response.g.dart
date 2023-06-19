// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'avatar_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvatarResponse _$AvatarResponseFromJson(Map<String, dynamic> json) =>
    AvatarResponse(
      data: (json['data'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$AvatarResponseToJson(AvatarResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
