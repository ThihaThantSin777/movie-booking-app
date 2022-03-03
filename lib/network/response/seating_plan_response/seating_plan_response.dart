import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
part 'seating_plan_response.g.dart';

@JsonSerializable()
class SeatingPlanResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<List<SeatinTypeVO>>? data;

  SeatingPlanResponse(this.code, this.message, this.data);

  factory SeatingPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatingPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeatingPlanResponseToJson(this);

  @override
  String toString() {
    return 'SeatingPlanResponse{code: $code, message: $message, data: $data}';
  }
}
