import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'day_timeslot_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_DAYTIME_SLOTS_VO)
class DayTimeSlotVO {
  @JsonKey(name: 'cinema_id')
  @HiveField(0)
  int? cinemaID;

  @JsonKey(name: 'cinema')
  @HiveField(1)
  String? cinema;

  @JsonKey(name: 'timeslots')
  @HiveField(2)
  List<TimeSlotsVO>? timeSlots;

  @HiveField(3)
  List<DayTimeSlotVO>? daytimeSlotVOList;

  DayTimeSlotVO(this.cinemaID, this.cinema, this.timeSlots,{this.daytimeSlotVOList});

  DayTimeSlotVO.normal();

  factory DayTimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$DayTimeSlotVOFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeSlotVOToJson(this);

  @override
  String toString() {
    return 'DayTimeSlotVO{cinemaID: $cinemaID, cinema: $cinema, timeSlots: $timeSlots}';
  }
}
