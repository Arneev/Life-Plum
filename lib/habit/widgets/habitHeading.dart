import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class HabitHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Habits",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: FancyFontName,
          fontSize: HeadingTextSize * 1.3,
        ),
      ),
    );
  }
}
