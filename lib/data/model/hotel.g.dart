// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hotel _$HotelFromJson(Map<String, dynamic> json) => Hotel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      address: json['address'] as String?,
      owner: json['owner'] as String?,
      description: json['description'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      facilities: (json['facilities'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      province: json['province'] as String?,
      city: json['city'] as String?,
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      minPrice: (json['minPrice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'address': instance.address,
      'owner': instance.owner,
      'description': instance.description,
      'images': instance.images,
      'facilities': instance.facilities,
      'maxPrice': instance.maxPrice,
      'minPrice': instance.minPrice,
      'province': instance.province,
      'city': instance.city,
    };
