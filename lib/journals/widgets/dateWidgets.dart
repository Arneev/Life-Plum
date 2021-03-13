import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

//Date Widgets
class DayText extends StatelessWidget {
  final String day;
  DayText(this.day);

  @override
  Widget build(BuildContext context) {
    return DateText(day, 1.3, Colors.red[300], EdgeInsets.only(left: 5));
  }
}

class MonthText extends StatelessWidget {
  final String month;
  MonthText(this.month);

  @override
  Widget build(BuildContext context) {
    return DateText(month, 1.0, Colors.grey[800], EdgeInsets.only(left: 9));
  }
}

class YearText extends StatelessWidget {
  final String year;
  YearText(this.year);

  @override
  Widget build(BuildContext context) {
    return DateText(year, 0.7, Colors.grey, EdgeInsets.only(left: 13));
  }
}

class DateText extends StatelessWidget {
  final String text;
  final double scaleFactor;
  final Color fontDarkness;
  final EdgeInsets margin;

  DateText(this.text, this.scaleFactor, this.fontDarkness, this.margin);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: margin,
      child: Text(
        text,
        textAlign: TextAlign.end,
        textScaleFactor: scaleFactor,
        style: TextStyle(
          fontFamily: FontNameDefault,
          color: fontDarkness,
          fontSize: LargeTextSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CoolText extends StatelessWidget {
  final String text;
  CoolText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      textScaleFactor: 1,
      style: TextStyle(
        wordSpacing: 6.0,
        letterSpacing: 0.8,
        fontFamily: FontNameDefault,
        fontSize: LargeTextSize,
        fontWeight: FontWeight.w600,
        color: Colors.grey[800],
      ),
    );
  }
}
