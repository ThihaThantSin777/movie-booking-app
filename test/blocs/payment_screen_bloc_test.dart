import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/bloc/payment_bloc.dart';
import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Payment Cards Screen Test",(){

    PaymentBloc? paymentBloc;

      setUp((){
        paymentBloc = PaymentBloc(MovieModelImplMock());
      });


      test("Profile Data Test",(){
          expect(
            paymentBloc?.getCardVO?.contains(profileMockForTest().cards?.first),
             true,
             );
      });



  });

}