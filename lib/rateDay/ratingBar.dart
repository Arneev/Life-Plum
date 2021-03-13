import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_plum/events/rateUpdate.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/rateDay/rateDay.dart';



class HappyRating extends StatelessWidget {
  const HappyRating({
    Key key,
    @required this.prevRating,
    @required this.databaseHelper,
    @required this.rateDay,
  }) : super(key: key);

  final double prevRating;
  final DatabaseHelper databaseHelper;
  final RateDay rateDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingBar.builder(
          initialRating: prevRating,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          // ignore: missing_return
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.orange,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
            }
          },
          onRatingUpdate: (score) {
            databaseHelper.attemptRatingInsert(score).then((msg) {
              this.rateDay.eventBus.fire(RateUpdate());

              Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.purple[400],
                textColor: Colors.white,
                fontSize: MediumTextSize,
              );
            });
          }),
    );
  }
}
