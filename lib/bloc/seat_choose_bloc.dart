
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/seating_plan_vo/seating_type_vo.dart';

class SeatChooseBloc extends ChangeNotifier{
   MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<SeatinTypeVO>? _seatTypeVO;
  int _seatCount = 0;
  String _selectSeatName = "";
  int _price = 0;
  List<String> _selectSeats = [];
  String _dateTemp = '';


  get getSeatTypeVO=>_seatTypeVO;
  get getSeatCount=>_seatCount;
  get getSelectSeatName=>_selectSeatName;
  get getPrice=>_price;
  get getSelectSeat=>_selectSeats;
  get getDateTemp=>_dateTemp;

  set setSeatTypeVO(List<SeatinTypeVO>seatTypeVO)=>_seatTypeVO=seatTypeVO;
  set setSeatCount(int seatCount)=>_seatCount=seatCount;
  set setSelectSeatName(String selectSeatName)=>_selectSeatName=selectSeatName;
  set setPrice(int price)=>_price=price;
  set setSelectSeats(List<String> selectSeats)=>_selectSeats=selectSeats;
  set setDateTemp(String dateTemp)=>_dateTemp=dateTemp;

  SeatChooseBloc(String date,TimeSlotsVO timeSlotsVO,[MovieBookingModel? movieBookingModel]) {
    if(movieBookingModel!=null){
      _movieBookingModel=movieBookingModel;
    }
    setDateTemp =date;
    DateTime dateTime = DateTime.parse(getDateTemp);
    date =
    '${DateFormat('EEEE, dd, MMM').format(dateTime)} , ${timeSlotsVO.startTime ?? ""}';
    _movieBookingModel
        .getSeatingTypeList(timeSlotsVO.cinemaDayTimeSlotID ?? 0,
        getDateTemp, _movieBookingModel.getToken()?? '')
        .then((value) {

      setSeatTypeVO = value!;
      notifyListeners();

    }).catchError((error) => print(error));
  }

  void selectSeat(SeatinTypeVO seatVO){
    getSeatTypeVO.forEach((element) {
      if (element == seatVO) {
        element.isSelect = !element.isSelect;
        if (element.isSelect) {
          setSeatCount=getSeatCount+1;

          getSelectSeat.add(element.seatName ?? '');
          setPrice= getPrice+element.price ?? 0;
        } else {
          setSeatCount=getSeatCount-1;
          getSelectSeat.remove(element.seatName ?? '');
          setPrice= getPrice-element.price ?? 0;
        }
       }
    });
    setSelectSeatName = getSelectSeat.join(',');
    notifyListeners();
  }
}