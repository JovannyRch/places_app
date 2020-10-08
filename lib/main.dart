import 'package:flutter/material.dart';

import 'package:places_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'places app',
      initialRoute: 'login',
      routes: routes,
    );
  }
}
