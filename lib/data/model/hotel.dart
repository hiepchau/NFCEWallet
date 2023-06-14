import 'package:json_annotation/json_annotation.dart';

import 'response/list_model_response.dart';

part 'hotel.g.dart';

@JsonSerializable()
class Hotel {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  final String? address;
  final String? owner;
  final String? description;
  final List<String>? images;
  final List<Map<String,dynamic>>? facilities;
  final double? maxPrice;
  final double? minPrice;
  final String? province;
  final String? city;
  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.owner,
    this.description,
    required this.images,
    this.facilities,
    required this.province,
    required this.city,
    this.maxPrice,
    this.minPrice
  }
      );

  factory Hotel.fromJson(Map<String, dynamic> json) =>
      _$HotelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

extension HotelExtension on ListModelResponse{
  List<Hotel>? toListHotel(){
    if(this.data.length == 0)
      return null;
    List<Hotel> rs = [];
    for(Map<String, dynamic> item in this.data){
      rs.add(Hotel.fromJson(item));
    }
    print("List hotel: $rs");
    return rs;
  }
}

