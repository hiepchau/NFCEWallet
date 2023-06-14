// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotelroom.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelRoom _$HotelRoomFromJson(Map<String, dynamic> json) => HotelRoom(
      json['_id'] as String?,
      json['number'] as int?,
      json['hotel'] as String?,
      json['adultCapacity'] as int?,
      json['childrenCapacity'] as int?,
      json['price'] as int?,
      json['checkInHour'] as int?,
      json['checkInMinute'] as int?,
      json['checkOutHour'] as int?,
      json['checkOutMinute'] as int?,
    );

Map<String, dynamic> _$HotelRoomToJson(HotelRoom instance) => <String, dynamic>{
      '_id': instance.id,
      'number': instance.number,
      'hotel': instance.hotel,
      'adultCapacity': instance.adultCapacity,
      'childrenCapacity': instance.childrenCapacity,
      'price': instance.price,
      'checkInHour': instance.checkInHour,
      'checkInMinute': instance.checkInMinute,
      'checkOutHour': instance.checkOutHour,
      'checkOutMinute': instance.checkOutMinute,
    };
