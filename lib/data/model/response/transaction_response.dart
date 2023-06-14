import 'package:json_annotation/json_annotation.dart';

import '../transaction.dart';
import '../user.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse{
  @JsonKey(name: 'from_Transaction')
  Transaction fromTransaction;
  @JsonKey(name: 'from_User')
  User fromUser;
  @JsonKey(name: 'to_User')
  User toUser;
  TransactionResponse({required this.fromTransaction, required this.fromUser, required this.toUser});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}