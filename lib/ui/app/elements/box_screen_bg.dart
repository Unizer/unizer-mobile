import 'package:flutter/material.dart';

const BoxDecoration kBoxScreenDecoration = BoxDecoration(
  // Box decoration takes a gradient
  gradient: LinearGradient(
    // Where the linear gradient begins and ends
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: <double>[0.0, 1.0],
    colors: <Color>[
      Color(0XFFE5E1EE),
      Color(0XFFFFFFFF),
    ],
  ),
);

const BoxShadow kBoxScreenShadow = BoxShadow(
  color: Color.fromRGBO(51, 51, 51, 0.2),
  blurRadius: 2.0, // has the effect of softening the shadow
  spreadRadius: 0.0, // has the effect of extending the shadow
  offset: Offset(
    0.0, // horizontal, move right 10
    2.0, // vertical, move down 10
  ),
);
