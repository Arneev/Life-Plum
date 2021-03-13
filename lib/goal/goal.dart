import 'package:flutter/material.dart';
import 'classes/randomQuote.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'package:life_plum/helperFiles/database/database.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class GoalPlan extends StatefulWidget {
  @override
  _GoalPlanState createState() => _GoalPlanState();
}

class _GoalPlanState extends State<GoalPlan> {
  RandomQuote randomQuote = RandomQuote();
  DatabaseHelper databaseHelper;

  FocusNode focusNode;
  static String text = "";

  textChange(String line) {
    databaseHelper.attemptInsertJournal(line);
  }

  @override
  void initState() {
    super.initState();

    setState(() {});
    databaseHelper = DatabaseHelper.instance;
    databaseHelper.alreadyJournalEntryIn().then((thereIsEntry) {
      if (thereIsEntry) {
        databaseHelper.getTodaysEntry().then((value) {
          if (value != null) {
            setState(() {
              text = value;
            });
          }
        });
      }
    });

    focusNode = FocusNode();
    KeyboardVisibilityNotification().addNewListener(
      onHide: () {
        setState(() {
          if (focusNode != null) {
            focusNode.unfocus();
            textChange(text);
          }
        });
      },
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 35),
            child: TextFormField(
              style: textBoxTextStyle,
              controller: TextEditingController(text: text),
              minLines: 3,
              maxLines: null,
              focusNode: focusNode,
              autofocus: false,
              onChanged: (newText) {
                setState(() {
                  text = newText;
                  TextEditingController().selection =
                      TextSelection.collapsed(offset: text.length);
                });
              },
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              decoration: textBoxDecorWithEdit(
                  "Journal", "Want to talk about something?"),
            ),
          ),
          randomQuote.randQuoteText,
          Container(
              child: Divider(), margin: EdgeInsets.symmetric(vertical: 15)),
        ],
      ),
    );
  }
}
