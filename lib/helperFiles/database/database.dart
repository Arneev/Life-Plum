import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../helper.dart';
import 'dbTest.dart';

class DatabaseHelper {
/* #region Database Intialization */
  final String _databaseName = "localDB.db";
  final int _databaseVersion = 2;

  //This makes a constructor within the libray, we only want 1 LocalDBHelper so its perfect!
  DatabaseHelper._privateConstructor();

  //Making a static and final instance of it
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await _createDatabase();
    return _database;
  }

  Future<Database> _createDatabase() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1 && newVersion > 1) {
      String habitTableSQL =
          "CREATE TABLE HABIT(habitID INTEGER PRIMARY KEY AUTOINCREMENT, habit TEXT NOT NULL, startDate TEXT NOT NULL, completed INTEGER NOT NULL, lastDate TEXT)";
      await db.execute(habitTableSQL);
    }
  }

  Future _onCreate(Database db, int version) async {
    String ratingTableSQL =
        "CREATE TABLE RATING(ratingID INTEGER PRIMARY KEY, ratingScore REAL NOT NULL, date TEXT NOT NULL UNIQUE, time TEXT NOT NULL)";
    String journalTableSQL =
        "CREATE TABLE JOURNAL(journalID INTEGER PRIMARY KEY, description TEXT NOT NULL, date TEXT NOT NULL UNIQUE)";

    String planningTableSQL =
        "CREATE TABLE PLANNING(planID INTEGER PRIMARY KEY, plandescription TEXT NOT NULL, date TEXT NOT NULL UNIQUE)";

    String habitTableSQL =
        "CREATE TABLE HABIT(habitID INTEGER PRIMARY KEY AUTOINCREMENT, habit TEXT NOT NULL, startDate TEXT NOT NULL, completed INTEGER NOT NULL, lastDate TEXT)";

    await db.execute(ratingTableSQL);
    await db.execute(journalTableSQL);
    await db.execute(planningTableSQL);
    await db.execute(habitTableSQL);

    // insertTestData(db);
  }

  Future<List<Map>> rawQuery(String sql) async {
    Database db = await instance.database;
    return await db.rawQuery(sql);
  }

  /* #endregion */

/* #region PLANNING */
  Future<bool> isTodayPlan() async {
    String date = doubleQuote(getDate());
    String sql = "SELECT * FROM PLANNING WHERE date = $date";

    return (await rawQuery(sql)).length != 0;
  }

  Future<void> insertIntoPlanning(String description) async {
    String date = doubleQuote(getDate());
    description = doubleQuote(description);
    String sql =
        "INSERT INTO PLANNING(plandescription, date) VALUES($description,$date)";

    await rawQuery(sql);
  }

  Future<void> updatePlanning(String description) async {
    String date = doubleQuote(getDate());
    description = doubleQuote(description);
    String sql =
        "UPDATE PLANNING SET plandescription = $description WHERE date = $date";

    await rawQuery(sql);
  }

  Future<void> attemptPlanInsert(String description) async {
    if (isLineEmpty(description)) {
      if (await isTodayPlan()) {
        deleteTodayPlan();
      }
      return;
    }

    if (await isTodayPlan()) {
      await updatePlanning(description);
      return;
    }

    await insertIntoPlanning(description);
  }

  Future<void> deleteTodayPlan() async {
    String date = doubleQuote(getDate());
    String sql = "DELETE FROM PLANNING WHERE date = $date";

    await rawQuery(sql);
  }

  Future<String> getTodayPlan() async {
    String date = doubleQuote(getDate());
    String sql = "SELECT * FROM PLANNING WHERE date = $date";

    return (await rawQuery(sql))[0]['plandescription'];
  }

  /* #endregion */

/* #region RATING */
  Future<List<String>> getAverageTime() async {
    String sql = "SELECT * FROM RATING";
    return (await rawQuery(sql)).map((e) => e['time'].toString()).toList();
  }

  Future<bool> anyRatingsAtAll() async {
    String sql = "SELECT * FROM RATING";

    return (await rawQuery(sql)).length != 0;
  }

  Future<List<Map>> getRatings() async {
    return await rawQuery("SELECT scoreRating,date FROM RATING");
  }

  Future<List<Map>> getRatingsBySort(String sort) async {
    switch (sort) {
      case "DAY":
        return await getDayRatings();
      case "WEEK":
        return await getWeekRatings();
      case "MONTH":
        return await getMonthRatings();
      case "YEAR":
        return await getYearRatings();
    }

    return await getDayRatings();
  }
  /* #endregion */

/* #region GRAPH QUERIES */
  //Getting Ratings - Year
  Future<List<Map>> getYearRatings() async {
    String min = doubleQuote(
        (await rawQuery("SELECT MIN(date) AS min FROM RATING"))[0]['min']);
    String max =
        doubleQuote((await rawQuery("SELECT DATE('now') as max"))[0]['max']);

    await rawQuery(
        "CREATE TABLE TEMPYEAR AS with RECURSIVE YEARS(YEAR) AS (VALUES($min) UNION ALL SELECT DATE(YEAR,'+1 year') FROM YEARS WHERE YEAR < Date($max) ) SELECT strftime('%Y',YEAR) AS YEAR FROM YEARS");

    await rawQuery(
        "CREATE TABLE tempOurYear AS SELECT AVG(ratingscore) as score,strftime('%Y',date) AS YEAR FROM RATING GROUP BY strftime('%Y',date)");

    List<Map<String, dynamic>> list = await rawQuery(
        "SELECT TEMPYEAR.YEAR,score FROM TEMPYEAR LEFT JOIN tempOurYear ON TEMPYEAR.YEAR = tempOurYear.year ORDER BY TEMPYEAR.YEAR ASC");

    await rawQuery("DROP TABLE TEMPYEAR");
    await rawQuery("DROP TABLE tempOurYear");

    return list;
  }

  //Getting Ratings - Month
  Future<List<Map>> getMonthRatings() async {
    await rawQuery(
        "CREATE TABLE TEMPMONTH AS WITH RECURSIVE MONTHS(MONTH) AS(VALUES(DATE('now','start of year')) UNION ALL SELECT DATE(MONTH,'+1 month') FROM MONTHS WHERE MONTH < DATE('now','+1 year','start of year','-1 month')) SELECT strftime('%Y-%m',MONTH) AS MONTH FROM MONTHS");

    await rawQuery(
        "CREATE TABLE tempOurMonth AS SELECT AVG(ratingscore) AS score,strftime('%Y-%m',DATE) as MONTH FROM RATING WHERE strftime('%Y',DATE) = strftime('%Y',Date('Now')) group BY strftime('%Y-%m',date)");

    List<Map<String, dynamic>> list = await rawQuery(
        "SELECT TEMPMONTH.MONTH,score FROM TEMPMONTH LEFT JOIN tempOurMonth ON TEMPMONTH.MONTH = tempOurMonth.MONTH ORDER BY TEMPMONTH.month ASC");

    await rawQuery("DROP TABLE TEMPMONTH");
    await rawQuery("DROP TABLE tempOurMonth");

    return list;
  }

  //Getting Ratings - Week
  Future<List<Map>> getWeekRatings() async {
    await rawQuery(
        "CREATE TABLE TEMPWEEK AS WITH RECURSIVE dates(date) AS (VALUES(DATE(DATE('now','weekday 0','-6 days'),'weekday 0','-27 days')) UNION ALL SELECT date(date, '+7 day') FROM dates WHERE date < DATE('now','weekday 0','-6 days')) SELECT DATE as WEEK FROM dates");

    await rawQuery(
        "create table tempOurWeek AS SELECT AVG(ratingScore) as score,DATE(DATE, 'weekday 0', '-6 days') AS WEEK FROM RATING WHERE DATE(DATE,'weekday 0', '-6 days') >= DATE(DATE('now','weekday 0', '-6 days'), '-27 days') GROUP BY DATE(DATE, 'weekday 0', '-6 days') ORDER BY WEEK DESC");

    List<Map<String, dynamic>> list = await rawQuery(
        "SELECT TEMPWEEK.week, tempOurWeek.score FROM TEMPWEEK LEFT join tempOurWeek ON TEMPWEEK.week = tempOurWeek.week order by TEMPWEEK.WEEK ASC");

    await rawQuery("DROP TABLE TEMPWEEK");
    await rawQuery("DROP TABLE tempOurWeek");

    return list;
  }

  //Getting Ratings - Day
  Future<List<Map>> getDayRatings() async {
    await rawQuery(
        "CREATE TABLE TEMPDAYS AS WITH RECURSIVE DAYS(DAY) AS(VALUES(DATE('now','weekday 0','-6 day')) UNION ALL SELECT date(DAY,'+1 day') FROM DAYS WHERE DAY < date(DATE('now','weekday 0','-6 day'),'+6 day') ) SELECT DAY FROM DAYS");

    await rawQuery(
        "CREATE TABLE tempOurDay AS SELECT ratingScore as score,date AS DAY FROM RATING WHERE Date >= DATE('now', 'weekday 0', '-6 days')");

    List<Map<String, dynamic>> list = await rawQuery(
        "SELECT TEMPDAYS.DAY,score FROM TEMPDAYS LEFT JOIN tempOurDay ON TEMPDAYS.day = tempOurDay.day ORDER BY TEMPDAYS.day ASC");

    await rawQuery("DROP TABLE TEMPDAYS");
    await rawQuery("DROP TABLE tempOurDay");

    return list;
  }

/* #endregion */

/* #region RATINGS */
  Future<int> amountOfRatings() async {
    return (await rawQuery("SELECT COUNT(*) AS COUNT FROM RATING"))[0]['COUNT'];
  }

  Future<double> averageRating() async {
    return (await rawQuery("SELECT AVG(ratingScore) AS AVERAGE FROM RATING"))[0]
        ['AVERAGE'];
  }

  Future<bool> alreadyRatedToday() async {
    String date = doubleQuote(getDate());
    return (await rawQuery(
                "SELECT COUNT(*) AS COUNT FROM RATING WHERE date = $date"))[0]
            ['COUNT'] ==
        1;
  }

  Future<double> getTodaysRating() async {
    String date = doubleQuote(getDate());
    String sql = "SELECT ratingScore FROM RATING WHERE date = $date";

    return (await rawQuery(sql))[0]['ratingScore'];
  }

  Future<String> insertIntoRating(double score) async {
    String date = doubleQuote(getDate());
    String time = doubleQuote(getTime());
    String sql =
        "INSERT INTO RATING(ratingScore, date, time) VALUES($score,$date, $time)";

    try {
      await rawQuery(sql);
      return "Noted";
    } on Exception catch (error) {
      print(error);
    }

    return "Whoops, please try again";
  }

  Future<String> updateRating(double score) async {
    String date = doubleQuote(getDate());
    String sql = "UPDATE RATING SET ratingScore = $score WHERE date = $date";

    try {
      await rawQuery(sql);
      return "Updated!";
    } on Exception catch (error) {
      print(error);
    }

    return "Whoops, please try again";
  }

  Future<String> attemptRatingInsert(double score) async {
    if (await alreadyRatedToday()) {
      return await updateRating(score);
    }

    return await insertIntoRating(score);
  }

/* #endregion */

/* #region JOURNAL */

  Future<List<Map<String, dynamic>>> getJournalEntriesWScore(
      String date) async {
    String createTempT =
        "CREATE TABLE 'tempT' AS SELECT ratingScore,JOURNAL.DATE,description FROM JOURNAL LEFT JOIN RATING ON JOURNAL.date = RATING.date UNION SELECT ratingScore,RATING.DATE,description FROM RATING LEFT JOIN JOURNAL ON JOURNAL.date = RATING.date";

    String mainSql =
        "SELECT * FROM (SELECT ratingScore,tempT.date,description,plandescription FROM tempT LEFT JOIN PLANNING ON PLANNING.date = tempT.date UNION SELECT ratingScore,PLANNING.date,description,plandescription FROM PLANNING LEFT JOIN tempT ON tempT.date = PLANNING.date) WHERE strftime('%Y-%m',DATE) = $date ORDER BY DATE DESC";

    String dropTempT = "DROP TABLE tempT";

    await rawQuery(createTempT);
    var list = await rawQuery(mainSql);
    await rawQuery(dropTempT);

    return list;
  }

  Future<void> insertJournalEntry(String line) async {
    if (!isLineEmpty(line)) {
      line = doubleQuote(line);
      String date = doubleQuote(getDate());

      await rawQuery(
          "INSERT INTO JOURNAL(description,date) VALUES ($line,$date)");
    }
  }

  Future<bool> alreadyJournalEntryIn() async {
    String date = doubleQuote(getDate());
    List<Map<String, dynamic>> map = await rawQuery("SELECT * FROM JOURNAL");
    print("Currently in journal " + map.toString());
    return (await rawQuery(
                "SELECT COUNT(*) AS COUNT FROM JOURNAL WHERE date = $date"))[0]
            ['COUNT'] ==
        1;
  }

  Future<void> attemptInsertJournal(String line) async {
    if (isLineEmpty(line)) {
      if (await alreadyJournalEntryIn()) {
        deleteTodayJournalEntry();
      }
      return;
    }

    if (await alreadyJournalEntryIn()) {
      await updateJournalEntry(line);
    } else {
      await insertJournalEntry(line);
    }
  }

  Future<void> deleteTodayJournalEntry() async {
    String date = doubleQuote(getDate());
    String sql = "DELETE FROM JOURNAL WHERE date = $date";

    await rawQuery(sql);
  }

  Future<String> getTodaysEntry() async {
    String date = doubleQuote(getDate());
    String sql = "SELECT description FROM JOURNAL WHERE date = $date";

    return (await rawQuery(sql))[0]['description'];
  }

  Future<void> updateJournalEntry(String line) async {
    line = doubleQuote(line);
    String date = doubleQuote(getDate());
    String sql = "UPDATE JOURNAL SET description = $line WHERE date = $date";

    try {
      await rawQuery(sql);
    } on Exception catch (error) {
      print(error);
    }
  }

/* #endregion */

/* #region HABITS */
  Future<List<Map<String, dynamic>>> getHabits() async {
    String sql = "SELECT * FROM HABIT";

    return (await rawQuery(sql));
  }

  Future<bool> didTodaysHabit(int habitID) async {
    String sql =
        "SELECT * FROM HABIT WHERE habitID = $habitID AND lastDate = DATE('now')";

    return (await rawQuery(sql)).length == 0;
  }

  Future<void> insertHabit(String habit) async {
    if (habit.trim() == "") {
      return;
    }

    String sql =
        "INSERT INTO HABIT(habit,startDate,completed) VALUES(${doubleQuote(habit)},DATE('now'),0)";

    await rawQuery(sql);
  }

  Future<void> toggleTodaysHabit(int habitID, bool isMark) async {
    String sql;
    if (isMark) {
      sql =
          "UPDATE HABIT SET completed = (completed + 1), lastDate = DATE('now') WHERE habitID = $habitID";
    } else {
      sql =
          "UPDATE HABIT SET completed = (completed - 1), lastDate = NULL WHERE habitID = $habitID";
    }

    await rawQuery(sql);
  }

  Future<void> deleteHabit(int habitID) async {
    String sql = "DELETE FROM HABIT WHERE habitID = $habitID";

    await rawQuery(sql);
  }

/* #endregion */
}

/* #region Helper Functions */
String getDate() {
  return DateTime.now().toString().split(' ')[0];
}

String getTime() {
  return DateTime.now().toString().split(' ')[1].split('.')[0];
}

bool isTextEmpty(List<String> lines) {
  for (String line in lines) {
    int length = line.length;

    for (int i = 0; i < length; i++) {
      if (line[i] != ' ') return false;
    }
  }

  return true;
}

bool isLineEmpty(String line) {
  line = line.replaceAll(new RegExp(r"\s+\b|\b\s"), "");
  int length = line.length;

  for (int i = 0; i < length; i++) {
    if (!(line[i] == ' ' || line[i] == '\n' || line[i] == '\t')) return false;
  }

  return true;
}

/* #endregion */
