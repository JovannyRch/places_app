import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:places_app/data/Data.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/pages/afilidados_detail.dart';

class AfiliadosCarousel extends StatelessWidget {
  Size _size;

  List<AfiliadoModel> afiliados = GlobalData.afiliados;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: afiliados.map((a) {
        return Builder(
          builder: (BuildContext context) {
            return _containerAfiliado(context, a);
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: _size.height * 0.27,
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

  Widget _containerAfiliado(BuildContext context, AfiliadoModel a) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AfiliadosDetailsPage(afiliado: a)),
        )
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Container(
              child: Image.network(a.img),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 5.0,
              ),
              width: double.infinity,
              child: Text(
                a.nombre,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22.0,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
