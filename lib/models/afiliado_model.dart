import 'dart:ffi';

import 'package:places_app/models/categoria_model.dart';

class AfiliadoModel {
  String id;
  String nombre;
  String img;
  String telefono;
  String ubicacion;
  String rfc;
  String user;
  int puntos;
  int total;
  double calificacion;
  bool aprobado;
  List<String> fotos;
  String categoria;
  AfiliadoModel({
    this.id,
    this.nombre,
    this.img,
    this.telefono,
    this.ubicacion,
    this.fotos,
    this.rfc,
    this.categoria,
    this.user,
    this.puntos = 0,
    this.total = 0,
    this.calificacion = 0.0,
    this.aprobado = false,
  });
}
