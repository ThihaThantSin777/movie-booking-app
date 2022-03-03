

import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class PaymentDAO{
  PaymentDAO.internal();

  static final PaymentDAO _singleton=PaymentDAO.internal();

  factory PaymentDAO()=>_singleton;

  void savePayment(List<SnackAndPaymentVO>paymentList){
    Map<int,SnackAndPaymentVO>payments=Map.fromIterable(paymentList,key: (paymentID)=>paymentID.id,value: (payment)=>payment);
    getPaymentBox().putAll(payments);
    print('Save Payment');
    print('');
  }

  List<SnackAndPaymentVO>?getPaymentList()=>getPaymentBox().values.toList();

  Box<SnackAndPaymentVO>getPaymentBox()=>Hive.box<SnackAndPaymentVO>(BOX_NAME_PAYMENT_VO);

  Stream<void>getPaymentStream(){
    print('Watch payment Stream');
    print('');
    return getPaymentBox().watch();
  }

  Stream<List<SnackAndPaymentVO>?>getPaymentListStream()=>Stream.value(getPaymentList());
}