import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';

part 'day_timeslots_response.g.dart';

@JsonSerializable()
class DayTimeSlotsResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<DayTimeSlotVO>? data;

  DayTimeSlotsResponse(this.code, this.message, this.data);

  factory DayTimeSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$DayTimeSlotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeSlotsResponseToJson(this);
}
