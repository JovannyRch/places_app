import 'package:firebase_database/firebase_database.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:uuid/uuid.dart';

class FirebaseDB {
  final databaseReference = FirebaseDatabase.instance.reference();
  var uuid = Uuid();
  FirebaseDB() {}

  void crearAfiliado(AfiliadoModel afiliado) async {
    await databaseReference.child('afiliados').child(uuid.v1()).set({
      'nombre': afiliado.nombre,
      'img': afiliado.img,
      'fotos': afiliado.fotos,
      'telefono': afiliado.telefono,
      'ubicacion': afiliado.ubicacion,
      'rfc': afiliado.rfc,
      'categoria': afiliado.categoria,
      'user': 'jovannyrch@gmail.com'
    });
  }

  Future<List<AfiliadoModel>> getByCategoria(String categoria) async {
    await databaseReference
        .child('afiliados')
        .once()
        .then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
    return [];
  }
}
