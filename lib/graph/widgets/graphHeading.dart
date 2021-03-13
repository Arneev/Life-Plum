import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class GraphHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        "Happiness Monitor",
        style: TextStyle(
          color: Colors.pink,
          fontFamily: FancyFontName,
          fontSize: HeadingTextSize,
        ),
      ),
    );
  }
}
