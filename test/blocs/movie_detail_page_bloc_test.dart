import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/details_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

group("Movie Detail Page Bloc",(){

    DetailsBloc? movieDetailBloc;


  setUp((){
    movieDetailBloc = DetailsBloc(123,MovieModelImplMock());
  });



  test("Fetch Movie Details",(){
    expect(
      movieDetailBloc?.getMovieVO,
       moviesMockForTest().first,
      );
  });


  test("Fetch Actors",(){
    expect(
      movieDetailBloc?.getCastCrewVO?.contains(actorsMockForTest().first),
       true,
       );
  });

});

}