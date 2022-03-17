import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/movie_vo/movie_vo.dart';
import '../data/vos/user_vo/user_vo.dart';
import '../network/api_constant/api_constant.dart';
import '../network/response/logout_response/logout_response.dart';

class HomeBloc extends ChangeNotifier {
   UserVO? _userVO;
   List<MovieVO>? _getNowPlayingmovieVO;
   List<MovieVO>? _getComingSoonMovieVO;
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();


  get getUser=>_userVO;
  get getNowPlayingVO=>_getNowPlayingmovieVO;
  get getComingSoonVO=>_getComingSoonMovieVO;

  set setUser(UserVO? userVO)=>_userVO=userVO;
  set setNowPlayingVO(List<MovieVO>? nowPlayingVO)=>_getNowPlayingmovieVO=nowPlayingVO;
  set setComingSoonVO(List<MovieVO>? comingSoonVO)=>_getComingSoonMovieVO=comingSoonVO;

  HomeBloc() {
    ///get SnackList
    _movieBookingModel.getSnackList(_movieBookingModel.getToken() ?? '');

    ///get User Data
    _movieBookingModel.getUserInfo().listen((user) {
        setUser=user;
        notifyListeners();
    },
        onError: (error)=>print(error)
    );

    ///get Now Playing movies
    _movieBookingModel.getNowPlayingMovieModleFromDataBase(API_KEY, LANGUAGE, 1).listen((movies) {

      setNowPlayingVO = movies;
      notifyListeners();
    },
        onError: (error)=>print(error)
    );
    ///get Coming soon movies
    _movieBookingModel.getComingSoonMovieModleFromDataBase(API_KEY, LANGUAGE, 1).listen((movies) {

        setComingSoonVO = movies;

    },
        onError: (error)=>print(error)
    );
  }

  ///Logout
  Future<LogoutResponse?>logout()=>_movieBookingModel.logout(_movieBookingModel.getToken() ?? '');


  ///Delete User Data
  void deleteUserData()=>_movieBookingModel.deleteUserInfo();
}
