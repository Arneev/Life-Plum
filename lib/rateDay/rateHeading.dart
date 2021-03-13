import 'package:flutter/material.dart';
import '../helperFiles/style.dart';

class RateHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: Text(
          "How are you feeling today?",
          style: TextStyle(
            fontFamily: FancyFontName,
            fontWeight: FontWeight.w300,
            fontSize: HeadingTextSize,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
