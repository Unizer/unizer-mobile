import 'package:flutter/material.dart';
import 'package:Unizer/constants.dart';
import 'package:Unizer/ui/app/textstyles/text_styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.color, @required this.label, this.onPressed});
  final Color color;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      color: color, //Colors.lightBlueAccent,
      borderRadius: BorderRadius.circular(kButtonBorderRadius),
      child: MaterialButton(
        onPressed:
            onPressed, //Navigator.pushNamed(context, LoginScreen.screenID);
        minWidth: 100.0,
        height: 42.0,
        child: Text(
          label,
          style: kButtonText, //'Log In',
        ),
      ),
    );
  }
}
