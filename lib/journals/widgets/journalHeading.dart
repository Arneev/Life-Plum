import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class JournalHeading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: Row(
        children: [
          Text(
            "Entries",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: FancyFontName,
              fontSize: HeadingTextSize * 1.3,
            ),
          ),
        ],
      )),
    );
  }
}