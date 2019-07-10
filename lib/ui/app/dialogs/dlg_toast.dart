import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//TODO: Create a custom Toast conform proto
class UniToast {
  static Future<bool> showToast ({String message}) {
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