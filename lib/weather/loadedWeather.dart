import 'package:flutter/material.dart';
import 'widgets/singleLine.dart';
import 'classes/weatherDecor.dart';

class LoadedWeather extends StatelessWidget {
  const LoadedWeather({
    Key key,
    @required this.weatherBoxDecor,
    @required this.description,
    @required this.feelsLike,
    @required this.tempMin,
    @required this.tempMax,
    @required this.sunrise,
    @required this.sunset,
  }) : super(key: key);

  final WeatherBoxDecor weatherBoxDecor;
  final String description;
  final String feelsLike;
  final String tempMin;
  final String tempMax;
  final String sunrise;
  final String sunset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            decoration: weatherBoxDecor.boxDecor,
            margin: EdgeInsets.only(bottom: 15, top: 25),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetSingleLine(
                                  description, WeatherBoxDecor.textColor),
                              Container(width: 0, height: 0),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              WidgetSingleLine("Feels like $feelsLike \u2103",
                                  WeatherBoxDecor.textColor),
                              Container(width: 0, height: 0),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  WidgetSingleLine("Low $tempMin \u2103",
                                      WeatherBoxDecor.textColor)
                                ],
                              ),
                              Row(
                                children: [
                                  WidgetSingleLine("High $tempMax \u2103",
                                      WeatherBoxDecor.textColor)
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  WidgetSingleLine("Sunrise $sunrise",
                                      WeatherBoxDecor.textColor)
                                ],
                              ),
                              Row(
                                children: [
                                  WidgetSingleLine("Sunset $sunset",
                                      WeatherBoxDecor.textColor)
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
        Divider(),
      ],
    );
  }
}
