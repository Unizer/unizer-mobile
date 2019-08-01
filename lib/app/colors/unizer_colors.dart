import 'dart:ui' show Color;

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class UniColors {
  UniColors._();

  static bool darkMode = false;

  /*-- General --*/
  static const Color white = Colors.white;
  static const Color black = Color(0xFF333333);
  static const Color blue = Color(0xFF0060B6);
  static const Color shadow = Color.fromRGBO(51, 51, 51, 0.2);
  static const Color screenBackground = Color(0XFFE5E1EE);

  /*-- Menubars --*/
  static const Color appBarBackground = Colors.white;
  static const Color menuBackground = Color(0XFFEAE7F2);

  /*-- Borders --*/
  static const Color underlineBorder = Color(0XFFA4B6DF);
  static const Color dividerLine = Color(0XFFE5E1EE);

  /*-- Text --*/
  static const Color hintText = Color.fromRGBO(158, 163, 168, 0.8);
  static const Color bodyText = Color(0xFF333333);
  static const Color h1 = Color(0xFF333333);
  static const Color linkText = Color(0xFF6386D8);
  static const Color subheader = Color(0XFF807A7A);
  static const Color h2 = Color(0XFF807A7A);
  static const Color footer = Color(0XFF737373);
  static const Color error = Colors.red;

  /*-- Buttons --*/
  static const Color buttonGreen = Color(0xFF56C4B7);
  static const Color buttonWormGreen = Color(0xFF9EEA64);
  static const Color buttonClose = Color(0xFFCBC0C0);

  /*-- Icons --*/
  static const Color iconMain = Color(0xFF898989);
}
