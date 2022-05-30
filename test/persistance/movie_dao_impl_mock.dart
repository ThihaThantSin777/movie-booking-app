import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/movie_dao.dart';

import '../mock_data/mock_data.dart';


class MovieDaoImplMock extends MovieDAO{
   Map<int,MovieVO> movieDatabaseMock = {};
  @override
  List<MovieVO> getAllMovieList() {
    return moviesMockForTest();
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesStream() {
        return Stream.value(moviesMockForTest()
            .where((element) => element.isComingSoon ?? false)
            .toList());

  }

  @override
  Stream<void> getMovieStream() {
    return Stream<void>.value(null);
  }

  @override
  Stream<MovieVO?> getMovieStreamByID(int movieID) {
    return Stream.value(getMoviesByID(movieID));
  }

  @override
  MovieVO? getMoviesByID(int movieID) {
      return moviesMockForTest()
      .firstWhere((element) =>
      element.id == movieID);
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesStream() {

      return Stream.value(moviesMockForTest()
          .where((element) => element.isNowShowing ?? false)
          .toList());

  }

  @override
  saveMovieList(List<MovieVO> movieList) {
      movieList.forEach((element) {
        movieDatabaseMock[element.id!] = element;
      });
  }

  @override
  void saveSingleMovieList(MovieVO movieVO) {
    movieDatabaseMock[movieVO.id!] = movieVO;
  }


}