import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:places_app/data/Data.dart';

class AfiliadosCarousel extends StatelessWidget {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _containerAfiliado();
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

  Widget _containerAfiliado() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            child: Image.network(DEFAULT_IMAGE),
          ),
          Container(
            padding: EdgeInsets.only(
              top: 5.0,
            ),
            width: double.infinity,
            child: Text(
              "Nombre del afiliado",
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
    );
  }
}
