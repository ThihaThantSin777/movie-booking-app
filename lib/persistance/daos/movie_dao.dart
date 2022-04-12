
import 'package:hive_flutter/adapters.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

class MovieDAO{
  MovieDAO.internal();

  static final MovieDAO _singleton=MovieDAO.internal();

  factory MovieDAO()=>_singleton;

  void saveMovieList(List<MovieVO>movieList){
    Map<int,MovieVO>movies=Map.fromIterable(movieList,key: (movies)=>movies.id,value: (movies)=>movies);
    _getMovieBox().putAll(movies);

  }

  List<MovieVO>getAllMovieList()=>_getMovieBox().values.toList();

  MovieVO? getMoviesByID(int movieID)=>_getMovieBox().get(movieID);

  void saveSingleMovieList(MovieVO movieVO){
    _getMovieBox().put(movieVO.id,movieVO);
  }

  Box<MovieVO>_getMovieBox()=>Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);

  Stream<void>getMovieStream(){
    return _getMovieBox().watch();
  }

  Stream<List<MovieVO>?>getNowPlayingMoviesStream() {
    List<MovieVO> list =getAllMovieList();
    list.sort((a, b) => a.order > b.order ? 1 : -1);
    return Stream.value(list
        .where((element) => element.isNowShowing ?? false)
        .toList());
  }

    Stream<List<MovieVO>?>getComingSoonMoviesStream() {
      List<MovieVO> list =getAllMovieList();
      list.sort((a, b) => a.order > b.order ? 1 : -1);

      return Stream.value(list
          .where((element) => element.isComingSoon ?? false)
          .toList());
    }

    Stream<MovieVO?>getMovieStreamByID(int movieID)=>Stream.value(getMoviesByID(movieID));
  }




