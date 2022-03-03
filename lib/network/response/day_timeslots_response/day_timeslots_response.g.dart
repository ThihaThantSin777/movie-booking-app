// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_timeslots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayTimeSlotsResponse _$DayTimeSlotsResponseFromJson(
        Map<String, dynamic> json) =>
    DayTimeSlotsResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => DayTimeSlotVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayTimeSlotsResponseToJson(
        DayTimeSlotsResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
