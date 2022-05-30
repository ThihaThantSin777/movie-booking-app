import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/seat_choose_bloc.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Movie Seat Page Bloc",(){

    SeatChooseBloc? seatBloc;

      setUp((){
          seatBloc = SeatChooseBloc("2022-04-12",TimeSlotsVO.normal(),MovieModelImplMock());
      });


      test("Fetch Seat Data",(){
        expect(
          seatBloc?.getSeatTypeVO?.contains(seatingForIntegrationForTest().first),
          true,
          );
      });



  });

}