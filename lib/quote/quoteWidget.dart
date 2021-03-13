import 'package:flutter/material.dart';
import 'package:life_plum/weather/widgets/line_area.dart';
import 'classes/quoteObj.dart';

class QuoteWidget extends StatelessWidget {
  final QuoteObj quote;
  QuoteWidget(this.quote);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.purple[300],
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                color: Colors.purple.withOpacity(0.2),
                offset: Offset(1, 1),
                spreadRadius: 3,
              ),
            ],
          ),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  (quote == null)
                      ? LineText(
                          "Peace comes from within. Do not seek it without.\n")
                      : LineText('"' + quote.text + '"\n'),
                ],
              ),
              Column(
                children: [
                  (quote == null)
                      ? LineText("- Buddha")
                      : (quote.author == null)
                          ? LineText("- Unknown")
                          : (LineText("- " + quote.author)),
                ],
              ),
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}
