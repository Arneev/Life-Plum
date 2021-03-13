import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'ratingBar.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'checkpointHeading.dart';
import 'rateHeading.dart';

class RateDay extends StatefulWidget {
  final EventBus eventBus;
  RateDay(this.eventBus);

  @override
  _RateDayState createState() => _RateDayState();
}

class _RateDayState extends State<RateDay> {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;
  double prevRating;

  @override
  void initState() {
    prevRating = 3;
    super.initState();
    databaseHelper.alreadyRatedToday().then((alreadyRatedToday) {
      if (alreadyRatedToday) {
        databaseHelper.getTodaysRating().then((value) {
          setState(() {
            prevRating = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckpointHeading(),
        Container(
          margin: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1, color: Colors.purple),
            boxShadow: [
              BoxShadow(
                color: Colors.purple.withOpacity(0.025),
                blurRadius: 3,
                spreadRadius: 5,
                offset: Offset(0.5, 1),
              ),
            ],
          ),
          child: Column(
            children: [
              RateHeading(),
              HappyRating(
                  prevRating: prevRating,
                  databaseHelper: databaseHelper,
                  rateDay: widget),
            ],
          ),
        ),
      ],
    );
  }
}
