import 'package:flutter/material.dart';

class HeaderTitle extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;

  HeaderTitle(
      {required this.title, required this.fontSize, required this.fontWeight});
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
