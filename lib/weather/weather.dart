import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'loadedWeather.dart';
import 'package:weather/weather.dart';
import 'package:location/location.dart' as officalLocation;
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';
import 'getWeater.dart';
import 'classes/weatherDecor.dart';

class WeatherSection extends StatefulWidget {
  @override
  _WeatherSectionState createState() => _WeatherSectionState();
}

class _WeatherSectionState extends State<WeatherSection> {
  bool isLoading = true;
  String area = "";
  String sunrise = "";
  String sunset = "";
  String description = "";
  String feelsLike = "";
  String tempMin = "";
  String tempMax = "";
  String icon;

  WeatherBoxDecor weatherBoxDecor;

  void settingVals() async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic> weatherInfo = await getWeatherInfo();

      if (weatherInfo == null) {
        Fluttertoast.showToast(
          msg: "Check your internet connection or location",
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        area = weatherInfo["area"];
        sunrise = weatherInfo["sunrise"];
        sunset = weatherInfo["sunset"];
        description = weatherInfo['description'];
        feelsLike = weatherInfo["feelsLike"];
        tempMin = weatherInfo["min"];
        tempMax = weatherInfo["max"];
        icon = weatherInfo['icon'];
        weatherBoxDecor = WeatherBoxDecor(icon);

        setState(() {
          isLoading = false;
        });
      }
    } on Exception {
      setState(() {
        isLoading = true;
      });
      Fluttertoast.showToast(msg: "There was a problem getting weather :(");
    }
  }

  @override
  void initState() {
    super.initState();
    settingVals();
  }

  @override
  Widget build(BuildContext context) {
    return (!isLoading)
        ? LoadedWeather(
            weatherBoxDecor: weatherBoxDecor,
            description: description,
            feelsLike: feelsLike,
            tempMin: tempMin,
            tempMax: tempMax,
            sunrise: sunrise,
            sunset: sunset,
          )
        : InkWell(
            onTap: () => settingVals(),
            child: GetWeather(),
          );
  }
}

// #region Helper Functions
Future<Map<String, dynamic>> getWeatherInfo() async {
  Map<String, dynamic> map = new HashMap();

  Weather weather = await getWeather();

  if (weather == null) {
    return null;
  }

  //Sort data
  String area = weather.areaName;

  String sunrise = addFirstZero((weather.sunrise).hour.toString()) +
      ":" +
      addFirstZero((weather.sunrise).minute.toString());

  String sunset = addFirstZero((weather.sunset).hour.toString()) +
      ":" +
      addFirstZero((weather.sunset).minute.toString());

  String weatherDescription = weather.weatherMain;

  String tempFeelsLike = weather.tempFeelsLike.toString().split(" ")[0];

  String tempMin = weather.tempMin.toString().split(" ")[0];

  String tempMax = weather.tempMax.toString().split(" ")[0];

  String icon = weather.weatherIcon;

  //Set data
  map['area'] = area;
  map['sunrise'] = sunrise;
  map['sunset'] = sunset;
  map['description'] = weatherDescription;
  map['feelsLike'] = tempFeelsLike;
  map['min'] = tempMin;
  map['max'] = tempMax;
  map['icon'] = icon;

  return map;
}

Future<bool> isLocationOn() async {
  return await Geolocator.isLocationServiceEnabled();
}

Future<Position> getPos() async {
  // ignore: avoid_init_to_null
  Position pos = null;

  await LocationPermissions().requestPermissions(
    permissionLevel: LocationPermissionLevel.locationWhenInUse,
  );

  officalLocation.Location location = officalLocation.Location();

  if (!await location.serviceEnabled()) {
    if (!await location.requestService()) {
      return null;
    }
  }

  if (await isLocationOn()) {
    try {
      pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10));
    } on TimeoutException {
      pos = null;
    }
  }

  if (pos == null) {
    pos = await Geolocator.getLastKnownPosition();
  }

  return pos;
}

Future<Weather> getWeather() async {
  WeatherFactory weatherFactory = new WeatherFactory(
      "API_KEY",
      language: Language.ENGLISH);

  Position pos = await getPos();

  if (pos == null) return null;

  Weather weather = await weatherFactory.currentWeatherByLocation(
      pos.latitude, pos.longitude);

  return weather;
}

String addFirstZero(String string) {
  if (string.length == 1) {
    return "0" + string;
  }
  return string;
}

// #endregion
