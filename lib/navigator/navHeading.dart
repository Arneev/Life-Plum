import 'package:flutter/material.dart';
import 'package:life_plum/helperFiles/style.dart';

class NavHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple[200],
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(top: 45),
              child: Text(
                "Life Plum",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: FancyFontName,
                  fontSize: HeadingTextSize * 1.3,
                ),
              ),
            ),
            SizedBox(
                height: 200,
                width: 200,
                child: Container(
                    margin: EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 15),
                    child: Image.asset("assets/images/logoWhite.png"))),
          ],
        ),
      ),
    );
  }
}
