import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class NoDataHowFeel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 30),
        child: Text(
          "No data.\nTell me how you feeling :)",
          textAlign: TextAlign.center,
          style: TextStyle(
            wordSpacing: 6.0,
            letterSpacing: 0.8,
            fontFamily: FontNameDefault,
            fontSize: LargeTextSize,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ));
  }
}
