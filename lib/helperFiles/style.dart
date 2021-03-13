import 'package:flutter/material.dart';

const HeadingTextSize = 32.0;
const LargeTextSize = 20.0;
const MediumTextSize = 16.0;
const SmallTextSize = 14.0;

const String FontNameDefault = 'Montserrat';
const String FancyFontName = 'Pacifico';

const Color lightPurple = Color(0xFFCE93D8);
const Color normPurple = Color(0xFFBA68C8);
const Color lightRed = Color(0xFFEF9A9A);
const Color lightDeepPurple = Color(0xFFB39DDB);
const Color darkPurple = Color(0xffab47bc);

const AppBarTextStyle = TextStyle(
  fontFamily: FancyFontName,
  fontWeight: FontWeight.w400,
  fontSize: HeadingTextSize,
  color: Colors.white,
);

const SingleLineTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w300,
  fontSize: MediumTextSize,
  color: Colors.black,
);

// ignore: non_constant_identifier_names
var MyThemeData = ThemeData(
  primarySwatch: Colors.purple,
  primaryTextTheme: TextTheme(headline6: AppBarTextStyle),
);

// ignore: non_constant_identifier_names
var MyAppBar = AppBar(
  title: Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Text(
      'Life Plum',
    ),
  ),
);

InputDecoration textBoxDecorWithEdit(String labelText, String hintText) {
  const Color borderColor = darkPurple;
  return InputDecoration(
    border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    enabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: borderColor),
    ),
    disabledBorder:
        OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    hintText: hintText,
    labelText: labelText,
    labelStyle: TextStyle(
      color: normPurple,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      color: lightPurple,
      fontFamily: FontNameDefault,
      fontWeight: FontWeight.w500,
      fontSize: SmallTextSize,
    ),
  );
}

TextStyle textBoxTextStyle = TextStyle(
  fontFamily: FontNameDefault,
  fontWeight: FontWeight.w500,
  fontSize: SmallTextSize,
);
