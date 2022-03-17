import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'time_slots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_TIME_SLOTS_VO)
class TimeSlotsVO {
  @JsonKey(name: 'cinema_day_timeslot_id')
  @HiveField(0)
  int? cinemaDayTimeSlotID;

  @JsonKey(name: 'start_time')
  @HiveField(1)
  String? startTime;

  late bool isSelect;

  TimeSlotsVO.normal();
  TimeSlotsVO(this.cinemaDayTimeSlotID, this.startTime,
      {this.isSelect = false});

  factory TimeSlotsVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotsVOToJson(this);

  @override
  String toString() {
    return 'TimeSlotsVO{cinemaDayTimeSlotID: $cinemaDayTimeSlotID, startTime: $startTime, isSelect: $isSelect}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotsVO &&
          runtimeType == other.runtimeType &&
          cinemaDayTimeSlotID == other.cinemaDayTimeSlotID &&
          startTime == other.startTime &&
          isSelect == other.isSelect;

  @override
  int get hashCode =>
      cinemaDayTimeSlotID.hashCode ^ startTime.hashCode ^ isSelect.hashCode;
}
