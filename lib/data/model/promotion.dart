
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_e_wallet/data/model/response/list_model_response.dart';

part 'promotion.g.dart';

@JsonSerializable()
class Promotion{
  @JsonKey(name: '_id')
  final String? id;
  final String? description;
  final DateTime? starttime;
  final DateTime? endtime;
  final String? type;
  final String? name;
  final int? amount;


  Promotion(
      this.id,
      this.description,
      this.starttime, 
      this.endtime, 
      this.type, 
      this.name, 
      this.amount
  );

  factory Promotion.fromJson(Map<String, dynamic> json) =>
      _$PromotionFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionToJson(this);
}

extension PromotionExtension on ListModelResponse{
  List<Promotion>? toListPromotion(){
    if(this.data.length == 0)
      return null;
    List<Promotion> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Promotion.fromJson(item));
    }
    print("List Promotion: $rs");
    return rs;
  }
}