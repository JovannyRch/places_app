import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/services/api.dart';

class UserService {
  Api api = new Api('usuarios');
  UserService() {}

  void crearUsuario(Afiliado afiliado) async {
    api.addDocument(afiliado.toJson());
  }

  Future<String> checkTipousuario(String email) async {
    final resp = await api.getDocumentById(email);
    if(resp.exists){
      return resp.data()['tipoUsuario'];
    }
    return null;
  }
}
