// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeSlotsVOAdapter extends TypeAdapter<TimeSlotsVO> {
  @override
  final int typeId = 12;

  @override
  TimeSlotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeSlotsVO(
      fields[0] as int?,
      fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TimeSlotsVO obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.cinemaDayTimeSlotID)
      ..writeByte(1)
      ..write(obj.startTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotsVO _$TimeSlotsVOFromJson(Map<String, dynamic> json) => TimeSlotsVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
      isSelect: json['isSelect'] as bool? ?? false,
    );

Map<String, dynamic> _$TimeSlotsVOToJson(TimeSlotsVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeSlotID,
      'start_time': instance.startTime,
      'isSelect': instance.isSelect,
    };
