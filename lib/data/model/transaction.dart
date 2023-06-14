
import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/user.dart';

import 'response/base_response.dart';
import 'response/list_model_response.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction{
  @JsonKey(name: "_id")
  String? id;
  User? fromUser;
  User? toUser;
  String? amount;
  String? message;
  String? referenceName;
  DateTime? time;

  Transaction({
    this.id,
    this.fromUser,
    this.toUser,
    this.amount,
    this.message,
    this.time,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
extension ArticleExtension on BaseResponse{
  Transaction? toTransaction(){
    if(this.data == null)
      return null;
    return Transaction.fromJson(this.data!);
  }
}

extension TransactionListIdExtension on ListModelResponse{
  List<String>? toListIdArticle(){
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