// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_model_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListModelResponse _$ListModelResponseFromJson(Map<String, dynamic> json) =>
    ListModelResponse(
      (json['data'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$ListModelResponseToJson(ListModelResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
