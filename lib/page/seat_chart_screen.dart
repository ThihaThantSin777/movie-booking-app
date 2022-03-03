import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/data/vos/seating_plan_vo/seating_type_vo.dart';
import 'package:movie_booking_app/page/snack_and_payment_screen.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:movie_booking_app/widgets/back_button_widget.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/widgets/dotts_line_widget.dart';

class SeatingTicketScreen extends StatefulWidget {
  final DayTimeSlotVO dayTimeSlotVO;
  final TimeSlotsVO timeSlotsVO;
  String date;
  final MovieVO movieVO;
  SeatingTicketScreen(
      {required this.dayTimeSlotVO,
      required this.timeSlotsVO,
      required this.date,
      required this.movieVO});

  @override
  State<SeatingTicketScreen> createState() => _SeatingTicketScreenState();
}

class _SeatingTicketScreenState extends State<SeatingTicketScreen> {
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();
  List<SeatinTypeVO>? seatTypeVO;
  int seatCount = 0;
  String selectSeatName = "";
  int price = 0;
  List<String> selectSeats = [];
  String dateTemp = '';
  @override
  void initState() {
    dateTemp = widget.date;
    DateTime dateTime = DateTime.parse(dateTemp);
    widget.date =
        '${DateFormat('EEEE, dd, MMM').format(dateTime)} , ${widget.timeSlotsVO.startTime ?? ""}';
    movieBookingModel
        .getSeatingTypeList(widget.timeSlotsVO.cinemaDayTimeSlotID ?? 0,
            dateTemp, movieBookingModel.getToken()?? '')
        .then((value) {
      setState(() {
        seatTypeVO = value;
      });
    }).catchError((error) => print(error));
    super.initState();
  }

  void _selectSeat(SeatinTypeVO seatVO) {
    setState(() {
      seatTypeVO?.forEach((element) {
        if (element == seatVO) {
          element.isSelect = !element.isSelect;
          if (element.isSelect) {
            seatCount++;
            selectSeats.add(element.seatName ?? '');
            price += element.price ?? 0;
          } else {
            seatCount--;
            selectSeats.remove(element.seatName ?? '');
            price -= element.price ?? 0;
          }
        }
      });
      selectSeatName = selectSeats.join(',');
    });
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
        body: seatTypeVO?.isEmpty ?? true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: double.infinity,
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: SingleChildScrollView(
                      child: MovieSeatGridSessionView(
                    onClick: () => _navigateToSnackScreenView(context),
                    movieTitle: widget.movieVO.originalTitle ?? '',
                    cinemaName: widget.dayTimeSlotVO.cinema.toString(),
                    startTime: widget.timeSlotsVO.startTime.toString(),
                    dateTime: widget.date,
                    seatsList: seatTypeVO ?? [],
                    seatCount: seatCount,
                    onTap: (obj) => _selectSeat(obj),
                    selectSeatName: selectSeatName,
                    price: price,
                  )),
                ),
              ));
  }

  _showALertBox(context, String message, String subMessage) async {
    bool status = await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(message),
            content: Text(subMessage),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(message == 'Error' ? false : true);
                  },
                  child: const Text('OK'))
            ],
          );
        });
  }

  void _navigateToSnackScreenView(context) {
    SeatinTypeVO? seatVO;
    List<String> listRow = [];
    List<String> listSeats = [];
    String row = '';
    String seats = '';

    String message = '';
    seatTypeVO?.forEach((element1) {
      if (element1.isSelect) {
        message = 'Success';
        listRow.add(element1.symbol.toString());
        listSeats.add(element1.seatName.toString());
      }
    });
    if (message.isEmpty) {
      _showALertBox(context, 'Error', 'Please choose one seats');
    } else {
      row = listRow.join(',');
      seats = listSeats.join(',');
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SnackAndPayMentScreen(
          subPrice: price,
          dayTimeSlotVO: widget.dayTimeSlotVO,
          timeSlotsVO: widget.timeSlotsVO,
          bookingDate: dateTemp,
          movieVO: widget.movieVO,
          row: row,
          seat: seats,
          formatDate: widget.date,
        );
      }));
    }
  }
}

class MovieSeatGridSessionView extends StatelessWidget {
  final Function onClick;
  final String movieTitle;
  final String cinemaName;
  final String startTime;
  final String dateTime;
  final Function(SeatinTypeVO) onTap;
  final List<SeatinTypeVO> seatsList;
  final int seatCount;
  final String selectSeatName;
  final int price;
  MovieSeatGridSessionView(
      {required this.onClick,
      required this.movieTitle,
      required this.cinemaName,
      required this.startTime,
      required this.dateTime,
      required this.seatsList,
      required this.onTap,
      required this.seatCount,
      required this.selectSeatName,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieNameTimeAndCinemaSessionView(
            movieName: movieTitle,
            cinemaName: cinemaName,
            startTime: startTime,
            dateTime: dateTime),
        const SizedBox(
          height: margin_large,
        ),
        MovieSeatSessionView(
          seatsList: seatsList,
          onTap: (obj) => onTap(obj),
        ),
        const SizedBox(
          height: margin_small_3x,
        ),
        const MovieSeatGlossySessionView(),
        const SizedBox(
          height: margin_small_3x,
        ),
        const DottsLineSessionView(),
        const SizedBox(
          height: margin_small_3x,
        ),
        MovieTicketAndSeatSessionView(
          seatCount: seatCount,
          seatName: selectSeatName,
        ),
        const SizedBox(
          height: margin_medium_3x,
        ),
        ButtonWidget(
            onClick: () => onClick(),
            child: ButtonTextView('Buy Ticket for \$$price'))
      ],
    );
  }
}

class MovieTicketAndSeatSessionView extends StatelessWidget {
  final int seatCount;
  final String seatName;
  MovieTicketAndSeatSessionView(
      {required this.seatCount, required this.seatName});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
      child: Column(
        children: [
          MovieTicketAndSeatView(seat_tickets, seatCount.toString()),
          const SizedBox(
            height: margin_small_3x,
          ),
          MovieTicketAndSeatView(seat, seatName),
        ],
      ),
    );
  }
}

class MovieTicketAndSeatView extends StatelessWidget {
  final String firstText;
  final String secindText;

  MovieTicketAndSeatView(this.firstText, this.secindText);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        firstText,
        style: const TextStyle(
          fontSize: text_medium_1x,
          color: Colors.black26,
        ),
      ),
      const Spacer(),
      Text(
        secindText,
        style: const TextStyle(
          fontSize: text_medium_1x,
          color: Colors.black54,
        ),
      ),
    ]);
  }
}

class MovieSeatGlossySessionView extends StatelessWidget {
  const MovieSeatGlossySessionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: MovieSeatGlossyView(seat_type_available, available_color)),
          Expanded(
              flex: 1,
              child: MovieSeatGlossyView(seat_type_taken, taken_color)),
          Expanded(
              flex: 1,
              child:
                  MovieSeatGlossyView(seat_type_selection, main_screen_color)),
        ],
      ),
    );
  }
}

class MovieSeatGlossyView extends StatelessWidget {
  MovieSeatGlossyView(this.text, this.backgroundColor);
  final String text;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: seat_glossy_circle_radius,
          backgroundColor: backgroundColor,
        ),
        const SizedBox(
          width: spacing_micro_1x,
        ),
        Text(
          text,
          style: const TextStyle(fontSize: text_small, color: Colors.black45),
        )
      ],
    );
  }
}

class MovieSeatSessionView extends StatelessWidget {
  final Function(SeatinTypeVO) onTap;

  final List<SeatinTypeVO> seatsList;
  MovieSeatSessionView({required this.seatsList, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: seatsList.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cross_axis_count,
          childAspectRatio: child_aspect_ratio,
        ),
        itemBuilder: (context, index) {
          return MovieSeatView(
            seatVO: seatsList[index],
            onTap: (obj) => onTap(obj),
          );
        });
  }
}

class MovieSeatView extends StatelessWidget {
  final SeatinTypeVO seatVO;
  final Function(SeatinTypeVO) onTap;
  MovieSeatView({required this.seatVO, required this.onTap});

  String text() {

    if (seatVO.type == 'space') {
      return '';
    }
    if (seatVO.seatName.toString().isEmpty) {
      return seatVO.symbol.toString();
    }
    if(seatVO.isSelect){
      if(seatVO.seatName?.isNotEmpty??false){
        return seatVO.seatName?.split('-')[1]??'';
      }

    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => seatVO.type == 'available' ? onTap(seatVO) : null,
      child: Container(
        margin: const EdgeInsets.symmetric(
            horizontal: seat_view_margin, vertical: seat_view_margin),
        decoration: BoxDecoration(
          color: seatVO.isSelect ? main_screen_color : _getSeatColor(seatVO),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(border_seat_view),
            topRight: Radius.circular(border_seat_view),
          ),
        ),
        child: Center(
          child: Text(
            text(),
            style:
                TextStyle(color: seatVO.isSelect ? white_color : black_color),
          ),
        ),
      ),
    );
  }

  Color _getSeatColor(SeatinTypeVO seatinTypeVO) {
    if (seatinTypeVO.type == 'available') {
      return available_color;
    } else if (seatinTypeVO.type == 'taken') {
      return taken_color;
    }

    return Colors.white;
  }
}

class MovieNameTimeAndCinemaSessionView extends StatelessWidget {
  final String movieName;
  final String cinemaName;
  final String startTime;
  final String dateTime;

  MovieNameTimeAndCinemaSessionView(
      {required this.movieName,
      required this.cinemaName,
      required this.startTime,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MovieNameTimeAndCinemaTextView(
          text: movieName,
          fontSize: regular_text_1x,
        ),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        MovieNameTimeAndCinemaTextView(
          text: cinemaName,
          fontSize: text_medium,
          color: Colors.black38,
          fontWeight: FontWeight.w400,
        ),
        const SizedBox(
          height: spacing_micro_1x,
        ),
        MovieNameTimeAndCinemaTextView(
          text: dateTime,
          fontSize: text_medium,
          color: Colors.black87,
          fontWeight: FontWeight.w400,
        ),
      ],
    );
  }
}

class MovieNameTimeAndCinemaTextView extends StatelessWidget {
  MovieNameTimeAndCinemaTextView(
      {required this.text,
      required this.fontSize,
      this.fontWeight = FontWeight.bold,
      this.color = Colors.black});
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }
}
