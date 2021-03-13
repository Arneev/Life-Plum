import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math';
import 'classes/quoteObj.dart';
import 'quoteWidget.dart';
import 'package:flutter/services.dart' show rootBundle;

class Quote extends StatefulWidget {
  @override
  _QuoteState createState() => _QuoteState();
}

class _QuoteState extends State<Quote> {
  QuoteObj quote;
  bool isLoading = true;

  void loadQuote() async {
    setState(() {
      isLoading = true;
    });

    quote = await ensureQuote();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    quote =
        QuoteObj("Peace comes from within. Do not seek it without.", "Buddha");
    super.initState();
    loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)
        ? QuoteWidget(quote)
        : Container(
            width: 0,
            height: 0,
          );
  }
}

// #region Helper Functions
Future<QuoteObj> ensureQuote() async {
  QuoteObj quoteObj = await getQuote();

  if (quoteObj != null) return quoteObj;

  return new QuoteObj(
      "Peace comes from within. Do not seek it without.", "Buddha");
}

Future<QuoteObj> getQuote() async {
  String quoteJsonFull = await rootBundle.loadString('assets/json/quotes.json');
  var quoteJsonArr = jsonDecode(quoteJsonFull) as List;
  List<QuoteObj> quotes =
      quoteJsonArr.map((quoteJson) => QuoteObj.fromJson(quoteJson)).toList();

  var rng = new Random();
  int quoteIndex = rng.nextInt(quotes.length);

  return quotes[quoteIndex];
}

// #endregion
