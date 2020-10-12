import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/models/noticia_model.dart';

class NoticiasSlider extends StatelessWidget {
  Size _size;

  Noticia noticia = Noticia(
    fecha: 'Viernes 02 de Octubre 2020',
    titulo: "Licencia para moticiclistas: contestamos las preguntas sobre",
    contenido:
        "La directora de seguridad vial de la Secreteria  de Movilidad nos dio detalles sobre la nueva licencia A-1",
  );

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _containerNoticia(noticia);
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 150.0,
        aspectRatio: 16 / 9,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: false,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _containerNoticia(Noticia n) {
    return Container(
      width: _size.width * 0.9,
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 15.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              n.fecha,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            width: double.infinity,
            child: Text(
              n.titulo,
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
