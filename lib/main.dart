import 'package:flutter/material.dart';
import 'package:places_app/providers/push_notification_provider.dart';
import 'package:places_app/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = new GlobalKey();

  @override
  void initState() {
    super.initState();

    final pushProvider = new PushNotificationsPovider();
    pushProvider.initNotifications();
    pushProvider.mensajesStream.listen((data) {
      print('argumento desde main: $data');

      //Navigator.pushNamed(context, '/');
      navigatorKey.currentState.pushNamed('/', arguments: data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'places app',
      initialRoute: 'login',
      routes: routes,
    );
  }
}
