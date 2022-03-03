import 'package:dio/dio.dart';
import 'package:movie_booking_app/network/api_constant/api_constant.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_raw_response.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_response.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';
import 'package:movie_booking_app/network/response/day_timeslots_response/day_timeslots_response.dart';
import 'package:movie_booking_app/network/response/logout_response/logout_response.dart';
import 'package:movie_booking_app/network/response/seating_plan_response/seating_plan_response.dart';
import 'package:movie_booking_app/network/response/snack_and_payment_response/snack_and_payment_response.dart';
import 'package:movie_booking_app/network/response/user_response/user_response.dart';
import 'package:retrofit/http.dart';

part 'movie_booking_api.g.dart';

@RestApi(baseUrl: BASE_URL_AUTHORIZATION)
abstract class MovieBookingAPI {
  factory MovieBookingAPI(Dio dio) = _MovieBookingAPI;

  @POST(LOGIN_END_POINT)
  @FormUrlEncoded()
  Future<UserResponse> loginWithEmail(
    @Field(FUE_KEY_EMAIL) String email,
    @Field(FUE_KEY_PASSWORD) String password,
  );

  @POST(REGISTER_END_POINT)
  @FormUrlEncoded()
  Future<UserResponse> registerWithEmail(
    @Field(FUE_KEY_NAME) String name,
    @Field(FUE_KEY_EMAIL) String email,
    @Field(FUE_KEY_PHONE) String phone,
    @Field(FUE_KEY_PASSWORD) String password,
    @Field(FUE_GOOGLE_ACCESS_TOKEN) String googleAccessToken,
    @Field(FUE_FACEBOOK_ACCESS_TOKEN) String faceBookAccessToken,
  );

  @POST(LOGOUT_END_POINT)
  Future<LogoutResponse> logout(
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @GET(DAY_TIMESLOTS_END_POINT)
  Future<DayTimeSlotsResponse> getDayTimeSlots(
      @Query(QUERY_PARMS_MOVIE_ID) int movieID,
      @Query(QUERY_PARMS_DATE) String date,
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @GET(SEATING_PLANE_END_POINT)
  Future<SeatingPlanResponse> getSeatingPlan(
      @Query(QUERY_PARMS_CINEMA_DAY_TIMESLOTS_ID) int cinameDayTimeSlotsID,
      @Query(QUERY_PARMS_BOOKING_DATE) String bookingDate,
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @GET(SNACK_END_PONIT)
  Future<SnackAndPayMentResponse> getSnack(
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @GET(PAYMENT_METHODS_END_POINT)
  Future<SnackAndPayMentResponse> getPaymentMethods(
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @GET(PROFILE_END_POINT)
  Future<UserResponse> getProfile(
      @Header(HEADER_KEY_AUTHORIZATION) String authorization);

  @POST(CREATE_CARD_END_POINT)
  @FormUrlEncoded()
  Future<CreateCardResponse> createCard(
    @Field(FUE_CARD_NUMBER) String cardNumber,
    @Field(FUE_CARD_HOLDER) String cardHolder,
    @Field(FUE_EXPIRATION_DATE) String expirationDate,
    @Field(FUE_CVC) String cvc,
    @Header(HEADER_KEY_AUTHORIZATION) String authorization,
  );

  @POST(CHECK_OUT_END_POINT)
  Future<CheckOutResponse> checkOut(
    @Header(HEADER_KEY_AUTHORIZATION) String authorization,
    @Body() CheckOutRawResponse checkOutResponse,
  );

  @POST(LOGIN_WITH_GOOGLE_END_POINT)
  @FormUrlEncoded()
  Future<UserResponse> loginWithGoogle(
      @Field(FUE_ACCESS_TOKEN) String accessToken);

  @POST(LOGIN_WITH_FACEBOOK_END_POINT)
  @FormUrlEncoded()
  Future<UserResponse> loginWithFacebook(
      @Field(FUE_ACCESS_TOKEN) String accessToken);
}
