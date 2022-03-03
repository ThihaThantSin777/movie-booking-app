import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimension.dart';

class BackButtonView extends StatelessWidget {
  const BackButtonView({
    Key? key,
    this.color = Colors.white,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.chevron_left,
          color: color,
          size: back_button_size,
        ));
  }
}
