import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:life_plum/helperFiles/events.dart';
import 'package:life_plum/helperFiles/style.dart';

//TODO: Completed Habit Tile

class HabitTile extends StatefulWidget {
  final int completed;
  final int habitID;
  final String habit;
  final bool isChecked;
  final EventBus eventBus;

  HabitTile({
    this.completed,
    this.habitID,
    this.habit,
    this.isChecked,
    this.eventBus,
  });

  @override
  _HabitTileState createState() => _HabitTileState();
}

class _HabitTileState extends State<HabitTile> {
  int completed;
  bool isAlive = true;
  bool initialTick;

  @override
  void initState() {
    isAlive = true;
    completed = this.widget.completed;
    initialTick = this.widget.isChecked;
    super.initState();
  }

  void deleteHabit() async {
    DatabaseHelper.instance.deleteHabit(this.widget.habitID);
    setState(() {
      isAlive = false;
    });
  }

  void toggleTick(bool isTicked) {
    initialTick = !initialTick;
    if (isTicked) {
      setState(() {
        completed++;
      });
    } else {
      setState(() {
        completed--;
      });
    }

    DatabaseHelper.instance.toggleTodaysHabit(this.widget.habitID, isTicked);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return (!isAlive)
        ? Container(width: 0, height: 0)
        : Container(
            width: size.width * 0.6,
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.all(15),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.deepPurple[200]),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 2,
                  color: Colors.purple[50].withOpacity(0.15),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Checkbox(
                    value: initialTick,
                    onChanged: toggleTick,
                    activeColor: Colors.purple[300],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    this.widget.habit,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: FontNameDefault,
                      fontSize: MediumTextSize,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 15),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        completed.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontNameDefault,
                          fontSize: MediumTextSize,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: deleteHabit,
                      child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.1,
                        height: size.width * 0.1,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.red[200],
                          borderRadius: BorderRadius.circular(size.width * 0.5),
                        ),
                        child: Text(
                          'X',
                          style: TextStyle(
                            fontSize: MediumTextSize,
                            fontFamily: FontNameDefault,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
