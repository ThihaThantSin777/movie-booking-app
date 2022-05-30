
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/user_dao.dart';

import '../mock_data/mock_data.dart';

class UserDaoImplMock extends UserDAO{
   Map<int,UserVO> userInfoDatabaseMock = {};
  @override
  void deleteUser() {

  }

  @override
  String? getAuthorizationToken() {
    return '';
  }

  @override
  UserVO? getUserInfo() {
    return profileMockForTest();
  }

  @override
  Stream<UserVO?> getUserInfoStream() {
      return Stream.value(
        profileMockForTest(),
      );
  }

  @override
  Stream<void> getUserStream() {
    return Stream<void>.value(null);
  }

  @override
  bool isUserVOEmpty() {
    return false;
  }

  @override
  void saveUser(UserVO userVO) {
   userInfoDatabaseMock[userVO.id!] = userVO;
  }






}