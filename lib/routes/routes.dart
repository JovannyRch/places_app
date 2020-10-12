import 'package:places_app/pages/afiliados/registro_afiliacion.dart';
import 'package:places_app/pages/categories/index.dart';
import 'package:places_app/pages/home_page.dart';
import 'package:places_app/pages/login_page.dart';
import 'package:places_app/pages/reset_password_page.dart';

import 'package:flutter/material.dart';
import 'package:places_app/pages/register_page.dart';
import 'package:places_app/pages/tutorial_page.dart';
import 'package:places_app/screens/home_screen.dart';

const home = "/";
const login = "login";
const register = "register";
const tutorial = "tutorial";
const categorias = "categorias";
const registroAfilicacion = "registroAfiliacion";
const resetPassword = "resetPassword";

final routes = {
  home: (BuildContext context) => HomePage(),
  login: (BuildContext context) => LoginPage(),
  register: (BuildContext context) => RegisterPage(),
  tutorial: (BuildContext context) => TutorialPage(),
  categorias: (BuildContext context) => CategoriesPage(),
  registroAfilicacion: (_) => RegistroAfiliacion(),
  resetPassword: (BuildContext context) => ResetPasswordPage(),
};
