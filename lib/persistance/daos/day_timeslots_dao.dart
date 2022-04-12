
import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/day_timeslot_vo/day_timeslot_vo.dart';

class DayTimeTimeSlotsDao{
  DayTimeTimeSlotsDao.internal();

  static final DayTimeTimeSlotsDao _singleton=DayTimeTimeSlotsDao.internal();

  factory DayTimeTimeSlotsDao()=>_singleton;

  void saveDayTimeSlotsList(DayTimeSlotVO dayTimeSlotsList,String date){
    getDayTimeSlotsBox().put(date, dayTimeSlotsList);
  }

  DayTimeSlotVO? getDayTimeSlotsByDate(String date)=>getDayTimeSlotsBox().get(date);

  Box<DayTimeSlotVO> getDayTimeSlotsBox()=>Hive.box<DayTimeSlotVO>(BOX_NAME_DAY_TIMESLOTS_VO);

  Stream<void>getDayTimeSlotsStream(){
    return getDayTimeSlotsBox().watch();
  }

  Stream<DayTimeSlotVO?>getDayTimeSlotsByDateStream(String date)=>Stream.value(getDayTimeSlotsBox().get(date));
}