
import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/network/response/create_card_response/create_card_response.dart';

import '../data/modle/movie_booking_model.dart';
import '../data/modle/movie_booking_model_impl.dart';

class AddNewCardBloc extends ChangeNotifier{
  final MovieBookingModel _movieBookingModel = MovieBookingModelImpl();

  Future<CreateCardResponse?>createCard({required String cardNumber,required String cardHolder,required String expirationDate,required String cvc}) {
  String authorization=_movieBookingModel.getToken()??'';
    return _movieBookingModel.createCard(
        cardNumber, cardHolder, expirationDate, cvc, authorization);
  }

  void getProfile()=>_movieBookingModel.getProfile(_movieBookingModel.getToken()??'');

}