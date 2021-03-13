import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_plum/events/rateUpdate.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'classes/graphData.dart';
import 'widgets/NoDataHowFeel.dart';
import 'widgets/graphHeading.dart';
import './graphStyle.dart';
import './graphWidget.dart';

class HappyGraph extends StatefulWidget {
  final EventBus eventBus;
  HappyGraph(this.eventBus);

  @override
  _HappyGraphState createState() => _HappyGraphState();
}

class _HappyGraphState extends State<HappyGraph> {
  // ignore: avoid_init_to_null
  GraphDataClass graphDataClass = null;
  String sortBy = "DAY";

  void newSort(String val) {
    sortBy = val;
    updateGraph();
  }

  @override
  void initState() {
    super.initState();
    this.widget.eventBus.on<RateUpdate>().listen((event) {
      updateGraph();
    });
    updateGraph();
  }

  void updateGraph() {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    databaseHelper.getRatingsBySort(sortBy).then((graphList) {
      if (graphList == null) return null;
      if (graphList.length == 0) return null;

      graphDataClass = new GraphDataClass();

      List<String> xAxis = List<String>();
      List<double> yAxis = List<double>();
      List<FlSpot> spotData = List<FlSpot>();

      if (sortBy == "DAY") {
        xAxis.add("Mon");
        xAxis.add("Tues");
        xAxis.add("Wed");
        xAxis.add("Thur");
        xAxis.add("Fri");
        xAxis.add("Sat");
        xAxis.add("Sun");
      } else if (sortBy == "WEEK") {
        xAxis.add("3 ${apos()} Ago");
        xAxis.add("2 ${apos()} Ago");
        xAxis.add("Last");
        xAxis.add("Current");
      } else if (sortBy == "MONTH") {
        xAxis.add("Jan");
        xAxis.add("Feb");
        xAxis.add("Mar");
        xAxis.add("Apr");
        xAxis.add("May");
        xAxis.add("Jun");
        xAxis.add("Jul");
        xAxis.add("Aug");
        xAxis.add("Sep");
        xAxis.add("Oct");
        xAxis.add("Nov");
        xAxis.add("Dec");
      } else if (sortBy == "YEAR") {
        for (var item in graphList) {
          xAxis.add(item["YEAR"]);
        }
      }

      //Sort Scores
      int xAxisLength = xAxis.length;
      for (int i = 0; i < xAxisLength; i++) {
        Map<String, dynamic> item = graphList[i];
        if (item["score"] != null) {
          double score = item["score"].toDouble();
          yAxis.add(score);

          spotData.add(FlSpot((i + 1).toDouble(), score));
        }
      }

      setState(() {
        graphDataClass.xVals = xAxis;
        graphDataClass.yVals = yAxis;
        graphDataClass.spotData = spotData;
        graphDataClass.headingTitle = "Happiness Graph";
        graphDataClass.sortBy = sortBy;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (graphDataClass == null || graphDataClass.spotData.length == 0)
        ? NoDataHowFeel()
        : Column(
            children: [
              Container(
                decoration: graphHeadingBoxDecor,
                margin: EdgeInsets.all(0),
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                child: Column(
                  children: [
                    //Heading
                    GraphHeading(),
                    //DropDown
                    Container(
                      //Sort By
                      width: MediaQuery.of(context).size.width * 0.8,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.purple[300],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Sort By",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: FontNameDefault,
                              fontSize: MediumTextSize,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          DropdownButton(
                              iconEnabledColor: Colors.white,
                              iconDisabledColor: Colors.white,
                              dropdownColor: Colors.purple[200],
                              focusColor: Colors.white,
                              value: sortBy,
                              items: [
                                DropdownMenuItem(
                                    child: Text("Day", style: itemTextStyle),
                                    value: "DAY"),
                                DropdownMenuItem(
                                    child: Text("Week", style: itemTextStyle),
                                    value: "WEEK"),
                                DropdownMenuItem(
                                    child: Text("Month", style: itemTextStyle),
                                    value: "MONTH"),
                                DropdownMenuItem(
                                    child: Text("Year", style: itemTextStyle),
                                    value: "YEAR"),
                              ],
                              onChanged: (val) => newSort(val)),
                        ],
                      ),
                    ),
                    //Graph
                  ],
                ),
              ),
              Container(
                // color: Colors.red,
                margin: EdgeInsets.only(top: 45, bottom: 15),
                alignment: Alignment.center,
                child: GraphWidget(graphDataClass),
              ),
            ],
          );
  }
}

// #region Helper Functions

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

String apos() {
  return '"';
}

// #endregion
