

import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_raw_response.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';
import 'package:movie_booking_app/network/response/logout_response/logout_response.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieBookingModel{
  @override
  Future<CheckoutVO?> checkout(String authorization, CheckOutRawResponse checkOutRawResponse) {
    return Future.value(getMockCheckoutForTest());
  }

  @override
  Future<CreateCardResponse?> createCard(String cardNumber, String cardHolder, String expirationDate, String cvc, String authorization) {
    return Future.value(CreateCardResponse(0,'',createCardMockForTest()));
  }

  @override
  void deleteUserInfo() {

  }

  @override
  Stream<CastCrewVO?> getActorListFromDataBase(int movieID, String apiKey, String language) {
    return Stream.value(actorsMockForTest().first);
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovieModle(String apiKey, String language, int page) {
    return Future.value(null);
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMovieModleFromDataBase(String apiKey, String language, int page) {
    return Stream.value(
      moviesMockForTest()
          .where((element) => element.isComingSoon ?? false)
          .toList(),
    );
  }

  @override
  Future<List<DayTimeSlotVO>?> getDayTimeSlotsList(int movieID, String date, String authorization) {
    return Future.value(null);
  }

  @override
  Stream<DayTimeSlotVO?> getDayTimeSlotsListFromDataBase(int movieID, String authorization, String date) {
    return Stream.value(cinemaDayTimeslotMockForTest().first);
  }

  @override
  Future<List<GenreVO>?> getGenresModle(String apiKey, String language) {
    return Future.value(null);
  }

  @override
  Future<List<CastCrewVO>?> getMovieCastList(int movieID, String apiKey, String language) {
    return Future.value(null);
  }

  @override
  Future<List<CastCrewVO>?> getMovieCrewList(int movieID, String apiKey, String language) {
    return Future.value(null);
  }

  @override
  Future<MovieVO?> getMovieDeatilsModle(int movieID, String apiKey, String language) {
    return Future.value(null);
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDataBase(int movieID, String apiKey, String language) {
    return Stream.value(
      moviesMockForTest().first,
    );
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovieModle(String apiKey, String language, int page) {
    return Future.value(null);
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMovieModleFromDataBase(String apiKey, String language, int page) {
    return Stream.value(
      moviesMockForTest()
          .where((element) => element.isNowShowing ?? false)
          .toList(),
    );
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getPaymentListFromDataBase(String authorization) {
    return Stream.value(
      paymentMockForTest(),
    );
  }

  @override
  Future<List<SnackAndPaymentVO>?> getPaymentMethodsList(String authorization) {
    return Future.value(null);
  }

  @override
  Future<UserVO?> getProfile(String authorization) {
    return Future.value(profileMockForTest());
  }

  @override
  Stream<UserVO?> getProfileFromDataBase() {
    return Stream.value(profileMockForTest());
  }

  @override
  Future<List<SeatinTypeVO>?> getSeatingTypeList(int cinemaDayTimeSlotsID, String date, String authorization) {
    return Future.value(seatingForIntegrationForTest());
  }

  @override
  Future<List<SnackAndPaymentVO>?> getSnackList(String authorization) {
    return Future.value(snacksMockForTest());
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getSnackListFromDataBase(String authorization) {
    return Stream.value(snacksMockForTest());
  }

  @override
  String? getToken() {
   return '';
  }

  @override
  Stream<UserVO?> getUserInfo() {
    return Stream.value(profileMockForTest());
  }

  @override
  Future<UserVO?> getUserLoginStatus(String email, String password) {
   return Future.value(null);
  }

  @override
  Future<UserVO?> getUserRegisterStatus(String name, String email, String phone, String password, String googleAccessToken, String faceBookAccessToken) {
    return Future.value(null);
  }

  @override
  Future<UserVO?> loginWithFacebook(String accessToken) {
    return Future.value(null);
  }

  @override
  Future<UserVO?> loginWithGoogle(String accessToken) {
    return Future.value(null);
  }

  @override
  Future<LogoutResponse?> logout(String authorization) {
    return Future.value(null);
  }

  @override
  void saveUserInfo(UserVO userVO) {

  }

  



}