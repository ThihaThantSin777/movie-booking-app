import 'package:flutter/material.dart';
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
import 'package:movie_booking_app/page/add_new_card.dart';
import 'package:movie_booking_app/page/checkout_screen.dart';
import 'package:movie_booking_app/page/details_screen.dart';
import 'package:movie_booking_app/page/home_screen.dart';
import 'package:movie_booking_app/page/login_sigin_screen.dart';
import 'package:movie_booking_app/page/payment_screen.dart';
import 'package:movie_booking_app/page/pick_time_and_cinema_screen.dart';
import 'package:movie_booking_app/page/seat_chart_screen.dart';
import 'package:movie_booking_app/page/snack_and_payment_screen.dart';
import 'package:movie_booking_app/page/start_screen.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import 'test_data/test_data.dart';

void main() async {
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

  testWidgets("Movie Booking App Testing", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    await tester.pumpAndSettle(const Duration(seconds: 5));

    ///StartScreen
    expect(find.byType(StartScreen), findsOneWidget);
    await tester.tap(find.text(getStarted));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    ///LoginScreen
    expect(find.byType(LoginSiginScreen), findsOneWidget);
    await tester.enterText(find.byKey(const Key(userNameKey)), userEmail);
    await tester.enterText(find.byKey(const Key(passwordKey)), password);
    await tester.tap(find.text(confirmText));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(const Key(loginAlertButtonTextKey)), findsOneWidget);
    await tester.tap(find.byKey(const Key(loginAlertButtonTextKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///HomeScreen
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text(testDataNowPlayingMovieName), findsOneWidget);
    expect(find.text(testDataComingSoonMovieName), findsOneWidget);
    await tester.tap(find.byKey(const Key(openDrawerKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(userName), findsOneWidget);
    expect(find.text(userEmail), findsOneWidget);
    await tester.tap(find.byType(DrawerMenuListView));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text(testDataNowPlayingMovieName));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///DetailsScreen
    expect(find.byType(MovieDetailsScreen), findsOneWidget);
    expect(find.text(testDataRunTime), findsOneWidget);
    expect(find.text(testDataRating), findsOneWidget);
    expect(find.text(testDataGenreAction), findsOneWidget);
    expect(find.text(testDataGenreAdventure), findsOneWidget);
    await tester.tap(find.text(getYourTicket));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///PickTime And Cinema Screen
    expect(find.byType(PickTimeAndCinema), findsOneWidget);
    await tester.tap(find.text(next));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(const Key(dayTimeSlotsAlertButtonTextKey)), findsOneWidget);
    await tester.tap(find.text(testDataOK));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataTimeSlots)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text(next));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///SeatChart Screen
    expect(find.byType(SeatingTicketScreen), findsOneWidget);
    await tester.drag(find.byKey(const Key(scrollKey)), const Offset(0, -100));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text(buyTicketForZeroDollarText));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text(testDataOK));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(seat1Key)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(seat2Key)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(seat3Key)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(ticketCount), findsWidgets);
    expect(find.text(ticketCommaString), findsWidgets);
    await tester.tap(find.text(buyTicketFor6DollarText));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///SnackAndPayment Screen
    expect(find.byType(SnackAndPayMentScreen), findsOneWidget);
    await tester.tap(find.byKey(const Key(testDataPopCornPressOneTimeKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataPopCornPressTwoTimeKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataSmoothiesPressOneTimeKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataSmoothiesPressTwoTimeKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataSmoothiesPressOneTimeMinusKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.text(testDataSubTotal), findsOneWidget);
    await tester.drag(find.byKey(const Key(testDataScrollKey)), const Offset(0, -80));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.byKey(const Key(testDataPaymentKey)));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.tap(find.text(pay6Dollar));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///PaymentScreen
    expect(find.byType(PaymentScreen), findsOneWidget);
    await tester.tap(find.text(testDataAddNewCard));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///AddNewCard Screen
    expect(find.byType(AddNewCardScreen), findsOneWidget);
    await tester.tap(find.text(confirmText));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key(cardNumberKey)), cardNumberNot16);
    await tester.enterText(find.byKey(const Key(cardHolderKey)), cardHolder);
    await tester.enterText(find.byKey(const Key(expirationDateKey)), expirationDate);
    await tester.enterText(find.byKey(const Key(cvcKey)), cvc);
    await tester.tap(find.text(confirmText));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    await tester.enterText(find.byKey(const Key(cardNumberKey)), cardNumber);
    await tester.tap(find.text(confirmText));
    await tester.pumpAndSettle(const Duration(seconds: 3));
    expect(find.byKey(const Key(alertAddNewCardStatusText)), findsOneWidget);
    await tester.tap(find.text(testDataOK));
    await tester.pumpAndSettle(const Duration(seconds: 3));

    ///BackToPaymentScreen
    expect(find.byType(PaymentScreen), findsOneWidget);
    await tester.tap(find.text(purchaseText));
    await tester.pumpAndSettle(const Duration(seconds: 3));


    ///Checkout Screen
    expect(find.byType(CheckoutScreen), findsOneWidget);
    expect(find.text(showTimeDate), findsWidgets);
    expect(find.text(therater), findsWidgets);
    expect(find.text(screen), findsWidgets);
    expect(find.text(row), findsWidgets);
    expect(find.text(price), findsWidgets);
  });
}
