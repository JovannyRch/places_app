import 'package:flutter/material.dart';
import 'package:places_app/components/custom_header.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/models/review_model.dart';

class HistorialPage extends StatefulWidget {
  HistorialPage({Key key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  Review r = Review(
    img: DEFAULT_IMAGE,
    fecha: '02 de Oct. 2020',
    negocio: "Avante Llantas La Virgen",
    localizacion: "Santiaguito, 52140 Metepec, Méx.",
    calificacion: 4,
    comentario:
        "Muy ricas las carnitas aparte las salss deliciosas el servicio es excelente.",
  );

  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          CustomHeader(title: "Historial de Afiliados"),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                ...List.generate(4, (index) => _reviewContainer(r)).toList(),
              ],
            ),
          ))
        ],
      )),
    );
    ;
  }

  Widget _iconPlace(String url) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage(
            url,
          ),
        ),
      ),
    );
  }

  Widget _reviewContainer(Review r) {
    return Container(
      width: _size.width * 0.9,
      height: _size.height * 0.15,
      child: Column(
        children: [
          _reviewTitle(r),
          SizedBox(height: 10.0),
          Divider(),
        ],
      ),
    );
  }

  Widget _reviewTitle(Review r) {
    return Row(
      children: [
        Container(
          child: _iconPlace(r.img),
          width: 60.0,
        ),
        SizedBox(
          width: 15.0,
        ),
        Container(
          child: Column(
            children: [
              _title(r.negocio),
              _subtitle(r.localizacion),
              _rating(
                r.calificacion.toDouble(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _subtitle(String text) {
    return Container(
      width: _size.width * 0.7,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      width: _size.width * 0.7,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _rating(double value) {
    List<Widget> stars = [];
    int total = value.toInt();

    int halfs = 0;
    double rest = value - total;

    if (rest >= 0.24) {
      if (rest >= .69)
        total += 1;
      else
        halfs += 1;
    }
    for (int i = 0; i < total; ++i) {
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow.shade700,
      ));
    }

    if (halfs == 1) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow.shade700));
    }

    return Container(
      width: _size.width * 0.7,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          ...stars,
          SizedBox(width: 5.0),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
