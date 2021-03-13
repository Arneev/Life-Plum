import 'package:flutter/material.dart';
import '../../helperFiles/style.dart';

class LineText extends StatelessWidget {
  final String displayStr;

  LineText(this.displayStr);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Text(
        (displayStr != null) ? displayStr : "",
        style: TextStyle(
          fontFamily: FontNameDefault,
          color: Colors.white,
          fontSize: MediumTextSize,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
