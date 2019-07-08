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
