import 'package:flutter/material.dart';
import 'dateWidgets.dart';

class NoEntries extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CoolText("No Entries"),
          ],
        ),
      ),
    );
  }
}
