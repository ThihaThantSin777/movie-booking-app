import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class SnackAndPaymentBloc extends ChangeNotifier {
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<SnackAndPaymentVO>? _snackList;
  List<SnackAndPaymentVO>? _paymentMethodsList;
  int _totalPrice = 0;

  List<SnackAndPaymentVO>? get getSnackList => _snackList;
  List<SnackAndPaymentVO>? get getPaymentMethodsList => _paymentMethodsList;
  get getTotalPrice => _totalPrice;

  set setSnackList(List<SnackAndPaymentVO>? snackList) =>
      _snackList = snackList;
  set setPaymentMethodsList(List<SnackAndPaymentVO>? paymentMethodsList) =>
      _paymentMethodsList = paymentMethodsList;
  set setTotalPrice(int totalPrice) => _totalPrice = totalPrice;

  SnackAndPaymentBloc(int subPrice) {
    setTotalPrice=subPrice;
    _movieBookingModel
        .getSnackListFromDataBase(_movieBookingModel.getToken() ?? '')
        .listen((snackList) {
      setSnackList = snackList ;
      notifyListeners();
    }, onError: (error) => print(error));

    _movieBookingModel
        .getPaymentListFromDataBase(_movieBookingModel.getToken() ?? '')
        .listen((payments) {
      setPaymentMethodsList = payments ;
      notifyListeners();
    }, onError: (error) => print(error));

  }

  void paymentSelect(SnackAndPaymentVO snackAndPaymentVO) {
    List<SnackAndPaymentVO>? newPayment=getPaymentMethodsList?.map((element) {
      if (element == snackAndPaymentVO) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
      return element;
    }).toList();
    setPaymentMethodsList=newPayment;
    notifyListeners();
  }

  void increase(SnackAndPaymentVO snackVO) {
    List<SnackAndPaymentVO>? newSnack=getSnackList?.map((element) {
      if (snackVO == element) {
        element.quantity++;
        setTotalPrice = getTotalPrice + element.price;
      }
      return element;
    }).toList();
    setSnackList=newSnack;
    notifyListeners();
  }

  void decrese(SnackAndPaymentVO snackVO) {
    List<SnackAndPaymentVO>? newSnack=getSnackList?.map((element) {
      if (snackVO == element) {
        if (element.quantity != 0) {
          element.quantity--;
          setTotalPrice = getTotalPrice - element.price;
        }
      }
      return element;
    }).toList();

    setSnackList=newSnack;
    notifyListeners();
  }
}
