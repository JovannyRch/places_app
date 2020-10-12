import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/categoria_model.dart';
import 'package:places_app/services/api.dart';
import 'package:uuid/uuid.dart';

class AfiliadosService {
  Api afiliadosDB = new Api('afiliados');
  AfiliadosService() {}

  void crearAfiliado(Afiliado afiliado) async {
    afiliadosDB.addDocument(afiliado.toJson());
  }

  Future<List<Afiliado>> getByCategoria(String categoria) async {
    await afiliadosDB.getDataCollection();
    return [];
  }

  //
  Future<List<Afiliado>> loadByRating() async {
    var result = await afiliadosDB.getDataCollection();
    List<Afiliado> data = [];
    data =
        result.docs.map((doc) => Afiliado.fromMap(doc.data(), doc.id)).toList();
    return data;
  }

  Future<List<Afiliado>> loadByCategoria(Categoria c) async {
    var result = await afiliadosDB.getWhere('categoria', c.nombre);
    List<Afiliado> data = [];
    data =
        result.docs.map((doc) => Afiliado.fromMap(doc.data(), doc.id)).toList();
    return data;
  }

  Future<Afiliado> getByUser(String email) async {
    try {
      final resp = await afiliadosDB.getWhere('user', email);
      if (resp.docs.length > 0) {
        return Afiliado.fromMap(resp.docs.first.data(), resp.docs.first.id);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
