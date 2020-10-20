import 'package:places_app/services/api.dart';

class Noticia {
  String id;
  String fecha;
  String titulo;
  String contenido;
  String link;
  Noticia({this.id, this.fecha, this.contenido, this.titulo, this.link});

  static Api api = new Api('blogs');

  factory Noticia.fromMap(Map<String, dynamic> json, String id) => Noticia(
      id: id,
      fecha: json["fecha"],
      titulo: json["titulo"],
      contenido: json["contenido"],
      link: json["link"]);
  static Future<List<Noticia>> fetchData() async {
    final resp = await api.getDataCollection();
    return resp.docs.map((doc) => Noticia.fromMap(doc.data(), doc.id)).toList();
  }
}
