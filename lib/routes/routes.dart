import 'package:places_app/pages/home_page.dart';
import 'package:places_app/pages/login_page.dart';

import 'package:flutter/material.dart';
import 'package:places_app/pages/tutorial_page.dart';

final routes = {
  '/': (BuildContext context) => HomePage(),
  'login': (BuildContext context) => LoginPage(),
  'tutorial': (BuildContext context) => TutorialPage()
};
