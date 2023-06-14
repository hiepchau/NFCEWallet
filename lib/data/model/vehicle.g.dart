// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Vehicle _$VehicleFromJson(Map<String, dynamic> json) => Vehicle(
      json['_id'] as String?,
      json['licensePlate'] as String?,
      json['brand'] as String?,
      json['seats'] as int?,
      json['pricePerDay'] as int?,
      json['color'] as String?,
      json['description'] as String?,
      json['address'] as String?,
      json['province'] as String?,
      json['city'] as String?,
      (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['owner'] as String?,
    );

Map<String, dynamic> _$VehicleToJson(Vehicle instance) => <String, dynamic>{
      '_id': instance.id,
      'licensePlate': instance.licensePlate,
      'brand': instance.brand,
      'seats': instance.seats,
      'pricePerDay': instance.pricePerDay,
      'color': instance.color,
      'description': instance.description,
      'address': instance.address,
      'province': instance.province,
      'city': instance.city,
      'images': instance.images,
      'owner': instance.owner,
    };
