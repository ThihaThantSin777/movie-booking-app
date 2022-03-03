// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seating_type_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatinTypeVO _$SeatinTypeVOFromJson(Map<String, dynamic> json) => SeatinTypeVO(
      json['id'] as int?,
      json['type'] as String?,
      json['seat_name'] as String?,
      json['symbol'] as String?,
      json['price'] as int?,
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$SeatinTypeVOToJson(SeatinTypeVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelect': instance.isSelect,
    };
