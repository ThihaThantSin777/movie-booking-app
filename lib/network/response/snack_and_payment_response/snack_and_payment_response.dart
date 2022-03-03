import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

part 'snack_and_payment_response.g.dart';

@JsonSerializable()
class SnackAndPayMentResponse {
  @JsonKey(name: 'code')
  int? code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  List<SnackAndPaymentVO>? data;

  SnackAndPayMentResponse(this.code, this.message, this.data);

  factory SnackAndPayMentResponse.fromJson(Map<String, dynamic> json) =>
      _$SnackAndPayMentResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SnackAndPayMentResponseToJson(this);
}
