// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_timeslot_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayTimeSlotVOAdapter extends TypeAdapter<DayTimeSlotVO> {
  @override
  final int typeId = 11;

  @override
  DayTimeSlotVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayTimeSlotVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List?)?.cast<TimeSlotsVO>(),
      daytimeSlotVOList: (fields[3] as List?)?.cast<DayTimeSlotVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayTimeSlotVO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.cinemaID)
      ..writeByte(1)
      ..write(obj.cinema)
      ..writeByte(2)
      ..write(obj.timeSlots)
      ..writeByte(3)
      ..write(obj.daytimeSlotVOList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayTimeSlotVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayTimeSlotVO _$DayTimeSlotVOFromJson(Map<String, dynamic> json) =>
    DayTimeSlotVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>?)
          ?.map((e) => TimeSlotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      daytimeSlotVOList: (json['daytimeSlotVOList'] as List<dynamic>?)
          ?.map((e) => DayTimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayTimeSlotVOToJson(DayTimeSlotVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaID,
      'cinema': instance.cinema,
      'timeslots': instance.timeSlots,
      'daytimeSlotVOList': instance.daytimeSlotVOList,
    };
