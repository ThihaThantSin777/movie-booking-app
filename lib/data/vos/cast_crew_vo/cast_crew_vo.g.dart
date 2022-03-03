// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_crew_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CastCrewVOAdapter extends TypeAdapter<CastCrewVO> {
  @override
  final int typeId = 9;

  @override
  CastCrewVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CastCrewVO(
      fields[0] as bool?,
      fields[1] as int?,
      fields[2] as int?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as double?,
      fields[7] as String?,
      fields[8] as int?,
      fields[9] as String?,
      fields[10] as String?,
      fields[11] as int?,
      fields[12] as String?,
      fields[13] as String?,
      castList: (fields[14] as List?)?.cast<CastCrewVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CastCrewVO obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.adult)
      ..writeByte(1)
      ..write(obj.gender)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.knownForDepartment)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.originalName)
      ..writeByte(6)
      ..write(obj.popularity)
      ..writeByte(7)
      ..write(obj.profilePath)
      ..writeByte(8)
      ..write(obj.castId)
      ..writeByte(9)
      ..write(obj.creditId)
      ..writeByte(10)
      ..write(obj.character)
      ..writeByte(11)
      ..write(obj.order)
      ..writeByte(12)
      ..write(obj.department)
      ..writeByte(13)
      ..write(obj.job)
      ..writeByte(14)
      ..write(obj.castList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastCrewVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastCrewVO _$CastCrewVOFromJson(Map<String, dynamic> json) => CastCrewVO(
      json['adult'] as bool?,
      json['gender'] as int?,
      json['id'] as int?,
      json['known_for_department'] as String?,
      json['name'] as String?,
      json['original_name'] as String?,
      (json['popularity'] as num?)?.toDouble(),
      json['profile_path'] as String?,
      json['cast_id'] as int?,
      json['credit_id'] as String?,
      json['character'] as String?,
      json['order'] as int?,
      json['department'] as String?,
      json['job'] as String?,
      castList: (json['castList'] as List<dynamic>?)
          ?.map((e) => CastCrewVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CastCrewVOToJson(CastCrewVO instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'cast_id': instance.castId,
      'credit_id': instance.creditId,
      'character': instance.character,
      'order': instance.order,
      'department': instance.department,
      'job': instance.job,
      'castList': instance.castList,
    };
