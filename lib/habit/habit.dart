import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:life_plum/habit/habitList.dart';
import 'package:life_plum/habit/widgets/habitHeader.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/navigator/navbar.dart';

class Habit extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar,
      drawer: NavBar(context, scaffoldKey),
      body: HabitBody(),
    );
  }
}

class HabitBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventBus eventBus = new EventBus();
    return Container(
      child: Column(
        children: [
          HabitHeader(eventBus, context),
          HabitList(eventBus),
        ],
      ),
    );
  }
}
