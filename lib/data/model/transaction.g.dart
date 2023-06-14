// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['_id'] as String,
      fromUser: User.fromJson(json['fromUser'] as Map<String, dynamic>),
      toUser: User.fromJson(json['toUser'] as Map<String, dynamic>),
      type: json['type'] as String,
      amount: json['amount'] as String,
      message: json['message'] as String?,
      status: json['status'] as String?,
      time:
          json['time'] == null ? null : DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'fromUser': instance.fromUser,
      'toUser': instance.toUser,
      'type': instance.type,
      'amount': instance.amount,
      'message': instance.message,
      'status': instance.status,
      'time': instance.time?.toIso8601String(),
    };
