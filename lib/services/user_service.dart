import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/usuario_model.dart';
import 'package:places_app/services/api.dart';

class UserService {
  Api api = new Api('usuarios');
  UserService() {}

  Future<void> crearUsuario(Usuario afiliado) async {
    final resp = await api.addDocument(afiliado.toJson());
  }

  Future<String> checkTipousuario(String email) async {
    final resp = await api.getDocumentById(email);
    if (resp.exists) {
      return resp.data()['tipoUsuario'];
    }
    return null;
  }

  Future<Usuario> getUsuario(String email) async {
    final resp = await api.getDocumentById(email);
    if (resp.exists) {
      print('respuestAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
      print(resp);
      return Usuario.fromMap(resp.data(), resp.id);
    }
    return null;
  }

  Future<bool> updateUser(Usuario user, String id) async {
    bool bandera = false;
    final resp = await api
        .addDocumentWithId(id, user.toJson())
        .then((value) => bandera = true)
        .catchError((onError) => bandera = false);
    return bandera;
  }
}
