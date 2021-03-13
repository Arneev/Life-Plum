import 'package:flutter/material.dart';

import '../../helperFiles/style.dart';

class TileText extends StatelessWidget {
  final String text;
  final void Function() goTo;

  TileText(this.text, this.goTo);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        InkWell(
          onTap: () => goTo(),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.5,
            alignment: Alignment.center,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              color: Colors.purple[200],
              boxShadow: [
                BoxShadow(
                  color: Colors.purple[300].withOpacity(0.2),
                  blurRadius: 8,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediumTextSize,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
