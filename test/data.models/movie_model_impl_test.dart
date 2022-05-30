

import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/card_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';

import '../mock_data/mock_data.dart';
import '../netowrk/movie_data_agent_impl_mock.dart';
import '../persistance/actor_dao_impl_mock.dart';
import '../persistance/cards_from_profile_dao_impl_mock.dart';
import '../persistance/cinema_day_timeslot_dao_mock.dart';
import '../persistance/movie_dao_impl_mock.dart';
import '../persistance/payment_method_dao_impl_mock.dart';
import '../persistance/snack_dao_impl_mock.dart';
import '../persistance/user_dao_impl_mock.dart';

void main() {
  group("Movie Model Impl Test", () {
    var movieModel = MovieBookingModelImpl();

    setUp(() {
      movieModel.setDaoAndDataAgent(
        ActorDaoImplMock(),
        UserDaoImplMock(),
        CinemaDayTimeslotDaoMock(),
        MovieDaoImplMock(),
        PaymentMethodDaoImplMock(),
        SnackDaoImplMock(),
        MovieDataAgentImplMock(),
      );
    });

    test("Credits By Movie", () {
      expect(
        movieModel.getActorListFromDataBase(1, 'apiKey', 'language'),
        emits(
          CastCrewVO(false, null, 1, null, 'Actor 1', 'AA', null, null, 12, '43',
              null, null, null, null),
        ),
      );
    });

    test("Cards From Profile", () {
      expect(
        movieModel.getProfileFromDataBase(),
        emits(
            UserVO(
              568,
              "toetoe",
              "toetoe22@gmail.com",
              "959770222230",
              0,
              "/img/avatar2.png",
              [
                CardVO(
                  12,
                  "MgMg",
                  "4455664455",
                  "01/12",
                  "JCB",
                ),
                CardVO(
                  13,
                  "MaMA",
                  "3355664455",
                  "01/11",
                  "JCB",
                ),
              ],
              "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
            )
        ),
      );
    });

    test("Cinema Day Timeslot ", () {
      expect(
        movieModel.getDayTimeSlotsListFromDataBase(1, '', '2022-04-12'),
        emits(

              DayTimeSlotVO(1,'Cinema I' ,

                  [
                    TimeSlotsVO(3, "9:30 AM", isSelect: false),
                    TimeSlotsVO(4, "10:30 AM", isSelect: false),
                  ]
              ),


        ),
      );
    });

    test("Now Playing Movies", () {
      expect(
          movieModel.getNowPlayingMovieModleFromDataBase('apiKey', 'language', 1),
          emits([
            MovieVO(
                false,
                'None',
                null,
                null,
                null,
                null,
                [1, 2, 3],
                123,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                120,
                null,
                null,
                null,
                'Bat man',
                null,
                null,
                null,
                isNowShowing: true,
                isComingSoon: false),
          ]));
    });

    test("Coming Soon Movies", () {
      expect(
        movieModel.getComingSoonMovieModleFromDataBase('apiKey', 'language', 1),
        emits([
          MovieVO(
              false,
              'None None',
              null,
              null,
              null,
              null,
              [4, 5, 6],
              456,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              110,
              null,
              null,
              null,
              'Super man',
              null,
              null,
              null,
              isNowShowing: false,
              isComingSoon: true),
        ]),
      );
    });

    test("Movie Details Test", () {
      expect(
        movieModel.getMovieDetailsFromDataBase(123, 'apiKey', 'language'),
        emits(
          MovieVO(
              false,
              'None',
              null,
              null,
              null,
              null,
              [1, 2, 3],
              123,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              120,
              null,
              null,
              null,
              'Bat man',
              null,
              null,
              null,
              isNowShowing: true,
              isComingSoon: false),
        ),
      );
    });


  test('Seat Method', (){
    expect(movieModel.getSeatingTypeList(1, 'date', 'authorization'),

      completion(equals(
       [
         SeatinTypeVO(1, 'text', '', 'A', 0),
         SeatinTypeVO(2, 'space', '', 'A', 0),
         SeatinTypeVO(3, 'taken', 'A-2', 'A', 2),
         SeatinTypeVO(1, 'text', '', 'B', 0),
         SeatinTypeVO(2, 'available', 'B-1', 'B', 2),
         SeatinTypeVO(3, 'available', 'B-2', 'B', 2),
       ]

      ))
    );
  });

    test("Payment Method", () {
      expect(
          movieModel.getPaymentListFromDataBase(''),
          emits(
            [
              SnackAndPaymentVO(1, 'Credit Card', 'Visa, Master Card, JCB', 0, ''),
              SnackAndPaymentVO(2, 'Internet Banking (ATM card)', 'Visa, Master Card, JCB', 0, ''),
              SnackAndPaymentVO(3, 'E-Wallet', 'AyaPay, KbzPay, WavePay', 0, ''),
            ],
          ));
    });

    test("Snack Test", () {
      expect(
        movieModel.getSnackListFromDataBase(''),
        emits(
          [
            SnackAndPaymentVO(1, "Popcorn", "Et dolores eaque officia aut.", 2,
                "https://tmba.padc.com.mm/img/snack.jpg"),
            SnackAndPaymentVO(
                2,
                "Smoothies",
                "Voluptatum consequatur aut molestiae soluta nulla.",
                3,
                "https://tmba.padc.com.mm/img/snack.jpg"),
            SnackAndPaymentVO(3, "Carrots", "At vero et doloribus sint porro ipsum consequatur.",
                4, "https://tmba.padc.com.mm/img/snack.jpg"),
          ],
        ),
      );
    });

   
  });
}
