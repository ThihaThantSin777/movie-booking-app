import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/snack_and_payment_vo/snack_and_payment_vo.dart';
import 'package:movie_booking_app/page/payment_screen.dart';
import 'package:movie_booking_app/persistance/daos/user_dao.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/back_button_widget.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/widgets/header_title.dart';
import 'package:movie_booking_app/widgets/textfield_input_widget.dart';

import '../data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import '../data/vos/day_timeslot_vo/time_slots_vo.dart';
import '../data/vos/movie_vo/movie_vo.dart';

class SnackAndPayMentScreen extends StatefulWidget {
  final int subPrice;
  final DayTimeSlotVO dayTimeSlotVO;
  final TimeSlotsVO timeSlotsVO;
  final String bookingDate;
  final String formatDate;
  final MovieVO movieVO;
  final String row;
  final String seat;
  SnackAndPayMentScreen(
      {required this.subPrice,
      required this.dayTimeSlotVO,
      required this.timeSlotsVO,
      required this.bookingDate,
      required this.movieVO,
      required this.row,
      required this.seat,
      required this.formatDate});

  @override
  State<SnackAndPayMentScreen> createState() => _SnackAndPayMentScreenState();
}

class _SnackAndPayMentScreenState extends State<SnackAndPayMentScreen> {
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();
  List<SnackAndPaymentVO>? snackList;
  List<SnackAndPaymentVO>? paymentMethodsList;
  int totalPrice = 0;
  @override
  void initState() {
    totalPrice = widget.subPrice;
    movieBookingModel.getSnackListFromDataBase(movieBookingModel.getToken()?? '').listen((snackList) {
      setState(() {
        this.snackList=snackList;
      });
    },
      onError: (error)=>print(error)
    );


    movieBookingModel.getPaymentListFromDataBase(movieBookingModel.getToken()?? '').listen((payments) {
      setState(() {
        paymentMethodsList = payments;
      });
    },
      onError: (error)=>print(error)
    );

    super.initState();
  }

  void paymentSelect(SnackAndPaymentVO snackAndPaymentVO) {
    setState(() {
      paymentMethodsList?.forEach((element) {
        if (element == snackAndPaymentVO) {
          element.isSelect = true;
        } else {
          element.isSelect = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButtonView(
            color: Colors.black,
          )),
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(margin_small_2x),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    snackList?.isEmpty ?? true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ComboAndPaymentSessionView(
                            snackList: snackList ?? [],
                            increse: (obj) => increase(obj),
                            decrease: (obj) => decrese(obj),
                          ),
                    TextFieldPromoCodeSessionView(
                      subTotal: totalPrice,
                    ),
                    const SizedBox(
                      height: margin_medium_3x,
                    ),
                    paymentMethodsList?.isEmpty ?? true
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : PaymentSessionView(
                            paymentMethodsList: paymentMethodsList ?? [],
                            onTap: (obj) => paymentSelect(obj),
                          )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: medium_large_2x),
              child: ButtonWidget(
                  onClick: () => _navigateToPaymentScreenView(context),
                  child: ButtonTextView('Pay \$$totalPrice')),
            ),
          ),
        ],
      ),
    );
  }

  void increase(SnackAndPaymentVO snackVO) {
    setState(() {
      snackList?.forEach((element) {
        if (snackVO == element) {
          element.quantity++;
          totalPrice += element.price ?? 0;
        }
      });
    });
  }

  void decrese(SnackAndPaymentVO snackVO) {
    setState(() {
      snackList?.forEach((element) {
        if (snackVO == element) {
          if (element.quantity != 0) {
            element.quantity--;
            totalPrice -= element.price ?? 0;
          }
        }
      });
    });
  }

  void _navigateToPaymentScreenView(context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return PaymentScreen(
        totalPrice: totalPrice,
        dayTimeSlotVO: widget.dayTimeSlotVO,
        timeSlotsVO: widget.timeSlotsVO,
        bookingDate: widget.bookingDate,
        snackList: snackList ?? [],
        movieVO: widget.movieVO,
        row: widget.row,
        seats: widget.seat,
        formatDate: widget.formatDate,
      );
    }));
  }
}

class ComboAndPaymentSessionView extends StatelessWidget {
  final List<SnackAndPaymentVO> snackList;
  final Function(SnackAndPaymentVO) increse;
  final Function(SnackAndPaymentVO) decrease;
  ComboAndPaymentSessionView(
      {required this.snackList, required this.increse, required this.decrease});
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => ComboSetSessionView(
            snack: snackList[index],
            increse: (obj) => increse(obj),
            decrease: (obj) => decrease(obj)),
        separatorBuilder: (context, index) =>
            const SizedBox(height: margin_medium),
        itemCount: snackList.length);
  }
}

class PaymentSessionView extends StatelessWidget {
  final List<SnackAndPaymentVO> paymentMethodsList;
  final Function(SnackAndPaymentVO) onTap;
  PaymentSessionView({required this.paymentMethodsList, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PayMentHeaderView(),
        Column(
            mainAxisSize: MainAxisSize.min,
            children: paymentMethodsList
                .map((payment) => PayMentMethodView(
                      snackAndPaymentVO: payment,
                      payMentIcon: const Icon(Icons.credit_card),
                      onTap: (obj) => onTap(obj),
                    ))
                .toList()),
        const SizedBox(height: margin_large),
      ],
    );
  }
}

class PayMentMethodView extends StatelessWidget {
  final SnackAndPaymentVO snackAndPaymentVO;
  final Icon payMentIcon;
  final Function(SnackAndPaymentVO) onTap;
  PayMentMethodView(
      {required this.snackAndPaymentVO,
      required this.payMentIcon,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: snackAndPaymentVO.isSelect,
      tileColor: snackAndPaymentVO.isSelect ? main_screen_color : white_color,
      onTap: () => onTap(snackAndPaymentVO),
      contentPadding: const EdgeInsets.all(0),
      leading: payMentIcon,
      title: Text(
        snackAndPaymentVO.name.toString(),
        style: const TextStyle(
          fontSize: regular_text_1x,
        ),
      ),
      subtitle: Text(
        snackAndPaymentVO.description.toString(),
        style: const TextStyle(
          fontSize: text_medium,
        ),
      ),
    );
  }
}

class PayMentHeaderView extends StatelessWidget {
  const PayMentHeaderView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HeaderTitle(
        title: payment_method,
        fontSize: regular_text_1x,
        fontWeight: FontWeight.bold);
  }
}

class TextFieldPromoCodeSessionView extends StatelessWidget {
  final int subTotal;

  TextFieldPromoCodeSessionView({required this.subTotal});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldView(
          'Enter promo code',
          isPadding: false,
          isHintTextItalic: true,
          isShowTitle: false,
        ),
        const SizedBox(
          height: margin_small_3x,
        ),
        const PromoCodeGetSessionView(),
        const SizedBox(
          height: margin_medium_2x,
        ),
        SubTotalView(
          subTotal: subTotal,
        )
      ],
    );
  }
}

class SubTotalView extends StatelessWidget {
  final int subTotal;

  SubTotalView({required this.subTotal});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sub Total: $subTotal\$',
      style: const TextStyle(
          fontSize: regular_text_1x,
          color: Colors.cyan,
          fontWeight: FontWeight.w600),
    );
  }
}

class PromoCodeGetSessionView extends StatelessWidget {
  const PromoCodeGetSessionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text(
          'Dont have any promo code ? ',
          style: TextStyle(fontSize: text_medium_2x, color: Colors.black26),
        ),
        Text(
          'Get it now',
          style:
              TextStyle(fontSize: text_medium_2x, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class ComboSetSessionView extends StatelessWidget {
  final SnackAndPaymentVO snack;
  final Function(SnackAndPaymentVO) increse;
  final Function(SnackAndPaymentVO) decrease;
  ComboSetSessionView(
      {required this.snack, required this.increse, required this.decrease});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ComboSetAndPriceView(
          title: snack.name.toString(),
          price: int.parse(snack.price.toString()),
        ),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        ComboSetSubTitleAndQuantityView(
          snack: snack,
          increse: (obj) => increse(obj),
          decrease: (obj) => decrease(obj),
        )
      ],
    );
  }
}

class ComboSetSubTitleAndQuantityView extends StatelessWidget {
  final SnackAndPaymentVO snack;
  final Function(SnackAndPaymentVO) increse;
  final Function(SnackAndPaymentVO) decrease;
  ComboSetSubTitleAndQuantityView(
      {required this.snack, required this.increse, required this.decrease});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ComboSubTitleView(snack.description.toString()),
        const Spacer(),
        QunatityBoxView(
          snack: snack,
          increse: (obj) => increse(obj),
          decrease: (obj) => decrease(obj),
        )
      ],
    );
  }
}

class QunatityBoxView extends StatelessWidget {
  final SnackAndPaymentVO snack;
  final Function(SnackAndPaymentVO) increse;
  final Function(SnackAndPaymentVO) decrease;
  QunatityBoxView(
      {required this.snack, required this.increse, required this.decrease});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: quantity_width,
      height: quantity_height,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(border_radius_size)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => decrease(snack),
              child: const Text(
                '-',
                style: TextStyle(
                    fontSize: text_medium, fontWeight: FontWeight.bold),
              ),
            ),
            Container(width: 1, color: Colors.black26),
            Text(
              snack.quantity.toString(),
              style: const TextStyle(
                  fontSize: regular_text_1x, color: Colors.black26),
            ),
            Container(width: 1, color: Colors.black26),
            GestureDetector(
              onTap: () => increse(snack),
              child: const Text(
                '+',
                style: TextStyle(
                    fontSize: text_medium, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ComboSubTitleView extends StatelessWidget {
  String description;
  ComboSubTitleView(this.description);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: sub_title_of_snack_container_width,
      child: Text(
        description,
        style: const TextStyle(fontSize: text_medium_1x, color: Colors.black26),
      ),
    );
  }
}

class ComboSetAndPriceView extends StatelessWidget {
  final String title;
  final int price;

  ComboSetAndPriceView({required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title',
          style: const TextStyle(fontSize: regular_text_1x),
        ),
        const Spacer(),
        Container(
          margin: const EdgeInsets.only(right: qunatity_right_margin),
          child: Text(
            '$price\$',
            style: const TextStyle(fontSize: regular_text_1x),
          ),
        ),
      ],
    );
  }
}
