import 'package:flutter/material.dart';
import './dateWidgets.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/helperFiles/disabledFoucs.dart';

class JournalDescription extends StatelessWidget {
  const JournalDescription({
    Key key,
    @required this.description,
  }) : super(key: key);

  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 2.5),
      child: TextFormField(
        enabled: false,
        minLines: 1,
        maxLines: null,
        focusNode: AlwaysDisabledFocusNode(),
        controller: TextEditingController(
          text: description,
        ),
        style: textBoxTextStyle,
        decoration: const InputDecoration(
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: lightPurple)),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.purple,
            fontFamily: FontNameDefault,
            fontWeight: FontWeight.w500,
          ),
          labelText: "Journal",
        ),
      ),
    );
  }
}

class PlanDescription extends StatelessWidget {
  final String planDescription;

  PlanDescription(this.planDescription);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15, left: 2.5, right: 2.5, bottom: 2.5),
      child: TextFormField(
        enabled: false,
        minLines: 1,
        maxLines: null,
        focusNode: new AlwaysDisabledFocusNode(),
        controller: TextEditingController(
          text: planDescription,
        ),
        style: textBoxTextStyle,
        decoration: const InputDecoration(
          disabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: lightPurple)),
          border: OutlineInputBorder(),
          labelStyle: TextStyle(
            color: Colors.purple,
            fontFamily: FontNameDefault,
            fontWeight: FontWeight.w500,
          ),
          labelText: "Day Plan",
        ),
      ),
    );
  }
}

class HappyIcon extends StatelessWidget {
  const HappyIcon({
    Key key,
    @required this.icon,
  }) : super(key: key);

  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(right: 5), child: icon);
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    Key key,
    @required this.day,
    @required this.month,
    @required this.year,
  }) : super(key: key);

  final String day;
  final String month;
  final String year;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        (day == null) ? Container(width: 0, height: 0) : DayText(day),
        (month == null) ? Container(width: 0, height: 0) : MonthText(month),
        (year == null) ? Container(width: 0, height: 0) : YearText(year),
      ],
    );
  }
}
