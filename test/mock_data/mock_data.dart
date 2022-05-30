import 'package:movie_booking_app/data/vos/cast_crew_vo/cast_crew_vo.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_snack_vo.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/card_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';

CheckoutVO getMockCheckoutForTest(){
  return CheckoutVO(629, 'Cinema III-6672-6182', '2022-04-12', 'A', 'A-7,A-8', 2, '\$18', 335787, 3, 'A', TimeSlotsVO(1,'9:30 AM'), [
    CheckoutSnackVO(1,'Pop corn','Good','AAA',123,123,2,123),
  ],'');
}

List<CardVO> createCardMockForTest(){
  return [
    CardVO(
      764,
      "toeAung",
      "4345565454",
      "03/11",
      "JCB",
      ),
  ];
}

List<DayTimeSlotVO> cinemaDayTimeslotMockForTest(){
  return [
    DayTimeSlotVO(1,'Cinema I' ,

      [
        TimeSlotsVO(3, "9:30 AM", isSelect: false),
        TimeSlotsVO(4, "10:30 AM", isSelect: false),
      ]
    ),
    DayTimeSlotVO(2,'Cinema II' ,

        [
          TimeSlotsVO(5, "12:30 PM", isSelect: false),
          TimeSlotsVO(6, "1:30 PM", isSelect: false),
        ]
    ),
    DayTimeSlotVO(3,'Cinema III' ,

        [
          TimeSlotsVO(7, "3:30 PM", isSelect: false),
          TimeSlotsVO(8, "6:30 PM", isSelect: false),
        ]
    ),
  ];
}

// CinemaListForHiveVO cinemaToDatabaseMock(){
//   return CinemaListForHiveVO(cinemaDayTimeslotMockForTest());
// }

List<SeatinTypeVO> seatingPlanMockForTest(){
  return [

      SeatinTypeVO(1, 'text', '', 'A', 0),
      SeatinTypeVO(2, 'space', '', 'A', 0),
      SeatinTypeVO(3, 'taken', 'A-2', 'A', 2),
      SeatinTypeVO(1, 'text', '', 'B', 0),
      SeatinTypeVO(2, 'available', 'B-1', 'B', 2),
      SeatinTypeVO(3, 'available', 'B-2', 'B', 2),


  ];
}

List<SeatinTypeVO> seatingForIntegrationForTest(){
  return [
    SeatinTypeVO(1, 'text', '', 'A', 0),
    SeatinTypeVO(2, 'space', '', 'A', 0),
    SeatinTypeVO(3, 'taken', 'A-2', 'A', 2),
    SeatinTypeVO(1, 'text', '', 'B', 0),
    SeatinTypeVO(2, 'available', 'B-1', 'B', 2),
    SeatinTypeVO(3, 'available', 'B-2', 'B', 2),
  ];
}

List<MovieVO> moviesMockForTest() {
  return [
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
  ];
}

List<CastCrewVO> actorsMockForTest() {
  return [
    CastCrewVO(false, null, 1, null, 'Actor 1', 'AA', null, null, 12, '43',
        null, null, null, null),
    CastCrewVO(false, null, 2, null, 'Actor 2', 'AA', null, null, 22, '73',
        null, null, null, null),
    CastCrewVO(false, null, 3, null, 'Actor 3', 'AA', null, null, 32, '53',
        null, null, null, null),
  ];
}

// ActorListForHiveVO actorToDatabaseMock() {
//   return ActorListForHiveVO(actorsMockForTest());
// }

List<SnackAndPaymentVO> paymentMockForTest() {
  return [
    SnackAndPaymentVO(1, 'Credit Card', 'Visa, Master Card, JCB', 0, ''),
    SnackAndPaymentVO(2, 'Internet Banking (ATM card)', 'Visa, Master Card, JCB', 0, ''),
    SnackAndPaymentVO(3, 'E-Wallet', 'AyaPay, KbzPay, WavePay', 0, ''),
  ];
}

UserVO profileMockForTest() {
  return UserVO(
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
  );
}

List<SnackAndPaymentVO> snacksMockForTest() {
  return [
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
  ];
}

List<dynamic> registerAndLoginMockForTest() {
  return [
    UserVO(568, "toetoe", "toetoe22@gmail.com", "959770222230", 0,
        "/img/avatar2.png", null, null),
    "4139|FPLMcjIhZIaupj47CpN6IiyMX7HHJ6ifRBbFIX3Y",
  ];
}
