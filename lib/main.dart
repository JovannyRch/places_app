import 'package:flutter/material.dart';
import 'package:places_app/pages/tutorial_page.dart';
import 'package:places_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App TTA',
      debugShowCheckedModeBanner: false,

      //home:  HomePageTemp()
      //home: HomePage()
      initialRoute: '/',
      routes: routes,
      onGenerateRoute: (settings) {
        print('Ruta llamada ${settings.name}');

        return MaterialPageRoute(
            builder: (BuildContext context) => TutorialPage());
      },
    );
  }
}
