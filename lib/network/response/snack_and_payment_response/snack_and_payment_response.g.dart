// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_and_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackAndPayMentResponse _$SnackAndPayMentResponseFromJson(
        Map<String, dynamic> json) =>
    SnackAndPayMentResponse(
      json['code'] as int?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SnackAndPaymentVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SnackAndPayMentResponseToJson(
        SnackAndPayMentResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
