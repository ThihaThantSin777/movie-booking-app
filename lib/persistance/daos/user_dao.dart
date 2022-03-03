import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/user_vo/user_vo.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

class UserDAO {
  UserDAO.internal();

  static final UserDAO _singleton = UserDAO.internal();

  factory UserDAO() => _singleton;

  void saveUser(UserVO userVO) {
    _getUserBox().put(userVO.id, userVO);
    print('Save User');
    print('');
  }

    void deleteUser() => _getUserBox().clear();

    void delete(UserVO? userVO) => _getUserBox().delete(userVO?.id ?? 0);

    UserVO? getUserInfo() => _getUserBox().values.first;

    bool isUserVOEmpty() => _getUserBox().isEmpty;

    String? getAuthorizationToken() => 'Bearer ${getUserInfo()?.token}';

    Box<UserVO> _getUserBox() => Hive.box<UserVO>(BOX_NAME_USER_VO);

    Stream<void>getUserStream() {
      print('Watch User Stream');
      print('');
     return  _getUserBox().watch();
    }

      Stream<UserVO?>getUserInfoStream()=>Stream.value(getUserInfo());
    }


