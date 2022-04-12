

import 'package:flutter/foundation.dart';

import '../data/vos/check_out_vo/checkout_vo.dart';
import '../data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import '../data/vos/movie_vo/movie_vo.dart';

class CheckOutBloc extends ChangeNotifier{
   CheckoutVO ?_checkoutVO;
   MovieVO ?_movieVO;
   DayTimeSlotVO ?_dayTimeSlotVO;
   String ?_formatDate;

   set setCheckoutVO(CheckoutVO checkoutVO)=>_checkoutVO=checkoutVO;
   set setMovieVO(MovieVO movieVO)=>_movieVO=movieVO;
   set setDayTimeSlotsVO(DayTimeSlotVO dayTimeSlotVO)=>_dayTimeSlotVO=dayTimeSlotVO;
   set setFormatDate(String formatDate)=>_formatDate=formatDate;

   get getCheckoutVO=>_checkoutVO;
   get getMovieVO=>_movieVO;
   get getDayTimeSlotsVO=>_dayTimeSlotVO;
   get getFormatDate=>_formatDate;

   CheckOutBloc(CheckoutVO checkoutVO,MovieVO movieVO,DayTimeSlotVO dayTimeSlotVO,String formatDate){
     setCheckoutVO=checkoutVO;
     setMovieVO=movieVO;
     setDayTimeSlotsVO=dayTimeSlotVO;
     setFormatDate=formatDate;
     notifyListeners();
   }

}