import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_plum/habit/classes/habitInfo.dart';
import 'package:life_plum/habit/habitTile.dart';
import 'package:life_plum/habit/widgets/noHabits.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:life_plum/helperFiles/events.dart';

class HabitList extends StatefulWidget {
  final EventBus eventBus;
  HabitList(this.eventBus);

  @override
  _HabitListState createState() => _HabitListState();
}

class _HabitListState extends State<HabitList> {
  List<HabitInfo> habitList;

  void updateHabitList() async {
    DatabaseHelper.instance.getHabits().then((habitMap) {
      String todaysDate = DateTime.now().toString().split(' ')[0];

      setState(() {
        habitList.clear();

        for (Map<String, dynamic> e in habitMap) {
          habitList.add(HabitInfo(
              habitID: e['habitID'],
              habitText: e['habit'],
              completed: e['completed'],
              todayChecked: todaysDate == e['lastDate']));
        }

        //habitMap.map() -- end
      });
      //SetState -- end
    });
  }

  @override
  void initState() {
    habitList = List<HabitInfo>();
    super.initState();
    this.widget.eventBus.on<UpdateHabit>().listen((_) => updateHabitList());
    updateHabitList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 15),
        width: size.width * 0.9,
        child: (habitList.length == 0)
            ? NoHabits()
            : ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: habitList.length,
                itemBuilder: (buildContext, id) {
                  return HabitTile(
                    completed: habitList[id].completed,
                    habit: habitList[id].habitText,
                    habitID: habitList[id].habitID,
                    isChecked: habitList[id].todayChecked,
                    eventBus: this.widget.eventBus,
                  );
                }),
      ),
    );
  }
}
