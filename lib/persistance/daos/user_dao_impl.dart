import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/user_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

class UserDAOImpl extends UserDAO {
  UserDAOImpl.internal();

  static final UserDAOImpl _singleton = UserDAOImpl.internal();

  factory UserDAOImpl() => _singleton;

  @override
  void saveUser(UserVO userVO) {
    _getUserBox().put(userVO.id, userVO);
  }

  @override
  void deleteUser() => _getUserBox().clear();

  @override
  UserVO? getUserInfo() => _getUserBox().values.first;

  @override
  bool isUserVOEmpty() => _getUserBox().isEmpty;

  @override
  String? getAuthorizationToken() => 'Bearer ${getUserInfo()?.token}';

  Box<UserVO> _getUserBox() => Hive.box<UserVO>(BOX_NAME_USER_VO);

  @override
  Stream<void> getUserStream() {
    return _getUserBox().watch();
  }

  @override
  Stream<UserVO?> getUserInfoStream() => Stream.value(getUserInfo());
}
