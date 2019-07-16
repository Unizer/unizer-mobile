import 'package:Unizer/ui/app/colors/unizer_colors.dart';
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
      UniColors.screenBackground,
      UniColors.white,
    ],
  ),
);

const BoxDecoration kMenuScreenDecoration = BoxDecoration(
  // Box decoration takes a gradient
  gradient: LinearGradient(
    // Where the linear gradient begins and ends
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    // Add one stop for each color. Stops should increase from 0 to 1
    stops: <double>[0.0, 1.0],
    colors: <Color>[
      UniColors.white,
      UniColors.menuBackground,
    ],
  ),
);

const BoxShadow kBoxScreenShadow = BoxShadow(
  color: UniColors.shadow,
  blurRadius: 2.0, // has the effect of softening the shadow
  spreadRadius: 0.0, // has the effect of extending the shadow
  offset: Offset(
    0.0, // horizontal, move right 10
    2.0, // vertical, move down 10
  ),
);
