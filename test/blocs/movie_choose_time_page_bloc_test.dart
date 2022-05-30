import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/pick_time_and_cinema_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Movie Choose Time Page Bloc",(){

    PickTimeAndCinemaBloc? chooseTimeBloc;

  setUp((){
    chooseTimeBloc = PickTimeAndCinemaBloc(123,MovieModelImplMock());
  });


  test("Fetch Cinema Data",(){
    expect(
      chooseTimeBloc?.getDayTimeSlotsVO?.contains(cinemaDayTimeslotMockForTest().first),
       true,
       );
  });


  test("Cinema Choose Time By User",()async{
    chooseTimeBloc?.onDateChange(DateTime.now(),123);
    expect(
      chooseTimeBloc?.getDayTimeSlotsVO?.contains(cinemaDayTimeslotMockForTest().first),
       true,
       );
  });

  });

}