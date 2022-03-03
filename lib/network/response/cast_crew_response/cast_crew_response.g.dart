// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_crew_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastCrewResponse _$CastCrewResponseFromJson(Map<String, dynamic> json) =>
    CastCrewResponse(
      json['id'] as int?,
      (json['cast'] as List<dynamic>?)
          ?.map((e) => CastCrewVO.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['crew'] as List<dynamic>?)
          ?.map((e) => CastCrewVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CastCrewResponseToJson(CastCrewResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cast': instance.cast,
      'crew': instance.crew,
    };
