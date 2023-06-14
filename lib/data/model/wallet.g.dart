// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      id: json['_id'] as String?,
      balance: json['balance'] as int?,
      name: json['name'] as String?,
      type: json['type'] as String?,
    )..cardnumber = json['cardnumber'] as String?;

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      '_id': instance.id,
      'balance': instance.balance,
      'name': instance.name,
      'type': instance.type,
      'cardnumber': instance.cardnumber,
    };
