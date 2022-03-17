
import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import '../data/vos/day_timeslot_vo/time_slots_vo.dart';

class PickTimeAndCinemaBloc extends ChangeNotifier{
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<DayTimeSlotVO>? _daytimeSlotVOList;
   String _date =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  TimeSlotsVO? _timeSlotsVO;
  DayTimeSlotVO? _dayTimeSlotVO;
  String _dateTime = DateTime.now().toString();
  bool _isRefresh=false;
  get getDayTimeSlotsVO=>_daytimeSlotVOList;
  get getDateTime=> _dateTime;
  get getDate=>_date;
  get getTimeSlotsVO=> _timeSlotsVO;
  get getDaySlotsVO=>_dayTimeSlotVO;
  get getRefreshStatus=>_isRefresh;


  set setDayTimeSlotsVO(List<DayTimeSlotVO>? daytimeSlotVOList)=>_daytimeSlotVOList=daytimeSlotVOList;
  set setDateTime(String dateTime)=>_dateTime=dateTime;
  set setDate(String date)=>_date=date;
  set setTimeSlotsVO(TimeSlotsVO? timeSlotsVO)=>_timeSlotsVO=timeSlotsVO;
  set setDaySlotsVO(DayTimeSlotVO? daySlotVO)=>_dayTimeSlotVO=daySlotVO;
  set setRefreshStatus(bool isRefresh)=>_isRefresh=isRefresh;

  PickTimeAndCinemaBloc(int movieID){
    _movieBookingModel.getDayTimeSlotsListFromDataBase(movieID, _movieBookingModel.getToken() ?? '', _date).listen((value) {

      setDayTimeSlotsVO = value?.daytimeSlotVOList??[];
      notifyListeners();
    },
        onError: (error)=>print(error)
    );
  }
  void onDateChange(DateTime date,int movieID) {
    String tempDate='${date.year}-${date.month}-${date.day}';
      setDateTime = date.toString();
      setDate = date.toString().substring(0, 10);
      _movieBookingModel.getDayTimeSlotsListFromDataBase(movieID, _movieBookingModel.getToken() ?? '', tempDate).listen((value) {
          setDayTimeSlotsVO = value?.daytimeSlotVOList??[];
          notifyListeners();
      },
          onError: (error)=>print(error)
      );
      getDayTimeSlotsVO.forEach((element1) {
        element1.timeSlots.forEach((element2) {
          element2.isSelect = false;
        });
      });
  notifyListeners();
  }

  void selectTimeSlot(TimeSlotsVO timeSlotsVO) {
    getDayTimeSlotsVO?.forEach((element1) {
      element1.timeSlots?.forEach((element2) {
        if (element2 == timeSlotsVO) {
          element2.isSelect = true;
        } else {
          element2.isSelect = false;
        }
      });
    });
    setRefreshStatus=!getRefreshStatus;
    notifyListeners();
  }

  Future<DayTimeSlotVO?> checkIfDateIsSelectOrNot(){
    DayTimeSlotVO dayTimeSlotVO=DayTimeSlotVO.normal();
    getDayTimeSlotsVO.forEach((element1) {
      element1.timeSlots.forEach((element2) {
        if (element2.isSelect) {
         dayTimeSlotVO=element1;
          dayTimeSlotVO.subTimeSlots= element2;
        }
      });
    });

    return Future.value(dayTimeSlotVO);
  }
}


