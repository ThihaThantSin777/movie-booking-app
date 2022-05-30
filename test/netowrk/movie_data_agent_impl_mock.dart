
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/data_agent/movie_booking_data_agent.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_raw_response.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';
import 'package:movie_booking_app/network/response/logout_response/logout_response.dart';
import 'package:movie_booking_app/network/response/user_response/user_response.dart';

import '../mock_data/mock_data.dart';


class MovieDataAgentImplMock extends MovieBookingDataAgent{
  @override
  Future<CheckoutVO?> checkout(String authorization, CheckOutRawResponse checkOutRawResponse) {
    return Future.value(getMockCheckoutForTest());
  }

  @override
  Future<CreateCardResponse?> createCard(String cardNumber, String cardHolder, String expirationDate, String cvc, String authorization) {
    return Future.value(CreateCardResponse(0,'',createCardMockForTest()));
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovie(String apiKey, String language, int page) {
    return Future.value(moviesMockForTest().where((element) => element.isComingSoon??false).toList());
  }

  @override
  Future<List<DayTimeSlotVO>?> getDayTimeSlotsList(int movieID, String date, String authorization) {
    return Future.value(cinemaDayTimeslotMockForTest());
  }

  @override
  Future<List<GenreVO>?> getGenre(String apiKey, String language) {
    // TODO: implement getGenre
    throw UnimplementedError();
  }

  @override
  Future<List<CastCrewVO>?> getMovieCastList(int movieID, String apiKey, String language) {
    return Future.value(actorsMockForTest());
  }

  @override
  Future<List<CastCrewVO>?> getMovieCrewList(int movieID, String apiKey, String language) {
    // TODO: implement getMovieCrewList
    throw UnimplementedError();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieID, String apiKey, String language) {
    return Future.value(moviesMockForTest().first);
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovie(String apiKey, String language, int page) {
    return Future.value(moviesMockForTest().where((element) => element.isNowShowing??false).toList());
  }

  @override
  Future<List<SnackAndPaymentVO>?> getPaymentMethodsList(String authorization) {
    return Future.value(paymentMockForTest());
  }

  @override
  Future<UserVO?> getProfile(String authorization) {
    return Future.value(profileMockForTest());
  }

  @override
  Future<List<SeatinTypeVO>?> getSeatingPlaneList(int cinemaDayTimeSlotsID, String bookingDate, String authorization) {
    return Future.value(seatingPlanMockForTest());
  }

  @override
  Future<List<SnackAndPaymentVO>?> getSnackList(String authorization) {
    return Future.value(snacksMockForTest());
  }

  @override
  Future<UserResponse?> getUserLoginStatus(String email, String password) {
    // TODO: implement getUserLoginStatus
    throw UnimplementedError();
  }

  @override
  Future<UserResponse?> getUserRegisterStatus(String name, String email, String phone, String password, String googleAccessToken, String faceBookAccessToken) {
    return Future.value(UserResponse(0,'',registerAndLoginMockForTest().first,''));
  }

  @override
  Future<UserResponse?> loginWithFacebook(String accessToken) {
    return Future.value(UserResponse(0,'',registerAndLoginMockForTest().first,''));
  }

  @override
  Future<UserResponse?> loginWithGoogle(String accessToken) {
    return Future.value(UserResponse(0,'',registerAndLoginMockForTest().first,''));
  }

  @override
  Future<LogoutResponse?> logout(String authorization) {
    // TODO: implement logout
    throw UnimplementedError();
  }






}