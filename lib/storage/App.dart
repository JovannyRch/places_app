import 'package:flutter/foundation.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/rate_model.dart';
import 'package:places_app/models/usuario_model.dart';
import 'package:places_app/shared/user_preferences.dart';

class AppState with ChangeNotifier {
  List<Rating> _ratings = [];
  Usuario _usuario = Usuario();
  List<Afiliado> _afiliados = [];
  UserPreferences _userPreferences = UserPreferences();
  bool _isInvitado;

  AppState() {
    init();
  }

  set isInvitado(val) {
    this._isInvitado = val;
    notifyListeners();
  }

  bool get isInvitado => this._isInvitado;

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

  List<Afiliado> get afiliados => this._afiliados;

  set afiliados(val) {
    this._afiliados = val;
    notifyListeners();
  }

  void init() async {
    usuario = new Usuario(id: _userPreferences.email);
    isInvitado = _userPreferences.tipoUsuario == "invitado" ||
        _userPreferences.tipoUsuario.toString().isEmpty;
    updateRatings();
    updateAfiliados();
  }

  void updateRatings() async {
    ratings = await Rating.getByUser(usuario.correo);
  }

  void updateAfiliados() async {
    afiliados = await Afiliado.orderByRating();
  }
}
