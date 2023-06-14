import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/response/avatar_file_response.dart';
import 'package:nfc_e_wallet/data/model/response/base_response.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String id;
  final DateTime birthday;
  final String identifyId;
  final String fullname;
  final String phonenumber;
  String? city;
  String? job;
  String? device;
  String? devicetoken;
  User(
      this.id,
      this.birthday,
      this.identifyId,
      this.fullname,
      this.phonenumber,
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

extension UserFileExtension on AvatarResponse{
  List<String>? toListString(){
    var list = this.data!;
    if(list == null)
      return null;
    List<String> rs = List<String>.from(list);
    print(rs);
    return rs;
  }
}
