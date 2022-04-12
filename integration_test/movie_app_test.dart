

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
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
import 'package:movie_booking_app/main.dart';
import 'package:movie_booking_app/page/start_screen.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';


void main()async{

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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


 testWidgets("Movie Booking App Testing",
  (WidgetTester tester)async{

    await tester.pumpWidget(MyApp());
    await Future.delayed(const Duration(seconds: 2));

    await tester.pumpAndSettle(const Duration(seconds: 5));

    expect(find.byType(StartScreen), findsOneWidget);



  }
 );

}