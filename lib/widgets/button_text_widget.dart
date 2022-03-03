import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimension.dart';

class ButtonTextView extends StatelessWidget {
  final String text;

  ButtonTextView(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: text_medium),
    );
  }
}
