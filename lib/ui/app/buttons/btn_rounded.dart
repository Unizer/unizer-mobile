import 'package:flutter/material.dart';
import 'package:Unizer/constants.dart';
import 'package:Unizer/ui/app/textstyles/style_text-styles.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {@required this.color, @required this.label, this.onPressed, this.topMargin});
  final Color color;
  final String label;
  final Function onPressed;
  final double topMargin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topMargin ?? kButtonTopMargin),
      child: Material(
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
      ),
    );
  }
}
