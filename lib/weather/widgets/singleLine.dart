import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class WidgetSingleLine extends StatelessWidget {
  final String text;
  final Color textColor;
  WidgetSingleLine(this.text, this.textColor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Text(text,
          style: TextStyle(
            color: textColor,
            fontFamily: FontNameDefault,
            fontSize: MediumTextSize,
            fontWeight: FontWeight.w500,
          )),
    );
  }
}
