// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_raw_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutRawResponse _$CheckOutRawResponseFromJson(Map<String, dynamic> json) =>
    CheckOutRawResponse(
      json['cinema_day_timeslot_id'] as int?,
      json['row'] as String?,
      json['seat_number'] as String?,
      json['booking_date'] as String?,
      json['total_price'] as int?,
      json['movie_id'] as int?,
      json['card_id'] as int?,
      json['cinema_id'] as int?,
      (json['snacks'] as List<dynamic>?)
          ?.map((e) => SnackAndPaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CheckOutRawResponseToJson(
        CheckOutRawResponse instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeSlotId,
      'row': instance.row,
      'seat_number': instance.seatNumber,
      'booking_date': instance.bookingDate,
      'total_price': instance.totalPrice,
      'movie_id': instance.movieId,
      'card_id': instance.cardId,
      'cinema_id': instance.cinemaID,
      'snacks': instance.snacks,
    };
