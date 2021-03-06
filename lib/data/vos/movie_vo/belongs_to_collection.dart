import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';



part 'belongs_to_collection.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_BELONGS_TO_COLLECTION)
class BelongsToCollection {
  @JsonKey(name: 'id')
  @HiveField(0)
  int? id;

  @JsonKey(name: 'name')
  @HiveField(1)
  String? name;

  @JsonKey(name: 'poster_path')
  @HiveField(2)
  String? posterPath;

  @JsonKey(name: 'backdrop_path')
  @HiveField(3)
  String? backDropPath;

  BelongsToCollection(this.id, this.name, this.posterPath, this.backDropPath);

  factory BelongsToCollection.fromJson(Map<String, dynamic> json) =>
      _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);

  @override
  String toString() {
    return 'BelongsToCollection{id: $id, name: $name, posterPath: $posterPath, backDropPath: $backDropPath}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BelongsToCollection &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          posterPath == other.posterPath &&
          backDropPath == other.backDropPath;

  @override
  int get hashCode =>
      id.hashCode ^ name.hashCode ^ posterPath.hashCode ^ backDropPath.hashCode;
}
