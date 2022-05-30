import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'cast_crew_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ACTOR_VO)
class CastCrewVO {
  @JsonKey(name: 'adult')
  @HiveField(0)
  bool? adult;

  @JsonKey(name: 'gender')
  @HiveField(1)
  int? gender;

  @JsonKey(name: 'id')
  @HiveField(2)
  int? id;

  @JsonKey(name: 'known_for_department')
  @HiveField(3)
  String? knownForDepartment;

  @JsonKey(name: 'name')
  @HiveField(4)
  String? name;

  @JsonKey(name: 'original_name')
  @HiveField(5)
  String? originalName;

  @JsonKey(name: 'popularity')
  @HiveField(6)
  double? popularity;

  @JsonKey(name: 'profile_path')
  @HiveField(7)
  String? profilePath;

  @JsonKey(name: 'cast_id')
  @HiveField(8)
  int? castId;

  @JsonKey(name: 'credit_id')
  @HiveField(9)
  String? creditId;

  @JsonKey(name: 'character')
  @HiveField(10)
  String? character;

  @JsonKey(name: 'order')
  @HiveField(11)
  int? order;

  @JsonKey(name: 'department')
  @HiveField(12)
  String? department;

  @JsonKey(name: 'job')
  @HiveField(13)
  String? job;

  @HiveField(14)
  List<CastCrewVO>?castList;
CastCrewVO.normal();
  CastCrewVO(
      this.adult,
      this.gender,
      this.id,
      this.knownForDepartment,
      this.name,
      this.originalName,
      this.popularity,
      this.profilePath,
      this.castId,
      this.creditId,
      this.character,
      this.order,
      this.department,
      this.job,{this.castList});

  factory CastCrewVO.fromJson(Map<String, dynamic> json) =>
      _$CastCrewVOFromJson(json);

  Map<String, dynamic> toJson() => _$CastCrewVOToJson(this);


  @override
  String toString() {
    return 'CastCrewVO{castList: $castList}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CastCrewVO &&
          runtimeType == other.runtimeType &&
          adult == other.adult &&
          gender == other.gender &&
          id == other.id &&
          knownForDepartment == other.knownForDepartment &&
          name == other.name &&
          originalName == other.originalName &&
          popularity == other.popularity &&
          profilePath == other.profilePath &&
          castId == other.castId &&
          creditId == other.creditId &&
          character == other.character &&
          order == other.order &&
          department == other.department &&
          job == other.job &&
          castList == other.castList;

  @override
  int get hashCode =>
      adult.hashCode ^
      gender.hashCode ^
      id.hashCode ^
      knownForDepartment.hashCode ^
      name.hashCode ^
      originalName.hashCode ^
      popularity.hashCode ^
      profilePath.hashCode ^
      castId.hashCode ^
      creditId.hashCode ^
      character.hashCode ^
      order.hashCode ^
      department.hashCode ^
      job.hashCode ^
      castList.hashCode;
}
