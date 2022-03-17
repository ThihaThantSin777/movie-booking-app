
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/user_vo/user_vo.dart';
import '../network/authentication/facebook_sigin.dart';
import '../network/authentication/google_sigin.dart';

class LoginSiginBloc extends ChangeNotifier {
  final GoogleSiginAuthentication _googleSiginAuthentication =
  GoogleSiginAuthentication();
  final FaceBookSiginAuthentication _faceBookSiginAuthentication =
  FaceBookSiginAuthentication();
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  bool _isLoading = false;
  bool _isShowLogin=true;
  bool _isShowSigin=false;

  get isShowLogin=>_isShowLogin;
  get isShowSigin=>_isShowSigin;
  get isLoading => _isLoading;

  set updateShowLogin(bool isShowLogin)=>_isShowLogin=isShowLogin;
  set updateShowSigin(bool isShowSigin)=>_isShowSigin=isShowSigin;
  set updateLoading(bool isLoading){
    _isLoading=isLoading;
    notifyListeners();
  }

  ///Action for tabBar
  void onTapTabBarChange(int tapStatus){
    updateShowLogin = tapStatus == 0 ? true : false;
    updateShowSigin = tapStatus == 1 ? true : false;
    notifyListeners();
  }

  ///Login with Password
  Future<UserVO?> getUserLoginStatusBloc(String email, String password) {
    updateLoading=true;
    notifyListeners();
    return _movieBookingModel.getUserLoginStatus(email, password);
  }

  ///Login with Google
  Future<UserVO?>loginWithGoogle(){
    updateLoading=true;
    notifyListeners();
    return googleSigin().then((value) => _movieBookingModel.loginWithGoogle(value?.id ?? ''));
  }

  ///Login with Facebook
  Future<UserVO?>loginWithFaceBook(){
    updateLoading=true;
    notifyListeners();
   return faceBookSigin().then((value) => _movieBookingModel.loginWithFacebook(value.accessToken?.userId ?? ''));
  }


 ///Sigin normal process
  Future<UserVO?>getUserRegisterStatusBloc( String name,
      String email,
      String phone,
      String password,
      String googleAccessToken,
      String faceBookAccessToken){
    updateLoading=true;
    notifyListeners();
    return _movieBookingModel.getUserRegisterStatus(name, email, phone, password, googleAccessToken, faceBookAccessToken);
  }
  ///Sigin with Google
  Future<GoogleSignInAccount?> googleSigin()=>_googleSiginAuthentication.gooleSigin();

  ///Sigin with Facebook
  Future<LoginResult> faceBookSigin()=>_faceBookSiginAuthentication.loginWithFacebook();

}