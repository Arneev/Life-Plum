import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

var graphHeadingBoxDecor = BoxDecoration(
  gradient: LinearGradient(
      colors: [Colors.red[50], Colors.white],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter),
  borderRadius: BorderRadius.only(
      topLeft: Radius.circular(15), topRight: Radius.circular(15)),
);

var smallTextStyle = TextStyle(
  color: Colors.blue[900],
  fontFamily: FontNameDefault,
  fontSize: 0,
  fontWeight: FontWeight.w300,
);

var timePeriodEven = TextStyle(
  color: Colors.grey[900],
  fontFamily: FontNameDefault,
  fontSize: SmallTextSize,
  fontWeight: FontWeight.w300,
);

var timePeriodOdd = TextStyle(
  color: Colors.blue[900],
  fontFamily: FontNameDefault,
  fontSize: SmallTextSize,
  fontWeight: FontWeight.w300,
);

var axisStyle = TextStyle(
  color: Colors.grey[900],
  fontFamily: FontNameDefault,
  fontSize: MediumTextSize,
  fontWeight: FontWeight.w400,
);

var itemTextStyle = TextStyle(
  color: Colors.white,
  fontSize: MediumTextSize,
  fontFamily: FontNameDefault,
);
