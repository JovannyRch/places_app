import 'package:places_app/services/api.dart';

import 'dart:convert';

class Anuncio {
  String id;
  String imagen;
  Anuncio({this.id, this.imagen});

  static Api api = new Api('anuncios');

  factory Anuncio.fromMap(Map<String, dynamic> json, String id) => Anuncio(
        id: id,
        imagen: json["imagen"],
      );
  static Future<List<Anuncio>> fetchData() async {
    final resp = await api.getDataCollection();
    return resp.docs.map((doc) => Anuncio.fromMap(doc.data(), doc.id)).toList();
  }
}
