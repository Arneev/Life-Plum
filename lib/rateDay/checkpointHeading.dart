import 'package:flutter/material.dart';
import '../helperFiles/style.dart';

class CheckpointHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.grey[700],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.1),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.yellow.withOpacity(0.4),
            offset: Offset(1, 1),
            spreadRadius: 3,
          ),
        ],
      ),
      child: Text(
        "The Checkpoint",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: FancyFontName,
          fontSize: HeadingTextSize,
        ),
      ),
    );
  }
}
