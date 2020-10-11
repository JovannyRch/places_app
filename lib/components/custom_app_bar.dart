import 'package:flutter/material.dart';

Widget customAppBar(BuildContext context, String title,
    {bool center = false, int elevation = 1}) {
  return AppBar(
    centerTitle: center,
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    elevation: elevation.toDouble(),
  );
}
