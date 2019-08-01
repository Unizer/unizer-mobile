import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Unizer/constants.dart';
import 'package:Unizer/app/colors/unizer_colors.dart';
import 'package:Unizer/app/styles/style_text-styles.dart';

//TODO: Create a custom Toast conform proto
class UniDialog {
  static Future<bool> showToast({String message}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: kDialogDuration,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black87,
      fontSize: 20.0,
    );
  }

  static showSnackBar(
      {BuildContext context, String message, SnackBarAction action}) {
    var showSnackBar = Scaffold.of(context).showSnackBar(SnackBar(
      action: action,
      elevation: 8.0,
      backgroundColor: UniColors.blue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
      content: Container(
        //height: kSnackBarHeight,
        child: Text(
          message,
          style: kSnackBarText,
        ),
      ),
      duration: Duration(seconds: kDialogDuration),
    ));
    return showSnackBar;
  }
}
