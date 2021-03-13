import 'package:flutter/material.dart';

import 'widgets/tileText.dart';

class NavTitles extends StatelessWidget {
  final void Function() goToHome;
  final void Function() goToJournal;
  final void Function() goToHabits;

  NavTitles(this.goToHome, this.goToJournal, this.goToHabits);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TileText("Home", goToHome),
          TileText("Entries", goToJournal),
          TileText("Habits", goToHabits),
        ],
      ),
    );
  }
}
