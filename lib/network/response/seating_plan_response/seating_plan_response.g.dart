// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seating_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatingPlanResponse _$SeatingPlanResponseFromJson(Map<String, dynamic> json) =>
    SeatingPlanResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>)
              .map((e) => SeatinTypeVO.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$SeatingPlanResponseToJson(
        SeatingPlanResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
