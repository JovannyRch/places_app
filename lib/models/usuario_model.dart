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
    this.correo,
  });

  Api api = new Api('usuarios');

  String id;
  String tipoUsuario;
  String correo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        tipoUsuario: json["tipoUsuario"],
        correo: json["correo"],
      );

  factory Usuario.fromMap(Map<String, dynamic> json, String id) => Usuario(
        id: id,
        tipoUsuario: json["tipoUsuario"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoUsuario": tipoUsuario,
        "correo": correo,
      };

  Future save() async {
    await api.addDocument(this.toJson());
  }
}
