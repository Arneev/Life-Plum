import 'package:flutter/material.dart';
import 'widgets/dateWidgets.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/navigator/navbar.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'journalEntry.dart';
import 'widgets/journalHeading.dart';
import 'widgets/noEntries.dart';

//Entire Page
class Journal extends StatefulWidget {
  @override
  _JournalState createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavBar(context, scaffoldKey),
      appBar: MyAppBar,
      body: JournalBody(),
    );
  }
}

//Journal Body
class JournalBody extends StatefulWidget {
  @override
  _JournalBodyState createState() => _JournalBodyState();
}

class _JournalBodyState extends State<JournalBody> {
  static String text = "";
  String month;
  String currMonth;
  FocusNode focusNode;
  DateTime selectedDate;
  DatabaseHelper databaseHelper;
  List<Map<String, dynamic>> journalEntryListMap = null;

  textChange(String line) {
    databaseHelper.attemptPlanInsert(line).then((value) {
      updateEntries();
    });
  }

  void updateEntries() {
    monthToData(dateToSQLDate(DateTime.now())).then((listOfData) {
      setState(() {
        if (listOfData == null || listOfData.length == 0) {
          journalEntryListMap = null;
        } else {
          journalEntryListMap = listOfData;
        }
      });
    });
  }

  @override
  void initState() {
    currMonth = toMonth(DateTime.now().toString().split(' ')[0]);
    month = currMonth;
    super.initState();

    databaseHelper = DatabaseHelper.instance;

    databaseHelper.isTodayPlan().then((isPlanToday) {
      if (isPlanToday) {
        databaseHelper.getTodayPlan().then((value) {
          if (value != null) {
            setState(() {
              text = value;
            });
          }
        });
      }
    });

    focusNode = FocusNode();

    KeyboardVisibilityNotification().addNewListener(onHide: () {
      setState(() {
        if (focusNode != null) {
          focusNode.unfocus();
          textChange(text);
        }
      });
    });

    updateEntries();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  Future<List<Map<String, dynamic>>> monthToData(String date) async {
    return DatabaseHelper.instance.getJournalEntriesWScore(date);
  }

  // #region Pick Month
  void pickingMonth() {
    showMonthPicker(
      context: context,
      firstDate: DateTime(2000, 1, 1),
      lastDate: DateTime(DateTime.now().year, DateTime.now().month),
      initialDate:
          selectedDate ?? DateTime(DateTime.now().year, DateTime.now().month),
      locale: Locale("en"),
    ).then((date) {
      selectedDate = date;
      month = selectedDate.toString().split(' ')[0];
      monthToData(dateToSQLDate(date)).then((listOfData) {
        setState(() {
          if (listOfData == null || listOfData.length == 0) {
            journalEntryListMap = null;
          } else {
            journalEntryListMap = listOfData;
          }
        });
      });
    });
  }
  // #endregion

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.purple[200],
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      JournalHeading(),
                      TextButton(
                        //Month Picker
                        onPressed: pickingMonth,
                        child: Container(
                            padding: EdgeInsets.all(10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white,
                            ),
                            child: Text(
                              "Pick Month",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.purple[200],
                                fontSize: MediumTextSize,
                                fontFamily: FontNameDefault,
                              ),
                            )),
                      ),
                    ],
                  ),
                  (month == currMonth)
                      ? Container(
                          //Day Planner
                          width: MediaQuery.of(context).size.width * 0.9,
                          margin: EdgeInsets.symmetric(vertical: 15),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 2,
                                color: Colors.white.withOpacity(0.3),
                              ),
                            ],
                          ),
                          child: TextFormField(
                            controller: TextEditingController(text: text),
                            minLines: 3,
                            maxLines: null,
                            focusNode: focusNode,
                            autofocus: false,
                            onChanged: (newText) {
                              setState(() {
                                text = newText;
                                TextEditingController().selection =
                                    TextSelection.collapsed(
                                        offset: text.length);
                              });
                            },
                            textInputAction: TextInputAction.newline,
                            textCapitalization: TextCapitalization.sentences,
                            decoration: textBoxDecorWithEdit("Day Planner",
                                "What are your plans for today?"),
                            style: textBoxTextStyle,
                          ),
                        )
                      : Container(width: 0, height: 0),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: JournalEntries(journalEntryListMap),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JournalEntries extends StatefulWidget {
  List<Map<String, dynamic>> journalEntry;

  JournalEntries(this.journalEntry);

  @override
  _JournalEntriesState createState() => _JournalEntriesState();
}

class _JournalEntriesState extends State<JournalEntries> {
  @override
  Widget build(BuildContext context) {
    return (this.widget.journalEntry == null)
        ? NoEntries()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: this.widget.journalEntry.length,
            itemBuilder: (BuildContext context, int index) {
              return JournalEntry(
                this.widget.journalEntry[index]["description"],
                this.widget.journalEntry[index]["ratingScore"],
                this.widget.journalEntry[index]["date"],
                this.widget.journalEntry[index]["plandescription"],
              );
            });
  }
}

// #region Helper Functions

String dateToSQLDate(DateTime date) {
  //Working nicely
  String sDate = date.toString().split(' ')[0].substring(0, 7);
  return "'" + sDate + "'";
}

String toMonth(String string) {
  return string.split('-')[0] + '-' + string.split('-')[1] + '-01';
}
// #endregion
