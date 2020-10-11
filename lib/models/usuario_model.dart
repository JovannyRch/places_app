// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

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

  String id;
  String tipoUsuario;
  String correo;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        id: json["id"],
        tipoUsuario: json["tipoUsuario"],
        correo: json["correo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoUsuario": tipoUsuario,
        "correo": correo,
      };
}
