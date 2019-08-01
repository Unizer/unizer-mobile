import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Unizer/constants.dart';
import 'package:Unizer/app/colors/unizer_colors.dart';
import 'package:Unizer/app/styles/style_text-styles.dart';

//TODO: Create a custom Toast conform proto
class UniToast {
  static Future<bool> showToast({String message}) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIos: 3,
      gravity: ToastGravity.TOP,
      backgroundColor: Colors.black87,
      fontSize: 20.0,
    );
  }
}

class UniSnackBar {
  static showSnackBar({BuildContext context, String message}) {
    var showSnackBar = Scaffold.of(context).showSnackBar(SnackBar(
      backgroundColor: UniColors.blue,
      content: Container(
        height: kSnackBarHeight,
        child: Text(
          message,
          style: kSnackBarText,
        ),
      ),
      duration: Duration(seconds: 3),
    ));
    return showSnackBar;
  }
}

class UniAlertDialog extends StatelessWidget {
  const UniAlertDialog({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Alert'),
      content: Text('Weet je het zeker?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          child: Text(
            'Yes',
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: Text(
            'No',
          ),
        ),
      ],
    );
  }
}
