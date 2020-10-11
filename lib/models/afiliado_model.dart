// To parse this JSON data, do
//
//     final afiliado = afiliadoFromJson(jsonString);

import 'dart:convert';

List<Afiliado> afiliadoFromJson(String str) =>
    List<Afiliado>.from(json.decode(str).map((x) => Afiliado.fromJson(x)));

String afiliadoToJson(List<Afiliado> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Afiliado {
  Afiliado({
    this.id,
    this.nombre,
    this.img,
    this.telefono,
    this.rfc,
    this.user,
    this.total = 0,
    this.puntos = 0,
    this.rating = 0.0,
    this.aprobado = false,
    this.fotos,
    this.categoria,
    this.latitud,
    this.longitud,
    this.ubicacion,
  });

  String id;
  String nombre;
  String img;
  String telefono;
  String rfc;
  String user;
  int total;
  int puntos;
  double rating;
  bool aprobado;
  List<String> fotos;
  String categoria;
  double latitud;
  double longitud;
  String ubicacion;

  factory Afiliado.fromJson(Map<String, dynamic> json) => Afiliado(
        id: json["id"],
        nombre: json["nombre"],
        img: json["img"],
        telefono: json["telefono"],
        rfc: json["rfc"],
        user: json["user"],
        total: json["total"],
        puntos: json["puntos"],
        rating: json["rating"],
        aprobado: json["aprobado"],
        fotos: List<String>.from(json["fotos"].map((x) => x)),
        categoria: json["categoria"],
        latitud: json["latitud"],
        longitud: json["longitud"],
        ubicacion: json["ubicacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "img": img,
        "telefono": telefono,
        "rfc": rfc,
        "user": user,
        "total": total,
        "puntos": puntos,
        "rating": rating,
        "aprobado": aprobado,
        "fotos": List<dynamic>.from(fotos.map((x) => x)),
        "categoria": categoria,
        "latitud": latitud,
        "longitud": longitud,
        "ubicacion": ubicacion,
      };
}
