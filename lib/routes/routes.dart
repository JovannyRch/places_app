import 'package:places_app/pages/categories/index.dart';
import 'package:places_app/pages/home_page.dart';
import 'package:places_app/pages/login_page.dart';

import 'package:flutter/material.dart';
import 'package:places_app/pages/register_page.dart';
import 'package:places_app/pages/tutorial_page.dart';
import 'package:places_app/screens/home_screen.dart';

final routes = {
  '/': (BuildContext context) => HomePage(),
  'login': (BuildContext context) => LoginPage(),
  'register': (BuildContext context) => RegisterPage(),
  'tutorial': (BuildContext context) => TutorialPage(),
  'categorias': (BuildContext context) => CategoriesPage(),
  'home': (BuildContext context) => HomeScreen(),
};
