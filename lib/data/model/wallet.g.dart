// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Wallet _$WalletFromJson(Map<String, dynamic> json) => Wallet(
      json['id'] as int,
      json['balance'] as int?,
      json['name'] as String?,
      json['type'] as String?,
      json['card_number'] as String?,
    );

Map<String, dynamic> _$WalletToJson(Wallet instance) => <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'name': instance.name,
      'type': instance.type,
      'card_number': instance.card_number,
    };
