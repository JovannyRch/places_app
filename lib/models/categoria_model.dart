import 'package:places_app/services/api.dart';

import 'dart:convert';

class Categoria {
  String id;
  String nombre;
  String imagen;
  Categoria({this.id, this.nombre, this.imagen});

  static Api api = new Api('categorias');

  factory Categoria.fromMap(Map<String, dynamic> json, String id) => Categoria(
        id: id,
        nombre: json["nombre"],
        imagen: json["imagen"],
      );
  static Future<List<Categoria>> fetchData() async {
    final resp = await api.getDataCollection();
    return resp.docs
        .map((doc) => Categoria.fromMap(doc.data(), doc.id))
        .toList();
  }
}
