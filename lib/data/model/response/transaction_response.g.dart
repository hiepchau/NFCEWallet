// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResponse _$TransactionResponseFromJson(Map<String, dynamic> json) =>
    TransactionResponse(
      fromTransaction: Transaction.fromJson(
          json['from_Transaction'] as Map<String, dynamic>),
      fromUser: User.fromJson(json['from_User'] as Map<String, dynamic>),
      toUser: User.fromJson(json['to_User'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TransactionResponseToJson(
        TransactionResponse instance) =>
    <String, dynamic>{
      'from_Transaction': instance.fromTransaction,
      'from_User': instance.fromUser,
      'to_User': instance.toUser,
    };
