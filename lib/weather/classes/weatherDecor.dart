import 'package:flutter/material.dart';

const String wClear = "assets/images/Pixa/Clear.jpg";
const String wHeavyRain = "assets/images/Pixa/HeavyRain.jpg";
const String wLightRain = "assets/images/Pixa/LightRain.jpg";
const String wLotsClouds = "assets/images/Pixa/LotsClouds.jpg";
const String wMist = "assets/images/Pixa/Mist.jpg";
const String wThunderstorm = "assets/images/Pixa/Thunderstorm.jpg";
const String wSnow = "assets/images/Pixa/Snow.jpg";
const String wStars = "assets/images/Pixa/Stars.jpg";
const String wFewClouds = "assets/images/Pixa/FewClouds.jpg";

class WeatherBoxDecor {
  static String imageLoc = wClear;
  static Color textColor = Colors.black;

  var boxDecor;

  WeatherBoxDecor(String iconCode) {
    switch (iconCode) {
      case "01d": //Clear Sky
        imageLoc = wClear;
        textColor = Colors.black;
        break;
      case "01n": //Starry Night
        imageLoc = wStars;
        textColor = Colors.white;
        break;
      case "02d": //Few Clouds
        imageLoc = wFewClouds;
        textColor = Colors.white;
        break;
      case "02n": //Few Clouds
        imageLoc = wFewClouds;
        textColor = Colors.white;
        break;
      case "03d": //Scattered Clouds
        imageLoc = wLotsClouds;
        textColor = Colors.black;
        break;
      case "03n": //Scattered Clouds
        imageLoc = wLotsClouds;
        textColor = Colors.black;
        break;
      case "04d": //Broken Clouds
        imageLoc = wLotsClouds;
        textColor = Colors.black;
        break;
      case "04n": //Broken Clouds
        imageLoc = wLotsClouds;
        textColor = Colors.black;
        break;
      case "09d": //Shower Rain
        imageLoc = wLightRain;
        textColor = Colors.white;
        break;
      case "09n": //Shower Rain
        imageLoc = wLightRain;
        textColor = Colors.white;
        break;
      case "10d": //Rain
        imageLoc = wHeavyRain;
        textColor = Colors.white;
        break;
      case "10n": //Rain
        imageLoc = wHeavyRain;
        textColor = Colors.white;
        break;
      case "11d": //Thunderstorm
        imageLoc = wThunderstorm;
        textColor = Colors.white;
        break;
      case "11n": //Thunderstorm
        imageLoc = wThunderstorm;
        textColor = Colors.white;
        break;
      case "13d": //Snow
        imageLoc = wSnow;
        textColor = Colors.white;
        break;
      case "13n": //Snow
        imageLoc = wSnow;
        textColor = Colors.white;
        break;
      case "50d": //Mist
        imageLoc = wMist;
        textColor = Colors.black;
        break;
      case "50n": //Mist
        imageLoc = wMist;
        textColor = Colors.black;
        break;
      default:
        imageLoc = wClear;
        textColor = Colors.black;
    }

    boxDecor = BoxDecoration(
      image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7), BlendMode.dstATop),
          image: AssetImage(imageLoc),
          alignment: Alignment.topRight,
          fit: BoxFit.cover),
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: Offset(1, 2),
        ),
      ],
    );
  }
}
