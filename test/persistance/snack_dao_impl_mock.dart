

import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/snack_dao.dart';

import '../mock_data/mock_data.dart';

class SnackDaoImplMock extends SnackDAO{
   Map<int,SnackAndPaymentVO> snackDatabaseMock = {};
  @override
  List<SnackAndPaymentVO>? getSnackList() {
    return snacksMockForTest();
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getSnackListStream() {
        return Stream.value(
      snacksMockForTest(),
    );
  }

  @override
  Stream<void> getSnackStream() {
    return Stream<void>.value(null);
  }

  @override
  void saveSnack(List<SnackAndPaymentVO> snackList) {
          snackList.forEach((element) {
        snackDatabaseMock[element.id!] = element;
      });
  }



}