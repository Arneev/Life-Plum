import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class GetWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 75,
      decoration: BoxDecoration(
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.amber.withOpacity(0.2),
            offset: Offset(1, 1),
            spreadRadius: 3,
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: EdgeInsets.all(15),
      child: Text(
        "Get Weather",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontFamily: FontNameDefault,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
