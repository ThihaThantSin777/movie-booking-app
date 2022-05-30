import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/home_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

group("Home Page BLoc",(){


    HomeBloc? movieListBloc;

  setUp((){
    movieListBloc = HomeBloc(MovieModelImplMock());
  });



  // test("Fetch Login User Info",(){
  //   expect(
  //     movieListBloc?.getUser,
  //     profileMockForTest(),
  //      );
  // });


  test("Fetch Now Playing Movies",(){
      expect(
        movieListBloc?.getNowPlayingVO?.contains(moviesMockForTest().first),
         true,
         );
  });


  test("Fetch Coming Soon Movies",(){
    expect(
      movieListBloc?.getComingSoonVO?.contains(moviesMockForTest().last),
       true,
       );
  });

});

}