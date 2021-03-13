import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:life_plum/helperFiles/events.dart';
import 'package:life_plum/helperFiles/style.dart';

import 'habitHeading.dart';

class HabitHeader extends StatelessWidget {
  final EventBus eventBus;
  final BuildContext parentContext;
  HabitHeader(this.eventBus, this.parentContext);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(vertical: 20),
      margin: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.purple[200],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          HabitHeading(),
          AddHabit(eventBus),
        ],
      ),
    );
  }
}

class AddHabit extends StatelessWidget {
  static String habitString = "";
  final EventBus eventBus;

  AddHabit(this.eventBus);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        //Month Picker
        onPressed: () => showDialog(
          context: context,
          child: Dialog(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: MediaQuery.of(context).size.width,
                    color: Colors.purple[200],
                    child: Text(
                      "Add Habit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: FancyFontName,
                        fontSize: HeadingTextSize,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      minLines: 1,
                      maxLines: 3,
                      style: TextStyle(
                        fontFamily: FontNameDefault,
                        fontSize: MediumTextSize,
                      ),
                      controller: TextEditingController(
                        text: habitString,
                      ),
                      onChanged: (string) {
                        habitString = string;
                      },
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      DatabaseHelper.instance
                          .insertHabit(habitString)
                          .then((_) => eventBus.fire(UpdateHabit()));
                      habitString = "";
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      padding: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[200],
                      ),
                      child: Text(
                        "Add Habit",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediumTextSize,
                          fontFamily: FontNameDefault,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        //Add Habit
        child: Container(
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Text(
            "Add Habit",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.purple[200],
              fontSize: MediumTextSize,
              fontFamily: FontNameDefault,
            ),
          ),
        ),
      ),
    );
  }
}
