import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'classes/graphData.dart';
import './graphStyle.dart';

// ignore: must_be_immutable
class GraphWidget extends StatelessWidget {
  int xItemCount;
  String headingTitle;
  String sortBy;

  List<String> xVals;
  List<double> yVals;

  List<FlSpot> spotData;

  GraphWidget(GraphDataClass graphData) {
    xVals = graphData.xVals;
    yVals = graphData.yVals;
    xItemCount = xVals.length;
    headingTitle = graphData.headingTitle;
    sortBy = graphData.sortBy;

    spotData = graphData.spotData;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        maxY: 5,
        minY: 1,
        minX: 1,
        maxX: xItemCount.toDouble(),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(width: 0.5),
            top: BorderSide(width: 0.5),
            left: BorderSide(width: 0.5),
            right: BorderSide(width: 0.5),
          ),
        ),
        axisTitleData: FlAxisTitleData(
          leftTitle: AxisTitle(
            showTitle: true,
            titleText: "Happiness",
            reservedSize: 0,
            textStyle: axisStyle,
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: SideTitles(
              showTitles: true,
              getTitles: valToXAxis,
              reservedSize: 20,
              getTextStyles: (val) {
                return (val % 2 == 0)
                    ? timePeriodEven
                    : (xItemCount < 8)
                        ? timePeriodOdd
                        : smallTextStyle;
              }),
          leftTitles: SideTitles(
            showTitles: false,
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: true,
          getDrawingVerticalLine: (value) {
            return FlLine(
              color: Colors.purple[200],
              strokeWidth: 0.20,
            );
          },
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.red[200],
              strokeWidth: 0.20,
            );
          },
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spotData,
            isCurved: true,
            barWidth: 3,
            colors: [Colors.grey[600]],
            belowBarData: BarAreaData(
              show: true,
              colors: [
                Colors.green[700].withOpacity(0.7),
                Colors.green.withOpacity(0.7),
                Colors.lightGreen[400].withOpacity(0.7),
                Colors.lightGreen[300].withOpacity(0.7),
                Colors.amber[300].withOpacity(0.7),
                Colors.orange.withOpacity(0.7),
                Colors.red.withOpacity(0.7),
                Colors.red[900].withOpacity(0.7),
              ],
              gradientFrom: Offset(0.5, 0),
              gradientTo: Offset(0.5, 1),
            ),
            show: true,
          ),
        ],
      ),
    );
  }

  String valToXAxis(double value) {
    int val = value.toInt();
    return xVals[val - 1];
  }
}
