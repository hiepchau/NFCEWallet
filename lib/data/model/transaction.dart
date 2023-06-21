
import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/user.dart';

import 'response/base_response.dart';
import 'response/list_model_response.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{
  @JsonKey(name: "id")
  final int id;
  final String from_User;
  final String to_User;
  final String type;
  final int amount;
  String? message;
  String? status;
  String? time;

  Transaction({
    required this.id,
    required this.from_User,
    required this.to_User,
    required this.type,
    required this.amount,
    this.message,
    this.status,
    this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
extension TransactionExtension on BaseResponse{
  Transaction? toTransaction(){
    if(this.data == null)
      return null;
    return Transaction.fromJson(this.data!);
  }
}

extension TransactionListExtension on ListModelResponse{
  List<Transaction>? toListTransaction(){
    if(this.data.length == 0)
      return null;
    List<Transaction> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Transaction.fromJson(item));
    }
    print("List transaction: $rs");
    return rs;
  }
}
