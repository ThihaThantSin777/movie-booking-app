// import 'package:hw3_movie_booking_app/data/data.vos/user_vo.dart';
// import 'package:hw3_movie_booking_app/persistance/abstraction_layer/cards_from_profile_dao.dart';
//
// import '../mock_data/mock_data.dart';
//
// class CardsFromProfileDaoImplMock extends CardsFromProfileDao{
//
// Map<String,UserVO> cardsFromProfileDatabaseMock = {};
//
//   @override
//   UserVO? getAllCards(String tokenData) {
//     return profileMockForTest();
//   }
//
//   @override
//   Stream<void> getAllCardsEventStream() {
//     return Stream<void>.value(null);
//   }
//
//     @override
//   UserVO? getAllCardsData(String tokenData) {
//     if(profileMockForTest() != null){
//       return profileMockForTest();
//     }
//   }
//
//   @override
//   Stream<UserVO?> getAllCardsStream(String tokenData) {
//     return Stream.value(profileMockForTest());
//   }
//
//   @override
//   void getCardsFromProfileDatabase(UserVO userData) {
//     cardsFromProfileDatabaseMock[userData.token!] = userData;
//   }
//
//
//
// }