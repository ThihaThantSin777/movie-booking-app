import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/bloc/checkout_bloc.dart';
import 'package:movie_booking_app/data/vos/check_out_vo/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/page/home_screen.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:provider/provider.dart';

import '../network/api_constant/api_constant.dart';
import '../widgets/dotts_line_widget.dart';
import '../widgets/header_title.dart';

class CheckoutScreen extends StatelessWidget {
  final CheckoutVO checkoutVO;
  final MovieVO movieVO;
  final DayTimeSlotVO dayTimeSlotVO;
  final String formatDate;

  CheckoutScreen({
    required this.checkoutVO,
    required this.movieVO,
    required this.dayTimeSlotVO,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CheckOutBloc(checkoutVO, movieVO, dayTimeSlotVO, formatDate),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(
              top: medium_large_2x,
              right: margin_small_2x,
              left: margin_small_2x),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CloseIconView(() => _backToPayMentView(context)),
              const TicketTitleView(),
              const SizedBox(
                height: spacing_micro_1x,
              ),
              Selector<CheckOutBloc, CheckoutVO>(
                selector: (_, bloc) => bloc.getCheckoutVO,
                builder: (_, checkoutVO, child) =>
                    Selector<CheckOutBloc, MovieVO>(
                  selector: (_, bloc) => bloc.getMovieVO,
                  builder: (_, movieVO, child) =>
                      Selector<CheckOutBloc, DayTimeSlotVO>(
                    selector: (_, bloc) => bloc.getDayTimeSlotsVO,
                    builder: (_, dayTimeSlotVO, child) =>
                        Selector<CheckOutBloc, String>(
                      selector: (_, bloc) => bloc.getFormatDate,
                      builder: (_, formatDate, child) => TicketBodyView(
                        checkoutVO: checkoutVO,
                        movieVO: movieVO,
                        dayTimeSlotVO: dayTimeSlotVO,
                        dateFormat: formatDate,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _backToPayMentView(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return HomeScreen();
    }));
  }
}

class TicketBodyView extends StatelessWidget {
  final CheckoutVO checkoutVO;
  final MovieVO movieVO;
  final DayTimeSlotVO dayTimeSlotVO;
  final String dateFormat;

  TicketBodyView(
      {required this.checkoutVO,
      required this.movieVO,
      required this.dayTimeSlotVO,
      required this.dateFormat});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TicketImageSessionView('$BASE_IMAGE_URL${movieVO.posterPath}'),
          TicketMovieTitleTimeSessionView(movieVO),
          const DottsLineSessionView(),
          TicketMovieDetailsSessionView(
            checkoutVO: checkoutVO,
            dayTimeSlotVO: dayTimeSlotVO,
            dateFormat: dateFormat,
          ),
          const DottsLineSessionView(),
          const BarcodeSessionView(),
        ],
      ),
    );
  }
}

class BarcodeSessionView extends StatelessWidget {
  const BarcodeSessionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(top: margin_small),
        child: Container(
          margin: const EdgeInsets.only(top: margin_small),
          width: barcode_width,
          child: BarcodeWidget(
            barcode: Barcode.code128(),
            data: 'Ticket',
          ),
        ));
  }
}

class TicketMovieDetailsSessionView extends StatelessWidget {
  final CheckoutVO checkoutVO;
  final DayTimeSlotVO dayTimeSlotVO;
  final String dateFormat;

  TicketMovieDetailsSessionView(
      {required this.checkoutVO,
      required this.dayTimeSlotVO,
      required this.dateFormat});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TicketsDetailsSessionView(
            'Booking no', checkoutVO.bookingNo.toString()),
        Wrap(
          children: [TicketsDetailsSessionView('Showtime - Date', dateFormat)],
        ),
        TicketsDetailsSessionView('Therater', dayTimeSlotVO.cinema.toString()),
        TicketsDetailsSessionView('Screen', "2"),
        TicketsDetailsSessionView('Row', checkoutVO.row.toString()),
        TicketsDetailsSessionView('Seats', checkoutVO.seat.toString()),
        TicketsDetailsSessionView('Price', "\$${checkoutVO.total.toString()}"),
      ],
    );
  }
}

class TicketsDetailsSessionView extends StatelessWidget {
  final String type;
  final String subType;

  TicketsDetailsSessionView(this.type, this.subType);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: margin_small_2x, vertical: margin_small_2x),
      child: Row(
        children: [
          Text(
            type,
            style: const TextStyle(
                fontSize: text_medium_1x, color: Colors.black38),
          ),
          Spacer(),
          Text(
            subType,
            style:
                const TextStyle(fontSize: text_medium, color: Colors.black87),
          )
        ],
      ),
    );
  }
}

class TicketMovieTitleTimeSessionView extends StatelessWidget {
  final MovieVO movieVO;

  TicketMovieTitleTimeSessionView(this.movieVO);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: margin_small_2x, vertical: margin_small_2x),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              movieVO.originalTitle.toString(),
              style: const TextStyle(
                  fontSize: text_medium_2x, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: spacing_micro_1x,
            ),
            Text(
              '${movieVO.runtime}m IMAX',
              style: const TextStyle(
                  fontSize: text_medium_2x, color: Colors.black26),
            ),
          ],
        ));
  }
}

class TicketImageSessionView extends StatelessWidget {
  final String imageUrl;

  TicketImageSessionView(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ticket_image_height,
      width: ticket_image_width,
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class TicketTitleView extends StatelessWidget {
  const TicketTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderTitle(
              title: "Awesome!",
              fontSize: text_large_1x,
              fontWeight: FontWeight.w700),
          const Text(
            'This is your ticket',
            style: TextStyle(fontSize: text_medium, color: Colors.black45),
          )
        ],
      ),
    );
  }
}

class CloseIconView extends StatelessWidget {
  final Function onClick;

  CloseIconView(this.onClick);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.close,
        size: close_icon_size,
        color: Colors.black,
      ),
      onPressed: () => onClick(),
    );
  }
}
