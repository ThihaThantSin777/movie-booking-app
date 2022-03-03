import 'package:flutter/material.dart';
import 'package:movie_booking_app/page/login_sigin_screen.dart';
import 'package:movie_booking_app/widgets/button_text_widget.dart';
import 'package:movie_booking_app/widgets/button_widget.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const StartScreenImageView(),
            const SizedBox(
              height: margin_medium,
            ),
            const StartTilteAnsSubTitleView(),
            const SizedBox(
              height: start_screen_space_large,
            ),
            StartgetStartButtonView(() => _navigateToLoginSigninView(context))
          ],
        ),
      ),
    );
  }

  _navigateToLoginSigninView(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const LoginSiginScreen();
    }));
  }
}

class StartgetStartButtonView extends StatelessWidget {
  Function onClick;
  StartgetStartButtonView(this.onClick);
  @override
  Widget build(BuildContext context) {
    return ButtonWidget(
      onClick: () => onClick(),
      child: ButtonTextView(button_get_start),
      isGhostButton: true,
    );
  }
}

class StartTilteAnsSubTitleView extends StatelessWidget {
  const StartTilteAnsSubTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          main_screen_welcome_title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: regular_text_2x),
        ),
        Text(
          main_screen_welcome_sub_title,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: text_medium_1x),
        ),
      ],
    );
  }
}

class StartScreenImageView extends StatelessWidget {
  const StartScreenImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset('images/logo.PNG');
  }
}
