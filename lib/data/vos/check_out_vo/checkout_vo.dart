import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_snack_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';

part 'checkout_vo.g.dart';

@JsonSerializable()
class CheckoutVO {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'booking_no')
  String? bookingNo;

  @JsonKey(name: 'booking_date')
  String? bookingDate;

  @JsonKey(name: 'row')
  String? row;

  @JsonKey(name: 'seat')
  String? seat;

  @JsonKey(name: 'total_seat')
  int? totalSeat;

  @JsonKey(name: 'total')
  String? total;

  @JsonKey(name: 'movie_id')
  int? movieID;

  @JsonKey(name: 'cinema_id')
  int? cinemaID;

  @JsonKey(name: 'user_name')
  String? userName;

  @JsonKey(name: 'timeslot')
  TimeSlotsVO? timeslot;

  @JsonKey(name: 'snacks')
  List<CheckoutSnackVO>? snacks;

  @JsonKey(name: 'qr_code')
  String? qrCode;

  CheckoutVO(
      this.id,
      this.bookingNo,
      this.bookingDate,
      this.row,
      this.seat,
      this.totalSeat,
      this.total,
      this.movieID,
      this.cinemaID,
      this.userName,
      this.timeslot,
      this.snacks,
      this.qrCode);

  CheckoutVO.normal();

  factory CheckoutVO.fromJson(Map<String, dynamic> json) =>
      _$CheckoutVOFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutVOToJson(this);

  @override
  String toString() {
    return 'CheckoutVO{id: $id, bookingNo: $bookingNo, bookingDate: $bookingDate, row: $row, seat: $seat, totalSeat: $totalSeat, total: $total, movieID: $movieID, cinemaID: $cinemaID, userName: $userName, timeslot: $timeslot, snacks: $snacks, qrCode: $qrCode}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckoutVO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          bookingNo == other.bookingNo &&
          bookingDate == other.bookingDate &&
          row == other.row &&
          seat == other.seat &&
          totalSeat == other.totalSeat &&
          total == other.total &&
          movieID == other.movieID &&
          cinemaID == other.cinemaID &&
          userName == other.userName &&
          timeslot == other.timeslot &&
          snacks == other.snacks &&
          qrCode == other.qrCode;

  @override
  int get hashCode =>
      id.hashCode ^
      bookingNo.hashCode ^
      bookingDate.hashCode ^
      row.hashCode ^
      seat.hashCode ^
      totalSeat.hashCode ^
      total.hashCode ^
      movieID.hashCode ^
      cinemaID.hashCode ^
      userName.hashCode ^
      timeslot.hashCode ^
      snacks.hashCode ^
      qrCode.hashCode;
}
