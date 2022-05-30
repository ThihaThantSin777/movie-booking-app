

import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/abstraction_layer/snack_dao.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class SnackDAOImpl extends SnackDAO{
  SnackDAOImpl.internal();

  static final SnackDAOImpl _singleton=SnackDAOImpl.internal();

  factory SnackDAOImpl()=>_singleton;

  @override
  void saveSnack(List<SnackAndPaymentVO>snackList){
    Map<int,SnackAndPaymentVO>snacks=Map.fromIterable(snackList,key: (snack)=>snack.id,value: (snack)=>snack);
    getSnackBox().putAll(snacks);
  }
  @override
  List<SnackAndPaymentVO>?getSnackList()=>getSnackBox().values.toList();

  Box<SnackAndPaymentVO>getSnackBox()=>Hive.box<SnackAndPaymentVO>(BOX_NAME_SNACK_VO);

  @override
  Stream<void>getSnackStream(){
    return getSnackBox().watch();

  }
  @override
  Stream<List<SnackAndPaymentVO>?>getSnackListStream()=>Stream.value(getSnackList());
}