// To parse this JSON data, do
//
//     final rating = ratingFromJson(jsonString);

import 'dart:convert';

import 'package:places_app/services/api.dart';

List<Rating> ratingFromJson(String str) =>
    List<Rating>.from(json.decode(str).map((x) => Rating.fromJson(x)));

String ratingToJson(List<Rating> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Rating {
  Rating({
    this.id,
    this.rate,
    this.afiliadoId,
    this.usuarioId,
    this.nombreAfiliacion,
    this.imgNegocio,
    this.nombreUsuario,
  });

  String id;
  int rate;
  String afiliadoId;
  String usuarioId;
  String nombreAfiliacion;
  String imgNegocio;
  String nombreUsuario;

  static Api api = new Api("ratings");

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        rate: json["rate"],
        afiliadoId: json["afiliado_id"],
        usuarioId: json["usuario_id"],
        nombreAfiliacion: json["nombre_afiliacion"],
        imgNegocio: json["img_negocio"],
        nombreUsuario: json["nombre_usuario"],
      );

  factory Rating.fromMap(Map<String, dynamic> json, String id) => Rating(
        id: id,
        rate: json["rate"],
        afiliadoId: json["afiliado_id"],
        usuarioId: json["usuario_id"],
        nombreAfiliacion: json["nombre_afiliacion"],
        imgNegocio: json["img_negocio"],
        nombreUsuario: json["nombre_usuario"],
      );

  Map<String, dynamic> toJson() => {
        /*  "id": id, */
        "rate": rate,
        "afiliado_id": afiliadoId,
        "usuario_id": usuarioId,
        "nombre_afiliacion": nombreAfiliacion,
        "img_negocio": imgNegocio,
        "nombre_usuario": nombreUsuario,
      };

  void save() async {
    api.addDocument(this.toJson());
  }

  static Future<List<Rating>> getByUser(String user) async {
    final resp = await api.getWhere('user_id', user);
    return resp.docs.map((doc) => Rating.fromMap(doc.data(), doc.id)).toList();
  }
}
