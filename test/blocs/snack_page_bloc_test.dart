import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/snack_and_payment_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Snack Page Bloc",(){

    SnackAndPaymentBloc? snackBloc;

      setUp((){
        snackBloc = SnackAndPaymentBloc(123,MovieModelImplMock());
      });


      test("Snack Data Test",(){
        expect(
          snackBloc?.getSnackList?.contains(snacksMockForTest().first),
          true,
          );
      });

      test("Payment Method Test",(){
        expect(
          snackBloc?.getPaymentMethodsList?.contains(paymentMockForTest().first),
           true,
           );
      }
      );


  });

}