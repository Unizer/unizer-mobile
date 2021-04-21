import 'package:flutter/material.dart';
import 'package:unizer/connector.dart';

class InputTextField extends StatefulWidget {
  InputTextField(
      {required TextEditingController userFieldController,
      String? selectedValue,
      required String hintText});

  @override
  _InputTextFieldState createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  final TextEditingController userFieldController = TextEditingController();
  String selectedValue = '';
  String hintText = '';

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: userFieldController,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.left,
      style: kBodyText,
      decoration: kTextFieldDecoration.copyWith(hintText: hintText),
    );
  }
}
