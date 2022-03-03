import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

part 'check_out_raw_response.g.dart';

@JsonSerializable()
class CheckOutRawResponse {
  @JsonKey(name: "cinema_day_timeslot_id")
  int? cinemaDayTimeSlotId;

  @JsonKey(name: 'row')
  String? row;

  @JsonKey(name: "seat_number")
  String? seatNumber;

  @JsonKey(name: "booking_date")
  String? bookingDate;

  @JsonKey(name: 'total_price')
  int? totalPrice;

  @JsonKey(name: "movie_id")
  int? movieId;

  @JsonKey(name: "card_id")
  int? cardId;

  @JsonKey(name: 'cinema_id')
  int? cinemaID;

  @JsonKey(name: "snacks")
  List<SnackAndPaymentVO>? snacks;

  CheckOutRawResponse(
      this.cinemaDayTimeSlotId,
      this.row,
      this.seatNumber,
      this.bookingDate,
      this.totalPrice,
      this.movieId,
      this.cardId,
      this.cinemaID,
      this.snacks);

  factory CheckOutRawResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckOutRawResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckOutRawResponseToJson(this);

  @override
  String toString() {
    return 'CheckOutRawResponse{cinemaDayTimeSlotId: $cinemaDayTimeSlotId, row: $row, seatNumber: $seatNumber, bookingDate: $bookingDate, totalPrice: $totalPrice, movieId: $movieId, cardId: $cardId, cinemaID: $cinemaID, snacks: $snacks}';
  }
}
