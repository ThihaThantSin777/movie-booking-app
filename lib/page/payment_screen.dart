import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/user_vo/card_vo.dart';
import 'package:movie_booking_app/page/checkout_screen.dart';
import 'package:movie_booking_app/persistance/daos/user_dao.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';

import '../data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import '../data/vos/day_timeslot_vo/time_slots_vo.dart';
import '../data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import '../network/response/check_out_response/check_out_raw_response.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/button_text_widget.dart';
import '../widgets/button_widget.dart';
import 'add_new_card.dart';

class PaymentScreen extends StatefulWidget {
  final int totalPrice;
  final DayTimeSlotVO dayTimeSlotVO;
  final TimeSlotsVO timeSlotsVO;
  final String bookingDate;
  final List<SnackAndPaymentVO> snackList;
  final MovieVO movieVO;
  final String row;
  final String seats;
  final String formatDate;
  PaymentScreen(
      {required this.totalPrice,
      required this.dayTimeSlotVO,
      required this.timeSlotsVO,
      required this.bookingDate,
      required this.snackList,
      required this.movieVO,
      required this.row,
      required this.seats,
      required this.formatDate
      });
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  List<CardVO>? cardVO;
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();
  late CardVO card;
  bool isLoading=false;
  @override
  void initState() {
    movieBookingModel.getProfileFromDataBase().listen((user) {
      setState(() {
        cardVO = user?.cards;
      });
    },
      onError: (error)=>print(error)
    );
    // movieBookingModel
    //     .getProfile(movieBookingModel.getToken() ?? '')
    //     .then((user) {
    //   setState(() {
    //     cardVO = user?.cards;
    //   });
    // }).catchError((error) => print(error));

    card = cardVO?[0] ?? CardVO.normal();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButtonView(
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Visibility(
            visible: isLoading,
              child: Positioned.fill(
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black12.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator(),),
                  )
              )
          ),
          IgnorePointer(
            ignoring: isLoading,
           child : Align(
                alignment: Alignment.topCenter,
                child: cardVO?.isEmpty??true?const Center(child: CircularProgressIndicator(),):PaymentMethodSessionView(
                  onClick: () => _navigateToAddNewCardScreenView(context),
                  cardVO: cardVO ?? [],
                  totalPrice: widget.totalPrice,
                  saveCardVo: (obj) => saveCard(obj),
                )
           ),
          ),
          IgnorePointer(
            ignoring: isLoading,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: medium_large_2x),
                child: ButtonWidget(
                    onClick: () => _navigateToTicketScreenView(context),
                    child: ButtonTextView('Purchase')),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveCard(CardVO cardVO) {
    setState(() {
      card = cardVO;
    });
  }

  void _navigateToTicketScreenView(context) {
    if (card.cardNumber != null) {
      setState(() {
        isLoading=true;
      });
      DateTime bookingDateConvert = DateTime.parse(widget.bookingDate);
      String date =
          '${bookingDateConvert.year}-${bookingDateConvert.month}-${bookingDateConvert.day}';
      CheckOutRawResponse checkOutRawResponse = CheckOutRawResponse(
          widget.timeSlotsVO.cinemaDayTimeSlotID,
          widget.row,
          widget.seats,
          date,
          widget.totalPrice,
          widget.movieVO.id,
          card.id,
          widget.dayTimeSlotVO.cinemaID,
          widget.snackList);
      movieBookingModel.checkout(movieBookingModel.getToken()??'', checkOutRawResponse).then((checkOut) {
        setState(() {
          isLoading=false;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return CheckoutScreen(
            checkoutVO: checkOut??CheckoutVO.normal(),
            dayTimeSlotVO: widget.dayTimeSlotVO,
            formatDate: widget.formatDate,
            movieVO: widget.movieVO,
          );
        }));
      });

    }
  }

  void _navigateToAddNewCardScreenView(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const AddNewCardScreen();
    })
    );
  }
}

class PaymentMethodSessionView extends StatelessWidget {
  final Function onClick;
  final List<CardVO> cardVO;
  final int totalPrice;
  final Function(CardVO) saveCardVo;
  PaymentMethodSessionView(
      {required this.onClick,
      required this.cardVO,
      required this.totalPrice,
      required this.saveCardVo});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
            child: PaymentTitleAndAmountSession(totalPrice),
          ),
          const SizedBox(
            height: margin_medium,
          ),
          cardVO.isEmpty
              ? const Center(child: Text('No Card'))
              : CarouselSliderView(
                  cardVO: cardVO,
                  saveCardVo: (obj) => saveCardVo(obj),
                ),
          const SizedBox(
            height: margin_medium,
          ),
          AddNewCardSessionView(onClick: onClick)
        ],
      ),
    );
  }
}

class AddNewCardSessionView extends StatelessWidget {
  const AddNewCardSessionView({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final Function onClick;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        onPressed: () => onClick(),
        child: Row(
          children: const [
            Icon(
              Icons.add_circle,
              color: Colors.green,
            ),
            SizedBox(
              width: spacing_micro_1x,
            ),
            Text(
              'Add new card',
              style: TextStyle(fontSize: text_medium, color: Colors.green),
            )
          ],
        ));
  }
}

class VisaCardSessionView extends StatelessWidget {
  final CardVO cardVO;

  VisaCardSessionView(this.cardVO);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(margin_small_2x),
      width: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(border_radius_size),
        color: visa_card_color,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: VisaImageView(cardVO.cardType.toString()),
          ),
          const Align(alignment: Alignment.topRight, child: VisaMenuDotView()),
          Align(
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: VisaStarView(),
                  ),
                  Expanded(
                    child: VisaStarView(),
                  ),
                  Expanded(
                    child: VisaStarView(),
                  ),
                  VisaLastPasswordView(cardVO.cardNumber.toString()),
                ],
              )),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                CardOwnerAndExpreSessionView(
                    card_holder, cardVO.cardHolder.toString()),
                const Spacer(),
                CardOwnerAndExpreSessionView(
                  expire,
                  cardVO.expirationDate.toString(),
                  isCrossAxisEnd: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CarouselSliderView extends StatelessWidget {
  final List<CardVO> cardVO;
  final Function(CardVO) saveCardVo;
  CarouselSliderView({required this.cardVO, required this.saveCardVo});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: cardVO.length,
        itemBuilder: (BuildContext context, int index, int pageViewIndex) {
          return VisaCardSessionView(cardVO[index]);
        },
        options: CarouselOptions(
          onPageChanged: (pageIndex, reason) {
            saveCardVo(cardVO[pageIndex]);
          },
          height: carouselSliderHeight,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          enableInfiniteScroll: false,
        ));
  }
}

class CardOwnerAndExpreSessionView extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isCrossAxisEnd;
  CardOwnerAndExpreSessionView(this.title, this.subTitle,
      {this.isCrossAxisEnd = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          isCrossAxisEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style:
              const TextStyle(color: Colors.white54, fontSize: text_medium_1x),
        ),
        const SizedBox(
          height: margin_small,
        ),
        Text(
          subTitle,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: text_medium_1x),
        ),
      ],
    );
  }
}

class VisaLastPasswordView extends StatelessWidget {
  final String cardNumber;

  VisaLastPasswordView(this.cardNumber);

  @override
  Widget build(BuildContext context) {
    return Text(
      cardNumber.substring(cardNumber.length - 4),
      style: const TextStyle(fontSize: text_large, color: Colors.white),
    );
  }
}

class VisaStarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          '*',
          style: TextStyle(fontSize: text_large, color: Colors.white),
        ),
        SizedBox(
          width: margin_small,
        ),
        Text(
          '*',
          style: TextStyle(fontSize: text_large, color: Colors.white),
        ),
        SizedBox(
          width: margin_small,
        ),
        Text(
          '*',
          style: TextStyle(fontSize: text_large, color: Colors.white),
        ),
        SizedBox(
          width: margin_small,
        ),
        Text(
          '*',
          style: TextStyle(fontSize: text_large, color: Colors.white),
        ),
      ],
    );
  }
}

class VisaMenuDotView extends StatelessWidget {
  const VisaMenuDotView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      '●●●',
      style: TextStyle(color: Colors.white),
    );
  }
}

class VisaImageView extends StatelessWidget {
  final String name;

  VisaImageView(this.name);
  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        color: white_color,
        fontSize: regular_text,
      ),
    );
  }
}

class PaymentTitleAndAmountSession extends StatelessWidget {
  final int totalPrice;

  PaymentTitleAndAmountSession(this.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          payment_amount,
          style: TextStyle(color: Colors.black26, fontSize: regular_text_1x),
        ),
        const SizedBox(height: spacing_micro_1x),
        Text(
          '\$ $totalPrice',
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: text_large_2x),
        ),
      ],
    );
  }
}
