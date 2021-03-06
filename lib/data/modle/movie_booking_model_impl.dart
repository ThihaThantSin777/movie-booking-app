import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/network/data_agent/movie_booking_data_agent.dart';
import 'package:movie_booking_app/network/data_agent/movie_booking_data_agent_impl.dart';
import 'package:movie_booking_app/network/response/check_out_response/check_out_raw_response.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';
import 'package:movie_booking_app/network/response/logout_response/logout_response.dart';
import 'package:movie_booking_app/persistance/daos/actor_dao_impl.dart';
import 'package:movie_booking_app/persistance/daos/day_timeslots_dao_impl.dart';
import 'package:movie_booking_app/persistance/daos/movie_dao_impl.dart';
import 'package:movie_booking_app/persistance/daos/payment_dao_impl.dart';
import 'package:movie_booking_app/persistance/daos/snack_dao_impl.dart';
import 'package:movie_booking_app/persistance/daos/user_dao_impl.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistance/abstraction_layer/actor_dao.dart';
import '../../persistance/abstraction_layer/day_timeslots_dao.dart';
import '../../persistance/abstraction_layer/movie_dao.dart';
import '../../persistance/abstraction_layer/payment_dao.dart';
import '../../persistance/abstraction_layer/snack_dao.dart';
import '../../persistance/abstraction_layer/user_dao.dart';

class MovieBookingModelImpl extends MovieBookingModel {
  MovieBookingDataAgent movieBookingDataAgent = MovieBookingDataAgentImpl();

  MovieBookingModelImpl.internal();

  static final MovieBookingModelImpl _singleton =
      MovieBookingModelImpl.internal();

  factory MovieBookingModelImpl() => _singleton;

  UserDAO userDAO = UserDAOImpl();
  MovieDAO movieDAO = MovieDAOImpl();
  ActorDAO actorDAO = ActorDAOImpl();
  SnackDAO snackDAO = SnackDAOImpl();
  PaymentDAO paymentDAO = PaymentDAOImpl();
  DayTimeSlotsDAO dayTimeTimeSlotsDao = DayTimeTimeSlotsDaoImpl();
  int index = 0;

  void setDaoAndDataAgent(
      ActorDAO actorDao,
      UserDAO userDao,
      DayTimeSlotsDAO cinemaDao,
      MovieDAO movieDao,
      PaymentDAO paymentDao,
      SnackDAO snackDao,
      MovieBookingDataAgent dAgent,
      ){
    actorDAO = actorDao;
    userDAO = userDao;
    dayTimeTimeSlotsDao = cinemaDao;
    movieDAO = movieDao;
    paymentDAO = paymentDao;
    snackDAO = snackDao;
    movieBookingDataAgent = dAgent;
  }


  @override
  Future<UserVO?> getUserLoginStatus(String email, String password) =>
      movieBookingDataAgent.getUserLoginStatus(email, password).then((user) {
        if (user!.data == null) {
          UserVO userVO = UserVO.normal();
          userVO.message = user.message;
          return Future.value(userVO);
        } else {
          UserVO? userVO = user.data;
          userVO?.token = user.token;
          userVO?.message = user.message;
          userDAO.saveUser(userVO ?? UserVO.normal());
          return Future.value(userVO);
        }
      });

  @override
  Future<UserVO?> getUserRegisterStatus(
          String name,
          String email,
          String phone,
          String password,
          String googleAccessToken,
          String faceBookAccessToken) =>
      movieBookingDataAgent
          .getUserRegisterStatus(name, email, phone, password,
              googleAccessToken, faceBookAccessToken)
          .then((user) {
        if (user!.data == null) {
          UserVO userVO = UserVO.normal();
          userVO.message = user.message;
          return Future.value(userVO);
        } else {
          UserVO? userVO = user.data;
          userVO?.token = user.token;
          userVO?.message = user.message;
          userDAO.saveUser(userVO ?? UserVO.normal());
          return Future.value(userVO);
        }
      });

  @override
  Stream<UserVO?> getUserInfo() {
    return userDAO.getUserInfoStream();
  }

  @override
  void saveUserInfo(UserVO userVO) => userDAO.saveUser(userVO);

  @override
  void deleteUserInfo() => userDAO.deleteUser();

  @override
  Future<LogoutResponse?> logout(String authorization) =>
      movieBookingDataAgent.logout(authorization);

  @override
  Future<List<MovieVO>?> getNowPlayingMovieModle(
      String apiKey, String language, int page) {
    index = 0;
    return movieBookingDataAgent
        .getNowPlayingMovie(apiKey, language, page)
        .then((movieList) {
      List<MovieVO> modifyMovieList = movieList?.map((movies) {
            movies.isNowShowing = true;
            index++;
            movies.order = index;
            return movies;
          }).toList() ??
          [];
      movieDAO.saveMovieList(modifyMovieList);
      return Future.value(movieList);
    });
  }

  @override
  Future<List<GenreVO>?> getGenresModle(String apiKey, String language) =>
      movieBookingDataAgent.getGenre(apiKey, language);

  @override
  Future<List<MovieVO>?> getComingSoonMovieModle(
      String apiKey, String language, int page) {
    index = 0;
    return movieBookingDataAgent
        .getComingSoonMovie(apiKey, language, page)
        .then((movieList) {
      List<MovieVO> modifyMovieList = (movieList)?.map((movies) {
            movies.isComingSoon = true;
            index++;
            movies.order = index;
            return movies;
          }).toList() ??
          [];
      movieDAO.saveMovieList(modifyMovieList);
      return Future.value(movieList);
    });
  }

  @override
  Future<MovieVO?> getMovieDeatilsModle(
          int movieID, String apiKey, String language) =>
      movieBookingDataAgent
          .getMovieDetails(movieID, apiKey, language)
          .then((movies) {
        movieDAO.saveSingleMovieList(movies ?? MovieVO.normal());
        return Future.value(movies);
      });

  @override
  Future<List<CastCrewVO>?> getMovieCastList(
          int movieID, String apiKey, String language) =>
      movieBookingDataAgent
          .getMovieCastList(movieID, apiKey, language)
          .then((actors) {
        CastCrewVO cast = CastCrewVO.normal();
        cast.castList = actors;
        actorDAO.saveActors(movieID, cast);
        return Future.value(actors);
      });

  @override
  Future<List<CastCrewVO>?> getMovieCrewList(
      int movieID, String apiKey, String language) {
    return movieBookingDataAgent
        .getMovieCrewList(movieID, apiKey, language)
        .then((actors) {
      return Future.value(actors);
    });
  }

  @override
  Future<List<DayTimeSlotVO>?> getDayTimeSlotsList(
          int movieID, String date, String authorization) =>
      movieBookingDataAgent
          .getDayTimeSlotsList(movieID, date, authorization)
          .then((dayTimeSlotsList) {
        DayTimeSlotVO dayTimeSlotVO = DayTimeSlotVO.normal();
        dayTimeSlotVO.daytimeSlotVOList = dayTimeSlotsList;
        dayTimeTimeSlotsDao.saveDayTimeSlotsList(dayTimeSlotVO, date);
        return Future.value(dayTimeSlotsList);
      });

  @override
  Future<List<SeatinTypeVO>?> getSeatingTypeList(
          int cinemaDayTimeSlotsID, String date, String authorization) =>
      movieBookingDataAgent.getSeatingPlaneList(
          cinemaDayTimeSlotsID, date, authorization);

  @override
  Future<List<SnackAndPaymentVO>?> getSnackList(String authorization) =>
      movieBookingDataAgent.getSnackList(authorization).then((snackList) {
        snackDAO.saveSnack(snackList ?? []);
        return Future.value(snackList);
      });

  @override
  Future<List<SnackAndPaymentVO>?> getPaymentMethodsList(
          String authorization) =>
      movieBookingDataAgent
          .getPaymentMethodsList(authorization)
          .then((paymentList) {
        paymentDAO.savePayment(paymentList ?? []);
        return Future.value(paymentList);
      });

  @override
  Future<UserVO?> getProfile(String authorization) =>
      movieBookingDataAgent.getProfile(authorization).then((userVO) {
        UserVO user = userVO ?? UserVO.normal()
          ..token = userDAO.getUserInfo()?.token;
        userDAO.saveUser(user);
        return Future.value(userVO);
      });

  @override
  Future<CreateCardResponse?> createCard(String cardNumber, String cardHolder,
          String expirationDate, String cvc, String authorization) =>
      movieBookingDataAgent.createCard(
          cardNumber, cardHolder, expirationDate, cvc, authorization);

  @override
  Future<CheckoutVO?> checkout(
          String authorization, CheckOutRawResponse checkOutRawResponse) =>
      movieBookingDataAgent.checkout(authorization, checkOutRawResponse);

  @override
  String? getToken() => userDAO.getAuthorizationToken();

  @override
  Stream<List<MovieVO>?> getNowPlayingMovieModleFromDataBase(
      String apiKey, String language, int page) {
    getNowPlayingMovieModle(apiKey, language, page);

    return movieDAO
        .getMovieStream()
        .startWith(movieDAO.getNowPlayingMoviesStream())
        .map((event) => movieDAO
            .getAllMovieList()
            .where((element) => element.isNowShowing ?? false)
            .toList());
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMovieModleFromDataBase(
      String apiKey, String language, int page) {
    getComingSoonMovieModle(apiKey, language, page);
    return movieDAO
        .getMovieStream()
        .startWith(movieDAO.getComingSoonMoviesStream())
        .map((event) => (movieDAO.getAllMovieList())
            .where((element) => element.isComingSoon ?? false)
            .toList());
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDataBase(
      int movieID, String apiKey, String language) {
    getMovieDeatilsModle(movieID, apiKey, language);
    return movieDAO
        .getMovieStream()
        .startWith(movieDAO.getMovieStreamByID(movieID))
        .map((event) => movieDAO.getMoviesByID(movieID));
  }

  @override
  Stream<CastCrewVO?> getActorListFromDataBase(
      int movieID, String apiKey, String language) {
    getMovieCastList(movieID, apiKey, language);
    return actorDAO
        .getActorStream()
        .startWith(actorDAO.getAllActorStream(movieID))
        .map((event) => actorDAO.getActorListByID(movieID));
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getSnackListFromDataBase(
      String authorization) {
    getSnackList(authorization);
    return snackDAO
        .getSnackStream()
        .startWith(snackDAO.getSnackListStream())
        .map((event) => snackDAO.getSnackList());
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getPaymentListFromDataBase(
      String authorization) {
    getPaymentMethodsList(authorization);
    return paymentDAO
        .getPaymentStream()
        .startWith(paymentDAO.getPaymentListStream())
        .map((event) => paymentDAO.getPaymentList());
  }

  @override
  Stream<DayTimeSlotVO?> getDayTimeSlotsListFromDataBase(
      int movieID, String authorization, String date) {
    getDayTimeSlotsList(movieID, date, authorization);
    return dayTimeTimeSlotsDao
        .getDayTimeSlotsStream()
        .startWith(dayTimeTimeSlotsDao.getDayTimeSlotsByDateStream(date))
        .map((event) => dayTimeTimeSlotsDao.getDayTimeSlotsByDate(date));
  }

  @override
  Future<UserVO?> loginWithGoogle(String accessToken) =>
      movieBookingDataAgent.loginWithGoogle(accessToken).then((user) {
        if (user!.data == null) {
          UserVO userVO = UserVO.normal();
          userVO.message = user.message;
          return Future.value(userVO);
        } else {
          UserVO? userVO = user.data;
          userVO?.token = user.token;
          userVO?.message = user.message;
          userDAO.saveUser(userVO ?? UserVO.normal());
          return Future.value(userVO);
        }
      });

  @override
  Future<UserVO?> loginWithFacebook(String accessToken) =>
      movieBookingDataAgent.loginWithFacebook(accessToken).then((user) {
        if (user!.data == null) {
          UserVO userVO = UserVO.normal();
          userVO.message = user.message;
          return Future.value(userVO);
        } else {
          UserVO? userVO = user.data;
          userVO?.token = user.token;
          userVO?.message = user.message;
          userDAO.saveUser(userVO ?? UserVO.normal());
          return Future.value(userVO);
        }
      });

  @override
  Stream<UserVO?> getProfileFromDataBase() {
    return userDAO
        .getUserStream()
        .startWith(userDAO.getUserInfoStream())
        .map((event) => userDAO.getUserInfo());
  }
}
