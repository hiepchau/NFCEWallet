
import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/user.dart';

import 'response/base_response.dart';
import 'response/list_model_response.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{
  @JsonKey(name: "_id")
  final String id;
  final User fromUser;
  final User toUser;
  final String type;
  final String amount;
  String? message;
  String? status;
  DateTime? time;

  Transaction({
    required this.id,
    required this.fromUser,
    required this.toUser,
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

extension TransactionListIdExtension on ListModelResponse{
  List<String>? toListIdTransaction(){
    if(this.data.length == 0)
      return null;
    List<String> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(item['_id']);
    }
    print("List transaction_item_bloc.dart id: $rs");
    return rs;
  }
}