import 'package:flutter/material.dart';

import '../resources/dimension.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    required this.title,
    required this.example,
    this.isObscureText = false,
    required this.controller,
    required this.validation,
  }) : super(key: key);
  final String title;
  final String example;
  final bool isObscureText;
  final TextEditingController controller;
  final Function(String?) validation;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:
              const TextStyle(color: Colors.black38, fontSize: text_medium_2x),
        ),
        TextFormField(
          key: key,
          controller: controller,
          validator: (str) => validation(str),
          obscureText: isObscureText,
          obscuringCharacter: '●',
          style: const TextStyle(fontSize: text_medium_2x),
          decoration: InputDecoration(
              hintText: example,
              hintStyle: const TextStyle(
                  fontStyle: FontStyle.normal, color: Colors.black26),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: card_elevation)),
        ),
      ],
    );
  }
}
