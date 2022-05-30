import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movie_booking_app/config/config_values.dart';
import 'package:movie_booking_app/config/environment_config.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/genre_vo/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/belongs_to_collection.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/production_companies.dart';
import 'package:movie_booking_app/data/vos/movie_vo/production_countries.dart';
import 'package:movie_booking_app/data/vos/movie_vo/spoken_languages.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/card_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/page/home_screen.dart';
import 'package:movie_booking_app/page/start_screen.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/user_dao.dart';
import 'package:movie_booking_app/persistance/daos/user_dao_impl.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';
import 'package:movie_booking_app/resources/colors.dart';

import 'data/vos/cast_crew_vo/cast_crew_vo.dart';

main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(GenreVOAdapter());
  Hive.registerAdapter(BelongsToCollectionAdapter());
  Hive.registerAdapter(ProductionCompaniesAdapter());
  Hive.registerAdapter(ProductionCountriesAdapter());
  Hive.registerAdapter(SpokenLanguagesAdapter());
  Hive.registerAdapter(CastCrewVOAdapter());
  Hive.registerAdapter(SnackAndPaymentVOAdapter());
  Hive.registerAdapter(DayTimeSlotVOAdapter());
  Hive.registerAdapter(TimeSlotsVOAdapter());

  await Hive.openBox<UserVO>(BOX_NAME_USER_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<CastCrewVO>(BOX_NAME_ACTOR_VO);
  await Hive.openBox<SnackAndPaymentVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<SnackAndPaymentVO>(BOX_NAME_PAYMENT_VO);
  await Hive.openBox<DayTimeSlotVO>(BOX_NAME_DAY_TIMESLOTS_VO);
  await Hive.openBox<CardVO>(BOX_NAME_CARD_VO);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  UserDAO userDAO = UserDAOImpl();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Movie Bokking App',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: THEME_COLORS[EnvironmentConfig.CONFIG_THEME_COLOR],
            body:
                userDAO.isUserVOEmpty() ? StartScreen() :  HomeScreen()));
  }
}
