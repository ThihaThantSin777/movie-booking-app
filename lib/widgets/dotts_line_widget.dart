import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';

class DottsLineSessionView extends StatelessWidget {
  const DottsLineSessionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: margin_small_2x),
      child: const DottedLine(
        direction: Axis.horizontal,
        lineLength: double.infinity,
        lineThickness: 1.0,
        dashLength: seat_dot_length,
        dashColor: movie_seat_dash_color,
        dashGapColor: Colors.transparent,
      ),
    );
  }
}
