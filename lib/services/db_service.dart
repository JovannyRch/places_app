import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/services/api.dart';
import 'package:uuid/uuid.dart';

class FirebaseDB {
  Api afiliadosDB = new Api('afiliados');
  FirebaseDB() {}

  void crearAfiliado(Afiliado afiliado) async {
    afiliadosDB.addDocument(afiliado.toJson());
  }

  Future<List<Afiliado>> getByCategoria(String categoria) async {
    afiliadosDB.getDataCollection();
    return [];
  }
}
