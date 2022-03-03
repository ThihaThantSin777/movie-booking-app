

import 'package:hive/hive.dart';
import 'package:movie_booking_app/persistance/hive_constant.dart';

import '../../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class SnackDAO{
  SnackDAO.internal();

  static final SnackDAO _singleton=SnackDAO.internal();

  factory SnackDAO()=>_singleton;

  void saveSnack(List<SnackAndPaymentVO>snakList){
    Map<int,SnackAndPaymentVO>snacks=Map.fromIterable(snakList,key: (snack)=>snack.id,value: (snack)=>snack);
    getSnackBox().putAll(snacks);
    print('Save Snacks');
    print('');
  }

  List<SnackAndPaymentVO>?getSnackList()=>getSnackBox().values.toList();

  Box<SnackAndPaymentVO>getSnackBox()=>Hive.box<SnackAndPaymentVO>(BOX_NAME_SNACK_VO);

  Stream<void>getSnackStream(){
    print('Watch Snack Stream');
    print('');
    return getSnackBox().watch();

  }

  Stream<List<SnackAndPaymentVO>?>getSnackListStream()=>Stream.value(getSnackList());
}