import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimension.dart';

import '../network/api_constant/api_constant.dart';

class ButtonWidget extends StatelessWidget {
  final bool isGhostButton;
  final Function onClick;
  final Widget child;
  final Color backgroundColor;
  final Color borderColor;

  ButtonWidget(
      {this.isGhostButton = false,
      required this.onClick,
      required this.child,
      this.backgroundColor = main_screen_color,
      this.borderColor = Colors.white70});
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        splashColor: Colors.white,
        minWidth: MediaQuery.of(context).size.width / 1.1,
        height: button_height,
        color: backgroundColor,
        shape: isGhostButton
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border_radius_size),
                side: BorderSide(
                  color: borderColor,
                ))
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(border_radius_size),
                side: const BorderSide(
                  color: Colors.transparent,
                )),
        onPressed: () {
          onClick();
        },
        child: child

    );
  }
}
