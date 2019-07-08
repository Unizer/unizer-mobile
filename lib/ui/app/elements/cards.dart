import 'package:flutter/material.dart';
import 'package:Unizer/constants.dart';

const BoxDecoration kCardBox = BoxDecoration(
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, 0.2),
      blurRadius: 2.0, // has the effect of softening the shadow
      spreadRadius: 0.0, // has the effect of extending the shadow
      offset: Offset(
        0.0, // horizontal, move right 10
        2.0, // vertical, move down 10
      ),
    ),
  ],
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(kDefaultBorderRadius),
  ),
);

const BoxDecoration kInfoBox = BoxDecoration(
  boxShadow: <BoxShadow>[
    BoxShadow(
      color: Color.fromRGBO(51, 51, 51, 0.2),
      blurRadius: 2.0, // has the effect of softening the shadow
      spreadRadius: 0.0, // has the effect of extending the shadow
      offset: Offset(
        0.0, // horizontal, move right 10
        2.0, // vertical, move down 10
      ),
    ),
  ],
  color: Colors.white,
  borderRadius: BorderRadius.only(
    bottomRight: Radius.circular(kDefaultBorderRadius),
    bottomLeft: Radius.circular(kDefaultBorderRadius),
  ),
);
