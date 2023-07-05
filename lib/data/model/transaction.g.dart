// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      id: json['id'] as int,
      from_User: json['from_User'] as String,
      to_User: json['to_User'] as String,
      type: json['type'] as String,
      amount: json['amount'] as int,
      message: json['message'] as String?,
      status: json['status'] as String?,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'from_User': instance.from_User,
      'to_User': instance.to_User,
      'type': instance.type,
      'amount': instance.amount,
      'message': instance.message,
      'status': instance.status,
      'time': instance.time,
    };
