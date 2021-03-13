import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/disabledFoucs.dart';
import 'widgets/journalEntryWidgets.dart';

// ignore: must_be_immutable
class JournalEntry extends StatelessWidget {
  String description;
  String year;
  String month;
  String day;
  Icon icon;
  String planDescription;

  JournalEntry(String _description, double _rating, String _date,
      String _planDescription) {
    if (_date != null) {
      this.year = _date.split('-')[0];
      this.month = getMonthName(_date.split('-')[1]);
      this.day = _date.split('-')[2];
    } else {
      year = null;
      month = null;
      day = null;
    }

    this.icon = (_rating == null) ? getIcon(null) : getIcon(_rating.toInt());

    this.description = (_description == "") ? null : _description;
    this.planDescription = (_planDescription == "") ? null : _planDescription;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
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
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateWidget(day: day, month: month, year: year),
                HappyIcon(icon: icon),
              ],
            ),
          ),
          (description == null)
              ? Container(width: 0, height: 0)
              : JournalDescription(description: description),
          (planDescription == null)
              ? Container(width: 0, height: 0)
              : PlanDescription(planDescription),
        ],
      ),
    );
  }
}

// #region Helper Functions
//Getting icon from score
Icon getIcon(int rating) {
  if (rating == null) {
    return Icon(
      Icons.circle,
      size: 40,
      color: Colors.grey,
    );
  }

  switch (rating) {
    case 1:
      return Icon(
        Icons.sentiment_very_dissatisfied,
        size: 40,
        color: Colors.red,
      );
    case 2:
      return Icon(
        Icons.sentiment_dissatisfied,
        size: 40,
        color: Colors.orange,
      );
    case 3:
      return Icon(
        Icons.sentiment_neutral,
        color: Colors.amber,
        size: 40,
      );
    case 4:
      return Icon(
        Icons.sentiment_satisfied,
        size: 40,
        color: Colors.lightGreen,
      );
    case 5:
      return Icon(
        Icons.sentiment_very_satisfied,
        size: 40,
        color: Colors.green,
      );
  }

  return Icon(
    Icons.circle,
    size: 40,
    color: Colors.grey,
  );
}

// ignore: missing_return
String getMonthName(String number) {
  switch (number) {
    case "01":
      return "January";
    case "02":
      return "February";
    case "03":
      return "March";
    case "04":
      return "April";
    case "05":
      return "May";
    case "06":
      return "June";
    case "07":
      return "July";
    case "08":
      return "August";
    case "09":
      return "September";
    case "10":
      return "October";
    case "11":
      return "November";
    case "12":
      return "December";
    case "1":
      return "January";
    case "2":
      return "February";
    case "3":
      return "March";
    case "4":
      return "April";
    case "5":
      return "May";
    case "6":
      return "June";
    case "7":
      return "July";
    case "8":
      return "August";
    case "9":
      return "September";
  }
}
// #endregion
