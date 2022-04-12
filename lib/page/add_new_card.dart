import 'package:flutter/material.dart';
import 'package:movie_booking_app/bloc/add_new_card_bloc.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model.dart';
import 'package:movie_booking_app/data/modle/movie_booking_model_impl.dart';
import 'package:movie_booking_app/resources/dimension.dart';
import 'package:movie_booking_app/resources/strings.dart';
import 'package:provider/provider.dart';
import '../widgets/back_button_widget.dart';
import '../widgets/button_text_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/text_form_field_input_widget.dart';

class AddNewCardScreen extends StatefulWidget {
  const AddNewCardScreen({Key? key}) : super(key: key);

  @override
  State<AddNewCardScreen> createState() => _AddNewCardScreenState();
}

class _AddNewCardScreenState extends State<AddNewCardScreen> {
  MovieBookingModel movieBookingModel = MovieBookingModelImpl();
  final dateController = TextEditingController();
  final cvcController = TextEditingController();
  final cardNumberController = TextEditingController();
  final cardHolderController = TextEditingController();
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>AddNewCardBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: const BackButtonView(
            color: Colors.black,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: margin_small_2x),
          child: Form(
            key: form,
            child: Column(
              children: [
                CardNumberView(cardNumberController),
                const SizedBox(
                  height: margin_medium_3x,
                ),
                CardHolderView(cardHolderController),
                const SizedBox(
                  height: margin_medium_3x,
                ),
                ExprationDateAndCVCSession(
                  dateController: dateController,
                  cvcController: cvcController,
                ),
                const SizedBox(
                  height: margin_medium_3x,
                ),
                Builder(
                  builder: (context) {
                    return ButtonWidget(
                        onClick: () {
                          AddNewCardBloc addNewCardBloc=Provider.of(context,listen: false);
                          _navigateToOriginalScreen(context,addNewCardBloc);
                        },
                        child: ButtonTextView(confirm));
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
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
              TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(message == 'Error' ? false : true);
                  },
                  child: const Text('OK'))
            ],
          );
        });

    if (status) {
      Navigator.of(context).pop();
    }
  }

  void _navigateToOriginalScreen(context, AddNewCardBloc addNewCardBloc) {
    String status = '';
    if (form.currentState!.validate()) {
      addNewCardBloc
          .createCard(
        cardNumber: cardNumberController.text,
        cardHolder: cardHolderController.text,
        expirationDate: dateController.text,
        cvc: cvcController.text,
      )
          .then((createCardVO) {
        addNewCardBloc.getProfile();
        status = createCardVO?.message ?? '';
        if (status.isNotEmpty) {
          _showALertBox(context, "Success", '1 card added');
        } else {
          _showALertBox(context, "Error", 'Unknown Error');
        }
      }).catchError((error) => print(error));
    }
  }
}

class ExprationDateAndCVCSession extends StatelessWidget {
  final TextEditingController dateController;
  final TextEditingController cvcController;

  ExprationDateAndCVCSession(
      {required this.dateController, required this.cvcController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ExprationDateView(dateController),
        ),
        const SizedBox(
          width: margin_medium,
        ),
        Expanded(
          child: CVCView(cvcController),
        ),
      ],
    );
  }
}

class CVCView extends StatelessWidget {
  final TextEditingController controller;

  CVCView(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: 'CVC',
      example: 'Example 123',
      controller: controller,
      validation: (str) {
        if (str == null || str.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

class ExprationDateView extends StatelessWidget {
  final TextEditingController controller;

  ExprationDateView(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: 'Expration Date',
      example: '08/22',
      controller: controller,
      validation: (str) {
        if (str == null || str.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

class CardHolderView extends StatelessWidget {
  final TextEditingController controller;

  CardHolderView(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: 'Card Holder',
      example: 'Your name',
      controller: controller,
      validation: (str) {
        if (str == null || str.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }
}

class CardNumberView extends StatelessWidget {
  final TextEditingController controller;

  CardNumberView(this.controller);

  @override
  Widget build(BuildContext context) {
    return TextFormFieldWidget(
      title: 'Card Number',
      example: '1234 5678 9012 3456',
      controller: controller,
      validation: (str) {
        if (str == null || str.isEmpty) {
          return 'Required';
        }
        if (str.length != 16) {
          return 'Card number should be 16 digit';
        }
        return null;
      },
    );
  }
}
