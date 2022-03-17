import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';

class SnackAndPaymentBloc extends ChangeNotifier {
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  List<SnackAndPaymentVO>? _snackList;
  List<SnackAndPaymentVO>? _paymentMethodsList;
  int _totalPrice = 0;
  bool _isRefresh=false;

  get getSnackList => _snackList;
  get getPaymentMethodsList => _paymentMethodsList;
  get getTotalPrice => _totalPrice;
  get isRefresh=>_isRefresh;

  set setSnackList(List<SnackAndPaymentVO>? snackList) =>
      _snackList = snackList;
  set setPaymentMethodsList(List<SnackAndPaymentVO>? paymentMethodsList) =>
      _paymentMethodsList = paymentMethodsList;
  set setTotalPrice(int totalPrice) => _totalPrice = totalPrice;
  set setRefresh(bool isRefresh)=>_isRefresh=isRefresh;

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
    getPaymentMethodsList.forEach((element) {
      if (element == snackAndPaymentVO) {
        element.isSelect = true;
      } else {
        element.isSelect = false;
      }
    });
    setRefresh=!isRefresh;
    notifyListeners();
  }

  void increase(SnackAndPaymentVO snackVO) {
    getSnackList.forEach((element) {
      if (snackVO == element) {
        element.quantity++;
        setTotalPrice = getTotalPrice + element.price;
      }
    });
    setRefresh=!isRefresh;
    notifyListeners();
  }

  void decrese(SnackAndPaymentVO snackVO) {
    getSnackList.forEach((element) {
      if (snackVO == element) {
        if (element.quantity != 0) {
          element.quantity--;
          setTotalPrice = getTotalPrice - element.price;
        }
      }
    });
    setRefresh=!isRefresh;
    notifyListeners();
  }
}
