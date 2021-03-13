import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

Future<void> insertTestData(Database db) async {
  Fluttertoast.showToast(msg: "ABOUT TO INSERT TEST DATA");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(4,'2021-01-03','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(1,'2021-01-02','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(3,'2021-01-01','06:00:00')");

  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(4,'2020-12-26','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(3,'2020-12-25','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(5,'2020-12-24','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(4,'2020-12-23','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(2,'2020-12-22','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(3,'2020-12-21','06:00:00')");

  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(4,'2020-12-13','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(2,'2020-12-12','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(3,'2020-12-11','06:00:00')");

  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(2,'2020-12-03','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(1,'2020-12-02','06:00:00')");
  await db.rawQuery(
      "INSERT INTO RATING(ratingScore,date, time) VALUES(3,'2020-12-01','06:00:00')");

  await db.rawQuery(
      "INSERT INTO JOURNAL(description,date, time) VALUES ('Had a great day yesterday, going to keep it up today :)','2021-01-03')");

  await db.rawQuery(
      "INSERT INTO PLANNING(plandescription,date,time) VALUES ('GRIND WORK PROJECT!','2021-01-03')");

  try {
    insertRandomTestData(db, 1000);
  } on Exception {}
}

Future<void> insertRandomTestData(Database db, int iterations) async {
  Random rng = new Random();
  for (int i = 0; i < iterations; i++) {
    try {
      int m = rng.nextInt(11) + 1;
      String month;

      if (m < 10) {
        month = "0" + m.toString();
      } else {
        month = m.toString();
      }

      int y = rng.nextInt(11);
      String year;

      if (y == 0) {
        year = "2020";
      } else {
        year = "201" + y.toString();
      }

      int d = rng.nextInt(28) + 1;
      String day;

      if (d < 10) {
        day = "0" + d.toString();
      } else {
        day = d.toString();
      }

      int randScore = rng.nextInt(4) + 2;

      String totDate = "'" + year + '-' + month + '-' + day + "'";
      await db.rawQuery(
          "INSERT INTO RATING(ratingScore,date,time) VALUES(${randScore.toString()},$totDate,'06:00:00')");
    } on Exception {}
  }
}

Future<void> insertHabitData(dynamic habitInsert) async {

}
