import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
part 'cast_crew_response.g.dart';

@JsonSerializable()
class CastCrewResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'cast')
  List<CastCrewVO>? cast;

  @JsonKey(name: 'crew')
  List<CastCrewVO>? crew;

  CastCrewResponse(this.id, this.cast, this.crew);

  factory CastCrewResponse.fromJson(Map<String, dynamic> json) =>
      _$CastCrewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CastCrewResponseToJson(this);
}
