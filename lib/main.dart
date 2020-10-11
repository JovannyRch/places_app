import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/providers/push_notification_provider.dart';
import 'package:places_app/routes/routes.dart' as routes;
import 'package:places_app/shared/user_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserPreferences userPrefrences = new UserPreferences();
  userPrefrences.email = "jovannyrch@gmail.com";
  userPrefrences.tipoUsuario = "admin";
  await userPrefrences.initPrefs();
  String initialRoute;
  if (userPrefrences.isLogged) {
    initialRoute = routes.home;
  } else {
    initialRoute = routes.login;
  }
  runApp(MyApp(initialRoute));
}

class MyApp extends StatefulWidget {
  final initialRoute;
  MyApp(this.initialRoute);

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
      initialRoute: widget.initialRoute,
      routes: routes.routes,
    );
  }
}
