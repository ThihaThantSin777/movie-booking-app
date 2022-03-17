import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

part 'spoken_languages.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_SPOKEN_LANGUAGES)
class SpokenLanguages {
  @JsonKey(name: 'english_name')
  @HiveField(0)
  String? englishName;

  @JsonKey(name: 'iso_639_1')
  @HiveField(2)
  String? iso6391;

  @JsonKey(name: 'name')
  @HiveField(3)
  String? name;

  SpokenLanguages(this.englishName, this.iso6391, this.name);

  factory SpokenLanguages.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);

  @override
  String toString() {
    return 'SpokenLanguages{englishName: $englishName, iso6391: $iso6391, name: $name}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpokenLanguages &&
          runtimeType == other.runtimeType &&
          englishName == other.englishName &&
          iso6391 == other.iso6391 &&
          name == other.name;

  @override
  int get hashCode => englishName.hashCode ^ iso6391.hashCode ^ name.hashCode;
}
