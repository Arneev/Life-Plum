import 'style.dart';
import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String errorMessage;

  ErrorMessage(this.errorMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(errorMessage, style: SingleLineTextStyle),
    );
  }
}

String doubleQuote(String string) {
  return '"' + string + '"';
}
