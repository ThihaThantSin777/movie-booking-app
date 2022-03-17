import 'package:json_annotation/json_annotation.dart';

part 'movie_vo_date.g.dart';

@JsonSerializable()
class MovieVODate {
  @JsonKey(name: 'maximum')
  String? maximum;

  @JsonKey(name: 'minimum')
  String? minimum;

  MovieVODate(this.maximum, this.minimum);

  factory MovieVODate.fromJson(Map<String, dynamic> json) =>
      _$MovieVODateFromJson(json);

  Map<String, dynamic> toJson() => _$MovieVODateToJson(this);

  @override
  String toString() {
    return 'MovieVODate{maximum: $maximum, minimum: $minimum}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVODate &&
          runtimeType == other.runtimeType &&
          maximum == other.maximum &&
          minimum == other.minimum;

  @override
  int get hashCode => maximum.hashCode ^ minimum.hashCode;
}
