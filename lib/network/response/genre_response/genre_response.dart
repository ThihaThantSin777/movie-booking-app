import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';

part 'genre_response.g.dart';

@JsonSerializable()
class GenreResponse {
  @JsonKey(name: 'genres')
  List<GenreVO>? genres;

  GenreResponse(this.genres);

  factory GenreResponse.fromJson(Map<String, dynamic> json) =>
      _$GenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}
