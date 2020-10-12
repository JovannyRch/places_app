import 'package:flutter/foundation.dart';
import 'package:places_app/models/rate_model.dart';
import 'package:places_app/models/usuario_model.dart';
import 'package:places_app/shared/user_preferences.dart';

class AppState with ChangeNotifier {
  List<Rating> _ratings = [];
  Usuario _usuario = Usuario();
  UserPreferences _userPreferences = UserPreferences();

  AppState() {
    init();
  }

  List<Rating> get ratings => this._ratings;
  set ratings(val) {
    this._ratings = val;
    notifyListeners();
  }

  Usuario get usuario => this._usuario;

  set usuario(val) {
    this._usuario = val;
    notifyListeners();
  }

  void init() async {
    usuario = new Usuario(id: _userPreferences.email);
    ratings = await Rating.getByUser(usuario.correo);
  }

  void updateRatings() async {
    ratings = await Rating.getByUser(usuario.correo);
  }
}
