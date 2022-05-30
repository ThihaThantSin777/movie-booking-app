import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';

abstract class UserDAO{
  void saveUser(UserVO userVO);

  void deleteUser();

  UserVO? getUserInfo();

  bool isUserVOEmpty();

  String? getAuthorizationToken();

  Stream<UserVO?>getUserInfoStream();

  Stream<void>getUserStream();
}