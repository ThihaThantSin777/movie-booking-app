import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimension.dart';

class TextFieldView extends StatelessWidget {
  final String titleText;
  final bool isObscureText;
  final String hintText;
  final bool isShowTitle;
  final bool isHintTextItalic;
  final bool isPadding;

  TextFieldView(
    this.hintText, {
    this.titleText = '',
    this.isHintTextItalic = false,
    this.isObscureText = false,
    this.isShowTitle = true,
    this.isPadding = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: isShowTitle,
                child: TextFieldTitleView(titleText: titleText)),
            TextFieldPasswordView(
              isObscureText: isObscureText,
              hintText: hintText,
              isHintTextItalic: isHintTextItalic,
              isPadding: isPadding,
            ),
          ],
        ),
      ],
    );
  }
}

class TextFieldTitleView extends StatelessWidget {
  const TextFieldTitleView({
    Key? key,
    required this.titleText,
  }) : super(key: key);

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(color: Colors.black38, fontSize: text_medium_2x),
    );
  }
}

class TextFieldPasswordView extends StatelessWidget {
  TextFieldPasswordView(
      {required this.isObscureText,
      required this.hintText,
      required this.isHintTextItalic,
      required this.isPadding});

  final bool isObscureText;
  final String hintText;
  final bool isHintTextItalic;
  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
      },
      obscureText: isObscureText,
      obscuringCharacter: '●',
      style: const TextStyle(fontSize: text_medium_2x),
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontStyle: isHintTextItalic ? FontStyle.italic : FontStyle.normal,
              color: Colors.black26),
          contentPadding: isPadding
              ? const EdgeInsets.symmetric(horizontal: card_elevation)
              : const EdgeInsets.symmetric(horizontal: 0)),
    );
  }
}
