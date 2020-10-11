import 'package:flutter/material.dart';

class TitleComponent extends StatelessWidget {
  String text;

  TitleComponent(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.0),
      margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
      child: Text(
        this.text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          letterSpacing: 1.3,
          fontSize: 23.0,
        ),
      ),
    );
  }
}
