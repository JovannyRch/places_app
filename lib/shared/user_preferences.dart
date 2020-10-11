import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = new UserPreferences._internal();

  UserPreferences._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get email {
    return _prefs.getString("email") ?? '';
  }

  set email(String name) {
    _prefs.setString('email', name);
  }

  get tipoUsuario {
    return _prefs.getString("tipoUsuario") ?? 'normal';
  }

  set tipoUsuario(String tipo) {
    _prefs.setString("tipoUsuario", tipo);
  }

  get nombreAfiliacion {
    return _prefs.getString("nombreAfiliacion") ?? 'normal';
  }

  set nombreAfiliacion(String tipo) {
    _prefs.setString("nombreAfiliacion", tipo);
  }

  get token {
    return _prefs.getInt('token') ?? "";
  }

  set token(String token) {
    _prefs.setString('token', token);
  }

  get isLogged {
    return !this.email.isEmpty;
  }

  factory UserPreferences() {
    return _instance;
  }
}
