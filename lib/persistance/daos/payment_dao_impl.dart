

import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/payment_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class PaymentDAOImpl extends PaymentDAO{
  PaymentDAOImpl.internal();

  static final PaymentDAOImpl _singleton=PaymentDAOImpl.internal();

  factory PaymentDAOImpl()=>_singleton;

  @override
  void savePayment(List<SnackAndPaymentVO>paymentList){
    Map<int,SnackAndPaymentVO>payments=Map.fromIterable(paymentList,key: (paymentID)=>paymentID.id,value: (payment)=>payment);
    getPaymentBox().putAll(payments);
  }

  @override
  List<SnackAndPaymentVO>?getPaymentList()=>getPaymentBox().values.toList();

  Box<SnackAndPaymentVO>getPaymentBox()=>Hive.box<SnackAndPaymentVO>(BOX_NAME_PAYMENT_VO);

  @override
  Stream<void>getPaymentStream(){
    return getPaymentBox().watch();
  }

  @override
  Stream<List<SnackAndPaymentVO>?>getPaymentListStream()=>Stream.value(getPaymentList());
}