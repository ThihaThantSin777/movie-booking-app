import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';

abstract class MovieDAO{
  saveMovieList(List<MovieVO>movieList);

  List<MovieVO>getAllMovieList();

  MovieVO? getMoviesByID(int movieID);

  void saveSingleMovieList(MovieVO movieVO);

  Stream<List<MovieVO>?>getNowPlayingMoviesStream();

  Stream<List<MovieVO>?>getComingSoonMoviesStream();

  Stream<MovieVO?>getMovieStreamByID(int movieID);
  Stream<void> getMovieStream();
}