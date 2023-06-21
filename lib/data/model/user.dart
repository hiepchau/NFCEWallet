
import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/response/base_response.dart';
import 'package:nfc_e_wallet/data/model/response/transaction_response.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final int id;
  final DateTime? birthday;
  final String? identifyId;
  final String full_name;
  final String phone_number;
  String? city;
  String? job;
  String? device;
  String? devicetoken;
  User(
      this.id,
      this.birthday,
      this.identifyId,
      this.full_name,
      this.phone_number,
      this.city, 
      this.job,
      this.device,
      this.devicetoken
      );

  factory User.fromJson(Map<String, dynamic> json) =>
      _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

extension UserExtension on BaseResponse {
  User? toUser() {
    if(this.data == null)
      return null;
    return User.fromJson(this.data!);
  }
}

extension UserFileExtension on TransactionResponse{
  List<String>? toListString(){
    var list = this.data!;
    if(list == null)
      return null;
    List<String> rs = List<String>.from(list);
    print(rs);
    return rs;
  }
}
