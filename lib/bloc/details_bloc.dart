import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/cast_crew_vo/cast_crew_vo.dart';
import '../data/vos/movie_vo/movie_vo.dart';
import '../network/api_constant/api_constant.dart';

class DetailsBloc extends ChangeNotifier {
  MovieVO? _movieVO;
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<CastCrewVO>? _castCrewVO;

  get getMovieVO => _movieVO;

  get getCastCrewVO => _castCrewVO;

  set setMovieVO(MovieVO? movieVO) => _movieVO = movieVO;

  set setCastCrewVO(List<CastCrewVO>? castCrewVO) => _castCrewVO = castCrewVO;

  DetailsBloc(int movieID) {
    _movieBookingModel
        .getMovieDetailsFromDataBase(movieID, API_KEY, LANGUAGE)
        .listen((movie) {
      setMovieVO = movie;
      notifyListeners();
    }, onError: (error) => print(error));

    _movieBookingModel
        .getActorListFromDataBase(movieID, API_KEY, LANGUAGE)
        .listen((cast) {
      setCastCrewVO = cast?.castList ?? [];
      notifyListeners();
    }, onError: (error) => print(error));
  }
}
