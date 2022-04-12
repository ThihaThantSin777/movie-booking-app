import 'package:dio/dio.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/api_constant/api_constant.dart';
import 'package:movie_booking_app/network/data_agent/movie_booking_data_agent.dart';
import 'package:movie_booking_app/network/movie_api.dart';
import 'package:movie_booking_app/network/movie_booking_api.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_raw_response.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';
import 'package:movie_booking_app/network/response/logout_response/logout_response.dart';
import 'package:movie_booking_app/network/response/user_response/user_response.dart';

import '../../data/vos/check_out_vo/checkout_vo.dart';

class MovieBookingDataAgentImpl extends MovieBookingDataAgent {
  late MovieBookingAPI movieBookingAPI;

  late MovieAPI movieAPI;

  MovieBookingDataAgentImpl.internal() {
    final dio = Dio();
    dio.options = BaseOptions(
      headers: {
        HEADER_ACCEPT: APPLICATION_JSON,
        HEADER_CONTENT_TYPE: APPLICATION_JSON,
      },
    );
    movieBookingAPI = MovieBookingAPI(dio);
    movieAPI = MovieAPI(dio);
  }

  static final MovieBookingDataAgentImpl _singleton =
      MovieBookingDataAgentImpl.internal();

  factory MovieBookingDataAgentImpl() => _singleton;

  @override
  Future<UserResponse?> getUserLoginStatus(String email, String password) =>
      movieBookingAPI.loginWithEmail(email, password);

  @override
  Future<UserResponse?> getUserRegisterStatus(
          String name,
          String email,
          String phone,
          String password,
          String googleAccessToken,
          String faceBookAccessToken) =>
      movieBookingAPI.registerWithEmail(
          name, email, phone, password, googleAccessToken, faceBookAccessToken);

  @override
  Future<LogoutResponse?> logout(String authorization) =>
      movieBookingAPI.logout(authorization);

  @override
  Future<List<MovieVO>?> getNowPlayingMovie(
          String apiKey, String language, int page) =>
      movieAPI
          .getNowPlayingMovie(apiKey, language, page)
          .asStream()
          .map((movies) => movies.results)
          .first;

  @override
  Future<List<GenreVO>?> getGenre(String apiKey, String language) => movieAPI
      .getGenres(apiKey, language)
      .asStream()
      .map((genres) => genres.genres)
      .first;

  @override
  Future<List<MovieVO>?> getComingSoonMovie(
          String apiKey, String language, int page) =>
      movieAPI
          .getComingSoonMovie(apiKey, language, page)
          .asStream()
          .map((movies) => movies.results)
          .first;

  @override
  Future<MovieVO?> getMovieDetails(
          int movieID, String apiKey, String language) =>
      movieAPI.getMovieDetails(movieID, apiKey, language);

  @override
  Future<List<CastCrewVO>?> getMovieCastList(
          int movieID, String apiKey, String language) =>
      movieAPI
          .getCreditsByMovie(movieID, apiKey, language)
          .asStream()
          .map((cast) => cast.cast)
          .first;

  @override
  Future<List<CastCrewVO>?> getMovieCrewList(
          int movieID, String apiKey, String language) =>
      movieAPI
          .getCreditsByMovie(movieID, apiKey, language)
          .asStream()
          .map((crew) => crew.crew)
          .first;

  @override
  Future<List<DayTimeSlotVO>?> getDayTimeSlotsList(
          int movieID, String date, String authorization) =>
      movieBookingAPI
          .getDayTimeSlots(movieID, date, authorization)
          .asStream()
          .map((response) => response.data)
          .first;

  @override
  Future<List<SeatinTypeVO>?> getSeatingPlaneList(
          int cinemaDayTimeSlotsID, String bookingDate, String authorization) =>
      movieBookingAPI
          .getSeatingPlan(cinemaDayTimeSlotsID, bookingDate, authorization)
          .asStream()
          .map((response) => response.data?.expand((value) => value).toList())
          .first;

  @override
  Future<List<SnackAndPaymentVO>?> getSnackList(String authorization) =>
      movieBookingAPI
          .getSnack(authorization)
          .asStream()
          .map((response) => response.data)
          .first;

  @override
  Future<List<SnackAndPaymentVO>?> getPaymentMethodsList(
          String authorization) =>
      movieBookingAPI
          .getPaymentMethods(authorization)
          .asStream()
          .map((response) => response.data)
          .first;

  @override
  Future<UserVO?> getProfile(String authorization) => movieBookingAPI
      .getProfile(authorization)
      .asStream()
      .map((response) => response.data)
      .first;

  @override
  Future<CreateCardResponse?> createCard(String cardNumber, String cardHolder,
      String expirationDate, String cvc, String authorization) {
    return movieBookingAPI
        .createCard(cardNumber, cardHolder, expirationDate, cvc, authorization)
        .asStream()
        .map((response) => response)
        .first;
  }

  @override
  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRawResponse checkOutRawResponse) {
    return movieBookingAPI
        .checkOut(authorization, checkOutRawResponse)
        .asStream()
        .map((response) {
      return response.data;
    }).first;
  }

  @override
  Future<UserResponse?> loginWithGoogle(String accessToken) =>
      movieBookingAPI.loginWithGoogle(accessToken);

  @override
  Future<UserResponse?> loginWithFacebook(String accessToken) =>
      movieBookingAPI.loginWithFacebook(accessToken);
}
