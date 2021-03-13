import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';
import 'dart:math';

class RandomQuote {
  List<String> quotes = List<String>();

  var randQuoteText;

  RandomQuote() {
    //Add Quotes
    quotes.add("One baby step a day makes a huge change in the future.");
    quotes.add(
        "It's okay to be unproductive sometimes, we all need our chill days.");
    quotes.add("Try to align some of your daily tasks to your life goals.");
    quotes.add(
        "Have you noticed you are more productive when you are happy? Prioritize your happiness.");

    randQuoteText = Container(
      padding: EdgeInsets.all(12.5),
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
      child: Text(
        getRandomQuote(),
        style: TextStyle(
          fontFamily: FontNameDefault,
          color: Colors.white,
          fontSize: MediumTextSize,
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  String getRandomQuote() {
    Random rng = Random();
    int randomNumb = rng.nextInt(quotes.length);

    return quotes[randomNumb];
  }
}
