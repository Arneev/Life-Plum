import 'package:fl_chart/fl_chart.dart';

class GraphDataClass {
  List<String> xVals;
  List<double> yVals;
  String headingTitle;
  String sortBy;
  List<FlSpot> spotData;

  GraphDataClass() {
    xVals = List<String>();
    yVals = List<double>();
    spotData = List<FlSpot>();
  }
}
