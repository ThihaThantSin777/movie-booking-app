import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

abstract class SnackDAO{
  void saveSnack(List<SnackAndPaymentVO>snackList);

  List<SnackAndPaymentVO>?getSnackList();

  Stream<List<SnackAndPaymentVO>?>getSnackListStream();

  Stream<void>getSnackStream();
}