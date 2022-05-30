

import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/payment_dao.dart';

import '../mock_data/mock_data.dart';

class PaymentMethodDaoImplMock extends PaymentDAO{
   Map<int,SnackAndPaymentVO> paymentMethodDatabaseMock = {};
  @override
  List<SnackAndPaymentVO>? getPaymentList() {
    return paymentMockForTest();
  }

  @override
  Stream<List<SnackAndPaymentVO>?> getPaymentListStream() {
     return Stream.value(
        paymentMockForTest(),
     );
  }

  @override
  Stream<void> getPaymentStream() {
    return Stream<void>.value(null);
  }

  @override
  void savePayment(List<SnackAndPaymentVO> paymentList) {
    paymentList.forEach((element) {
        paymentMethodDatabaseMock[element.id!] = element;
      });
  }


}