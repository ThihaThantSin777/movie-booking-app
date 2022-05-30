
import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/day_timeslots_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/day_timeslot_vo/day_timeslot_vo.dart';

class DayTimeTimeSlotsDaoImpl extends DayTimeSlotsDAO {
  DayTimeTimeSlotsDaoImpl.internal();

  static final DayTimeTimeSlotsDaoImpl _singleton=DayTimeTimeSlotsDaoImpl.internal();

  factory DayTimeTimeSlotsDaoImpl()=>_singleton;

  @override
  void saveDayTimeSlotsList(DayTimeSlotVO dayTimeSlotsList,String date){
    getDayTimeSlotsBox().put(date, dayTimeSlotsList);
  }

  @override
  DayTimeSlotVO? getDayTimeSlotsByDate(String date)=>getDayTimeSlotsBox().get(date);

  Box<DayTimeSlotVO> getDayTimeSlotsBox()=>Hive.box<DayTimeSlotVO>(BOX_NAME_DAY_TIMESLOTS_VO);

  @override
  Stream<void>getDayTimeSlotsStream(){
    return getDayTimeSlotsBox().watch();
  }

  @override
  Stream<DayTimeSlotVO?>getDayTimeSlotsByDateStream(String date)=>Stream.value(getDayTimeSlotsBox().get(date));
}