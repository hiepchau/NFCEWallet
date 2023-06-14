// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Promotion _$PromotionFromJson(Map<String, dynamic> json) => Promotion(
      json['_id'] as String?,
      json['description'] as String?,
      json['starttime'] == null
          ? null
          : DateTime.parse(json['starttime'] as String),
      json['endtime'] == null
          ? null
          : DateTime.parse(json['endtime'] as String),
      json['type'] as String?,
      json['name'] as String?,
      json['amount'] as int?,
    );

Map<String, dynamic> _$PromotionToJson(Promotion instance) => <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'starttime': instance.starttime?.toIso8601String(),
      'endtime': instance.endtime?.toIso8601String(),
      'type': instance.type,
      'name': instance.name,
      'amount': instance.amount,
    };
