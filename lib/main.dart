import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/providers/push_notification_provider.dart';
import 'package:places_app/routes/routes.dart' as routes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
      theme: ThemeData(primaryColor: kBaseColor),
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'TTA',
      initialRoute: routes.login,
      routes: routes.routes,
    );
  }
}
