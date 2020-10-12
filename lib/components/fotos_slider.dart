import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class FotosSlider extends StatelessWidget {
  List<String> fotos;

  FotosSlider({this.fotos});

  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return CarouselSlider(
      items: fotos.map((f) {
        return Builder(
          builder: (BuildContext context) {
            return _containerFoto(f);
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: _size.width * 0.30,
        aspectRatio: 10 / 9,
        viewportFraction: 0.5,
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

  Widget _containerFoto(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: _size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            height: _size.width * 0.3,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
