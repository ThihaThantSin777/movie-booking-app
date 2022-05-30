
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/day_timeslots_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaDayTimeslotDaoMock extends DayTimeSlotsDAO{
   Map<String,DayTimeSlotVO> cinemaDatabaseMock = {};
  @override
  DayTimeSlotVO? getDayTimeSlotsByDate(String date) {
    return cinemaDayTimeslotMockForTest().first;
  }

  @override
  Stream<DayTimeSlotVO?> getDayTimeSlotsByDateStream(String date) {
    return Stream.value(cinemaDayTimeslotMockForTest().first);
  }

  @override
  Stream<void> getDayTimeSlotsStream() {
    return Stream<void>.value(null);
  }

  @override
  void saveDayTimeSlotsList(DayTimeSlotVO dayTimeSlotsList, String date) {
    cinemaDatabaseMock[date] = dayTimeSlotsList;
  }

}