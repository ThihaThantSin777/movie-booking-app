import 'package:flutter/foundation.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/check_out_vo/checkout_vo.dart';
import '../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import '../data/vos/user_vo/card_vo.dart';
import '../network/response/check_out_response/check_out_raw_response.dart';
class PaymentBloc extends ChangeNotifier {
  List<CardVO>? _cardVO;
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  CardVO ?_card;
  bool _isLoading = false;

  get getCardVO => _cardVO;

  get getCard => _card;

  get isLoading => _isLoading;

  set setCardVO(List<CardVO>? cardVO) => _cardVO = cardVO;

  set setCard(CardVO ?card) => _card = card;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  PaymentBloc() {
    _movieBookingModel.getProfileFromDataBase().listen((user) {
      setCardVO = user?.cards;
      setCard = getCardVO[0] ?? CardVO.normal();
      notifyListeners();
    },
        onError: (error) => print(error)
    );

  }

  void saveCard(CardVO cardVO) {
    setCard = cardVO;
    notifyListeners();
  }

  Future<CheckoutVO?> navigateToCheckOutScreen(context,
      {required CardVO ?card, required String bookingDate, required int cinemaDayTimeSlotID, required String row, required String seats, required int totalPrice, required int movieID, required int cinemaID, required List<
          SnackAndPaymentVO> snacks}) {
    setLoading = true;
    if (card?.cardNumber != null) {
      notifyListeners();
      DateTime bookingDateConvert = DateTime.parse(bookingDate);
      String date =
          '${bookingDateConvert.year}-${bookingDateConvert
          .month}-${bookingDateConvert.day}';
      CheckOutRawResponse checkOutRawResponse = CheckOutRawResponse(
          cinemaDayTimeSlotID,
          row,
          seats,
          date,
          totalPrice,
          movieID,
          card?.id,
          cinemaID,
          snacks
      );
      return _movieBookingModel
          .checkout(_movieBookingModel.getToken() ?? '', checkOutRawResponse);
    }
    return Future.value(CheckoutVO.normal());
  }

}
