import 'package:flutter/material.dart';
import 'package:life_plum/journals/widgets/dateWidgets.dart';

class NoHabits extends StatelessWidget {
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
