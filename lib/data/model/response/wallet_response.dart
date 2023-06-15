import 'package:json_annotation/json_annotation.dart';

import '../transaction.dart';
import '../user.dart';

part 'wallet_response.g.dart';

@JsonSerializable()
class WalletResponse{
  final List<String>? data;

  WalletResponse(
      {
        required this.data});

  factory WalletResponse.fromJson(Map<String, dynamic> json) =>
      _$WalletResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WalletResponseToJson(this);
}
