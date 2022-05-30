import '../../data/vos/day_timeslot_vo/day_timeslot_vo.dart';

abstract class DayTimeSlotsDAO{
  void saveDayTimeSlotsList(DayTimeSlotVO dayTimeSlotsList,String date);

  DayTimeSlotVO? getDayTimeSlotsByDate(String date);

  Stream<DayTimeSlotVO?>getDayTimeSlotsByDateStream(String date);

  Stream<void>getDayTimeSlotsStream();

}