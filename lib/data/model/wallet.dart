
import 'package:json_annotation/json_annotation.dart';

import 'response/base_response.dart';
import 'response/list_model_response.dart';

part 'wallet.g.dart';

@JsonSerializable()
class Wallet{
  @JsonKey(name: "id")
  final String? id;
  final int? balance;
  final String? name;
  final String? type;
  String? cardnumber;

  Wallet({
    this.id,
    this.balance,
    this.name,
    this.type, 
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);
  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
extension WalletExtension on BaseResponse{
  Wallet? toWallet(){
    if(this.data == null)
      return null;
    return Wallet.fromJson(this.data!);
  }
}

extension WalletListExtension on ListModelResponse{
  List<Wallet>? toListWallet(){
    if(this.data.length == 0)
      return null;
    List<Wallet> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Wallet.fromJson(item));
    }
    print("List wallet: $rs");
    return rs;
  }

}