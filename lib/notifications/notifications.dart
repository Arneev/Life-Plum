import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../helperFiles/const.dart';
import '../helperFiles/database/database.dart';

void setUpNotifications() async {
  DatabaseHelper databaseHelper = DatabaseHelper.instance;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.cancelAll();

  bool anyRatings = await databaseHelper.anyRatingsAtAll();

  var initializationSettings = InitializationSettings();
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  if (anyRatings) {
    List<String> timeList = await databaseHelper.getAverageTime();
    setFutureSchedules(flutterLocalNotificationsPlugin,
        getTrueAverage(timeList), scheduleIterations);
  } else {
    setFutureSchedules(
        flutterLocalNotificationsPlugin, getMorningTime(), scheduleIterations);
  }
}

void setFutureSchedules(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    DateTime toGoBy,
    int iterations) {
  List<DateTime> listOfDates = getFutureScheduleDates(toGoBy, iterations);

  for (DateTime dateTime in listOfDates) {
    setSchedule(flutterLocalNotificationsPlugin, dateTime);
  }
}

void setSchedule(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    DateTime dateTime) {
  var intializeSettingsAndroid = AndroidInitializationSettings('app_icon');

  AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    "1",
    "Ready to start your day?",
    "Hop onto Life Plum",
    enableVibration: true,
    importance: Importance.defaultImportance,
    icon: intializeSettingsAndroid.defaultIcon,
    playSound: false,
    visibility: NotificationVisibility.public,
  );

  flutterLocalNotificationsPlugin.schedule(
      1,
      "Ready to start your day?",
      "Hop onto Life Plum",
      dateTime,
      NotificationDetails(android: androidNotificationDetails));
}

List<DateTime> getFutureScheduleDates(DateTime timeToSet, int iterations) {
  List<DateTime> listOfDates = List<DateTime>();
  DateTime now = DateTime.now();

  for (int i = 0; i < iterations; i++) {
    DateTime dateTime = timeToSet.add(Duration(days: i));

    if (dateTime.isAfter(now)) {
      listOfDates.add(dateTime);
    } else {
      iterations++;
    }
  }

  return listOfDates;
}

DateTime getTrueAverage(List<String> times) {
  int hour = 0, min = 0, sec = 0;

  for (String s in times) {
    List<String> splt = s.split(':');
    hour += int.parse(splt[0].trim());
    min += int.parse(splt[1].trim());
    sec += int.parse(splt[2].trim());
  }

  int totSec = (hour * 3600 + min * 60 + sec) ~/ times.length;
  int avgHour = totSec ~/ 3600;

  totSec -= avgHour * 3600;
  int avgMin = totSec ~/ 60;

  totSec -= avgMin * 60;
  int avgSec = totSec;

  String sHour = singleIntToDoubleString(avgHour);
  String sMin = singleIntToDoubleString(avgMin);
  String sSec = singleIntToDoubleString(avgSec);

  String sTime = "$sHour:$sMin:$sSec";
  String sDate = DateTime.now().toString().split(' ')[0];
  String sTot = sDate + ' ' + sTime;

  return DateFormat("yyyy-MM-dd hh:mm:ss").parse(sTot);
}

DateTime getMorningTime() {
  String sDate =
      DateTime.now().subtract(Duration(days: 0)).toString().split(' ')[0];
  String sTime = "06:30:00";

  String sTot = sDate + ' ' + sTime;

  return DateFormat("yyyy-MM-dd hh:mm:ss").parse(sTot);
}

String singleIntToDoubleString(int numb) {
  if (numb < 10) {
    return "0" + numb.toString();
  }

  return numb.toString();
}
