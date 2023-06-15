import 'package:json_annotation/json_annotation.dart';

import '../transaction.dart';
import '../user.dart';

part 'transaction_response.g.dart';

@JsonSerializable()
class TransactionResponse{
  final List<String>? data;

  TransactionResponse(
      {
        required this.data});

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionResponseToJson(this);
}
