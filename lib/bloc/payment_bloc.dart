import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/vos/user_vo/select_card_vo.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';
import '../data/vos/check_out_vo/checkout_vo.dart';
import '../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import '../data/vos/user_vo/card_vo.dart';
import '../network/response/check_out_response/check_out_raw_response.dart';
class PaymentBloc extends ChangeNotifier {
  List<CardVO>? _cardVO;
   MovieBookingModel _movieBookingModel = MovieBookingModelImpl();
  CardVO ?_card;
  bool _isLoading = false;
  List<SelectCardVO> ?_selectCardVO;

  List<SelectCardVO> ? get getSelectCardVO=>_selectCardVO;

  set setSelectCardVO(List<SelectCardVO>? selectCardVO)=>_selectCardVO=selectCardVO;

  get getCardVO => _cardVO;

  get getCard => _card;

  get isLoading => _isLoading;

  set setCardVO(List<CardVO>? cardVO) => _cardVO = cardVO;

  set setCard(CardVO ?card) => _card = card;

  set setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  PaymentBloc([MovieBookingModel?movieBookingModel]) {
    if(movieBookingModel!=null){
      _movieBookingModel=movieBookingModel;
    }
    _movieBookingModel.getProfileFromDataBase().listen((user) {
      setCardVO = user?.cards?.reversed.toList();
      setCard = getCardVO[0] ?? CardVO.normal();
      List<SelectCardVO>_temp=[];
      user?.cards?.reversed.toList().forEach((element) {
        SelectCardVO selectVO=SelectCardVO(false, element);
        _temp.add(selectVO);
      });
      setSelectCardVO=_temp;
      notifyListeners();
    },
        onError: (error) => print(error)
    );

  }

  void saveCard(CardVO cardVO) {
    setCard = cardVO;

   List<SelectCardVO>?selectList= getSelectCardVO?.map((element) {
      if(element.cardVO==cardVO){
        element.isSelect=true;
      }else{
        element.isSelect=false;
      }
      return element;
    }).toList();
   setSelectCardVO=selectList;
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
