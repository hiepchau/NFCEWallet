// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['_id'] as String?,
      fromUser: json['fromUser'] == null
          ? null
          : User.fromJson(json['fromUser'] as Map<String, dynamic>),
      toUser: json['toUser'] == null
          ? null
          : User.fromJson(json['toUser'] as Map<String, dynamic>),
      amount: json['amount'] as String?,
      message: json['message'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    )..referenceName = json['referenceName'] as String?;

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'amount': instance.amount,
      'message': instance.message,
      'referenceName': instance.referenceName,
      'time': instance.time?.toIso8601String(),
    };
