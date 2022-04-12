import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/bloc/pick_time_and_cinema_bloc.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/day_timeslot_vo.dart';
import 'package:movie_booking_app/data/vos/day_timeslot_vo/time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/movie_vo/movie_vo.dart';
import 'package:movie_booking_app/page/seat_chart_screen.dart';

import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/widgets/back_button_widget.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/widgets/header_title.dart';
import 'package:provider/provider.dart';

class PickTimeAndCinema extends StatelessWidget {
  final MovieVO movieVO;

  PickTimeAndCinema({required this.movieVO});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PickTimeAndCinemaBloc(movieVO.id ?? 0),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: main_screen_color,
            leading: const BackButtonView(),
          ),
          body: Container(
            child: Selector<PickTimeAndCinemaBloc, List<DayTimeSlotVO>?>(
              shouldRebuild: (previous, next) => previous != next,
              selector: (_, bloc) => bloc.getDayTimeSlotsVO,
              builder: (_, dayTimeSlots, child) => SingleChildScrollView(
                  child: dayTimeSlots?.isEmpty ?? true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      :
                      //Selector<PickTimeAndCinemaBloc, bool>(
                      //     selector: (_, bloc) => bloc.getRefreshStatus,
                      //     builder: (_, refresh, child) =>

                      Selector<PickTimeAndCinemaBloc, TimeSlotsVO?>(
                          selector: (_, bloc) => bloc.getTimeSlotsVO,
                          builder: (_, timeSLots, child) => Selector<
                                  PickTimeAndCinemaBloc, String>(
                              selector: (_, bloc) => bloc.getDateTime,
                              builder: (_, dateTime, child) => Selector<
                                      PickTimeAndCinemaBloc, DayTimeSlotVO?>(
                                    selector: (_, bloc) => bloc.getDaySlotsVO,
                                    builder: (_, daySlots, child) {
                                      PickTimeAndCinemaBloc
                                          pickTimeAndCinemaBloc =
                                          Provider.of(_, listen: false);
                                      return PickTimeCinemaSessionView(
                                        onClick: () {
                                          pickTimeAndCinemaBloc
                                              .checkIfDateIsSelectOrNot()
                                              .then((status) {
                                            _navigateToSeatScreenView(
                                              status: status,
                                              context: context,
                                              timeSlotsVO:
                                                  status?.subTimeSlots ??
                                                      TimeSlotsVO.normal(),
                                              dateTime: dateTime,
                                              dayTimeSlotVO: status ??
                                                  DayTimeSlotVO.normal(),
                                            );
                                          });
                                        },
                                        dayTimeSlotVO: dayTimeSlots ?? [],
                                        onDateChange: (date) =>
                                            pickTimeAndCinemaBloc.onDateChange(
                                                date, movieVO.id ?? 0),
                                        onTap: (timeSlots) =>
                                            pickTimeAndCinemaBloc
                                                .selectTimeSlot(timeSlots),
                                      );
                                    },
                                  )))),
            ),
          ),
        )
        //),
        );
  }

  void _onDateChange(date) {
    // String tempDate = '${date.year}-${date.month}-${date.day}';
    // setState(() {
    //   dateTime = date.toString();
    //   this.date = date.toString().substring(0, 10);
    //   movieBookingModel
    //       .getDayTimeSlotsListFromDataBase(widget.movieVO.id ?? 0,
    //           movieBookingModel.getToken() ?? '', tempDate)
    //       .listen((value) {
    //     setState(() {
    //       daytimeSlotVOList = value?.daytimeSlotVOList ?? [];
    //     });
    //   }, onError: (error) => print(error));
    //   daytimeSlotVOList?.forEach((element1) {
    //     element1.timeSlots?.forEach((element2) {
    //       element2.isSelect = false;
    //     });
    //   });
    // });
  }

  void _selectTimeSlot(TimeSlotsVO timeSlotsVO) {
    // setState(() {
    //   daytimeSlotVOList?.forEach((element1) {
    //     element1.timeSlots?.forEach((element2) {
    //       if (element2 == timeSlotsVO) {
    //         element2.isSelect = true;
    //       } else {
    //         element2.isSelect = false;
    //       }
    //     });
    //   });
    // });
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

  void _navigateToSeatScreenView(
      {required DayTimeSlotVO? status,
      required BuildContext context,
      required TimeSlotsVO timeSlotsVO,
      required String dateTime,
      required DayTimeSlotVO dayTimeSlotVO}) {
    if (status == null) {
      _showALertBox(context, 'Error', 'Please choose one timeslots');
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SeatingTicketScreen(
          dayTimeSlotVO: dayTimeSlotVO,
          timeSlotsVO: timeSlotsVO,
          date: dateTime,
          movieVO: movieVO,
        );
      }));
    }
  }
}

class PickTimeCinemaSessionView extends StatelessWidget {
  final Function onClick;
  final List<DayTimeSlotVO> dayTimeSlotVO;
  final Function(DateTime) onDateChange;
  final Function(TimeSlotsVO) onTap;

  PickTimeCinemaSessionView(
      {required this.onClick,
      required this.dayTimeSlotVO,
      required this.onDateChange,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieChooseDateView(
            onDateChange: (date) => onDateChange(date),
          ),
          dayTimeSlotVO.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ChooseItemGridSession(
                  dayTimeSlotVO: dayTimeSlotVO,
                  onTap: (obj) => onTap(obj),
                ),
          const SizedBox(
            height: margin_medium_2x,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: margin_small_2x),
            child: Padding(
              padding: const EdgeInsets.only(bottom: medium_large_2x),
              child: ButtonWidget(
                  onClick: () => onClick(), child: ButtonTextView('Next')),
            ),
          )
        ],
      ),
    );
  }
}

class ChooseItemGridSession extends StatelessWidget {
  ChooseItemGridSession({required this.dayTimeSlotVO, required this.onTap});

  final List<DayTimeSlotVO> dayTimeSlotVO;
  final Function(TimeSlotsVO) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.65,
        padding: const EdgeInsets.only(
            top: margin_medium, left: margin_medium, right: margin_medium),
        color: Colors.white,
        child: ListView.separated(
            itemBuilder: (context, index) => ChooseItemGridView(
                  dayTimeSlotVO: dayTimeSlotVO[index],
                  onTap: (obj) => onTap(obj),
                ),
            separatorBuilder: (context, index) => const SizedBox(
                  height: margin_medium,
                ),
            itemCount: dayTimeSlotVO.length));
  }
}

class ChooseItemGridView extends StatelessWidget {
  final DayTimeSlotVO dayTimeSlotVO;
  final Function(TimeSlotsVO) onTap;

  ChooseItemGridView({required this.dayTimeSlotVO, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: spacing_micro_1x,
        ),
        HeaderTitle(
            title: dayTimeSlotVO.cinema ?? '',
            fontSize: regular_text,
            fontWeight: FontWeight.w700),
        const SizedBox(
          height: margin_small_3x,
        ),
        CinemaSeatGridSessionView(
          timeSlotVO: dayTimeSlotVO.timeSlots ?? [],
          onTap: (obj) => onTap(obj),
        )
      ],
    );
  }
}

class CinemaSeatGridSessionView extends StatelessWidget {
  final List<TimeSlotsVO> timeSlotVO;
  final Function(TimeSlotsVO) onTap;

  CinemaSeatGridSessionView({required this.timeSlotVO, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2,
        ),
        itemCount: timeSlotVO.length,
        itemBuilder: (context, index) {
          return MovieSeatDetailsView(
            timeSlotsVO: timeSlotVO[index],
            onTap: (obj) => onTap(obj),
          );
        });
  }
}

class MovieSeatDetailsView extends StatelessWidget {
  final TimeSlotsVO timeSlotsVO;
  final Function(TimeSlotsVO) onTap;

  MovieSeatDetailsView({required this.timeSlotsVO, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap(timeSlotsVO);
        },
        child: Container(
          margin: const EdgeInsets.only(
              left: margin_small_2x,
              right: margin_small_2x,
              top: margin_small_2x),
          decoration: BoxDecoration(
            color:
                timeSlotsVO.isSelect ? main_screen_color : Colors.transparent,
            borderRadius: BorderRadius.circular(border_radius_size),
            border: Border.all(
              color: timeSlotsVO.isSelect ? white_color : Colors.grey,
              width: 1,
            ),
          ),
          child: Center(
              child: Text(
            timeSlotsVO.startTime.toString(),
            style: TextStyle(
                color: timeSlotsVO.isSelect ? white_color : Colors.black),
          )),
        ));
  }
}

class MovieChooseDateView extends StatelessWidget {
  Function(DateTime) onDateChange;

  MovieChooseDateView({required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: shoose_movie_and_time_height,
      color: main_screen_color,
      child: CinemaDateChooseSessionView(
        onDateChange: (date) => onDateChange(date),
      ),
    );
  }
}

class CinemaDateChooseSessionView extends StatelessWidget {
  Function(DateTime) onDateChange;

  CinemaDateChooseSessionView({required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DatePicker(DateTime.now(),
            initialSelectedDate: DateTime.now(),
            selectionColor: main_screen_color,
            selectedTextColor: white_color,
            onDateChange: (date) => onDateChange(date)),
      ],
    );
  }
}
