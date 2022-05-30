import 'package:hive_flutter/adapters.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/movie_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

class MovieDAOImpl extends MovieDAO {
  MovieDAOImpl.internal();

  static final MovieDAOImpl _singleton = MovieDAOImpl.internal();

  factory MovieDAOImpl() => _singleton;

  @override
  void saveMovieList(List<MovieVO> movieList) {
    Map<int, MovieVO> movies = Map.fromIterable(movieList,
        key: (movies) => movies.id, value: (movies) => movies);
    _getMovieBox().putAll(movies);
  }

  @override
  List<MovieVO> getAllMovieList() {
    return _getMovieBox().values.toList();
  }

  @override
  MovieVO? getMoviesByID(int movieID) => _getMovieBox().get(movieID);

  @override
  void saveSingleMovieList(MovieVO movieVO) {
    _getMovieBox().put(movieVO.id, movieVO);
  }

  Box<MovieVO> _getMovieBox() => Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);

  @override
  Stream<void> getMovieStream() {
    return _getMovieBox().watch();
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesStream() {
    List<MovieVO> list = getAllMovieList();
    list.sort((a, b) => a.order > b.order ? 1 : -1);
    return Stream.value(
        list.where((element) => element.isNowShowing ?? false).toList());
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesStream() {
    List<MovieVO> list = getAllMovieList();
    list.sort((a, b) => a.order > b.order ? 1 : -1);

    return Stream.value(
        list.where((element) => element.isComingSoon ?? false).toList());
  }

  @override
  Stream<MovieVO?> getMovieStreamByID(int movieID) =>
      Stream.value(getMoviesByID(movieID));
}
