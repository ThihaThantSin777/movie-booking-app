import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

abstract class PaymentDAO{
  void savePayment(List<SnackAndPaymentVO>paymentList);

  List<SnackAndPaymentVO>?getPaymentList();

  Stream<List<SnackAndPaymentVO>?>getPaymentListStream();

  Stream<void>getPaymentStream();
}