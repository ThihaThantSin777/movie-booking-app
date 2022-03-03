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
import 'package:movie_booking_app/network/response/user_response/user_response.dart';

abstract class MovieBookingDataAgent {
  Future<UserResponse?> getUserRegisterStatus(
      String name,
      String email,
      String phone,
      String password,
      String googleAccessToken,
      String faceBookAccessToken);

  Future<UserResponse?> getUserLoginStatus(String email, String password);

  Future<LogoutResponse?> logout(String authorization);

  Future<List<MovieVO>?> getNowPlayingMovie(
      String apiKey, String language, int page);

  Future<List<GenreVO>?> getGenre(String apiKey, String language);

  Future<List<MovieVO>?> getComingSoonMovie(
      String apiKey, String language, int page);

  Future<MovieVO?> getMovieDetails(int movieID, String apiKey, String language);

  Future<List<CastCrewVO>?> getMovieCastList(
      int movieID, String apiKey, String language);

  Future<List<CastCrewVO>?> getMovieCrewList(
      int movieID, String apiKey, String language);

  Future<List<DayTimeSlotVO>?> getDayTimeSlotsList(
      int movieID, String date, String authorization);

  Future<List<SeatinTypeVO>?> getSeatingPlaneList(
      int cinemaDayTimeSlotsID, String bookingDate, String authorization);

  Future<List<SnackAndPaymentVO>?> getSnackList(String authorization);

  Future<List<SnackAndPaymentVO>?> getPaymentMethodsList(String authorization);

  Future<UserVO?> getProfile(String authorization);

  Future<CreateCardResponse?> createCard(String cardNumber, String cardHolder,
      String expirationDate, String cvc, String authorization);

  Future<CheckoutVO?> checkout(
      String authorization, CheckOutRawResponse checkOutRawResponse);

  Future<UserResponse?> loginWithGoogle(String accessToken);

  Future<UserResponse?> loginWithFacebook(String accessToken);
}
