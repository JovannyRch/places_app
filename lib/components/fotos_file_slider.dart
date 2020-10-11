import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FotosFileSlider extends StatelessWidget {
  List<PickedFile> fotos;

  FotosFileSlider({this.fotos});

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
        aspectRatio: 10 / 9,
        viewportFraction: 0.5,
        initialPage: 0,
        enableInfiniteScroll: false,
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

  Widget _containerFoto(PickedFile file) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      width: _size.width,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Container(
            height: 150.0,
            width: 300.0,
            child: Image.file(
              File(file.path),
              fit: BoxFit.fitHeight,
            ),
          ),
        ],
      ),
    );
  }
}
