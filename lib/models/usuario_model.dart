// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

import 'package:places_app/services/api.dart';

List<Usuario> usuarioFromJson(String str) =>
    List<Usuario>.from(json.decode(str).map((x) => Usuario.fromJson(x)));

String usuarioToJson(List<Usuario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usuario {
  Usuario({
    this.id = "",
    this.tipoUsuario = "normal",
  });

  Api api = new Api('usuarios');

  String id;
  String tipoUsuario;
  String correo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        tipoUsuario: json["tipoUsuario"],
      );

  factory Usuario.fromMap(Map<String, dynamic> json, String id) => Usuario(
        id: id,
        tipoUsuario: json["tipoUsuario"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoUsuario": tipoUsuario,
      };

  Future save(String id) async {
    await api.addDocumentWithId(id, this.toJson());
  }

  Future<Usuario> fetchData(String id) async {
    print("Init fetchData");
    final resp = await api.getDocumentById(id);
    print("Resp");
    print(resp);
    return Usuario.fromJson(resp.data());
  }
}
