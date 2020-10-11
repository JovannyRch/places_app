import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:places_app/data/Data.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/pages/afilidados_detail.dart';
import 'package:places_app/services/afiliados_service.dart';
import 'package:places_app/services/db_service.dart';

class AfiliadosCarousel extends StatefulWidget {
  @override
  _AfiliadosCarouselState createState() => _AfiliadosCarouselState();
}

class _AfiliadosCarouselState extends State<AfiliadosCarousel> {
  Size _size;
  bool isLoading = false;
  AfiliadosService service = new AfiliadosService();

  List<Afiliado> afiliados = [];

  @override
  void initState() {
    // TODO: implement initState
    loadData();
    super.initState();
  }

  void loadData() async {
    setLoading(true);
    afiliados = await service.loadByRating();
    setLoading(false);
  }

  void setLoading(bool val) {
    setState(() {
      isLoading = val;
    });
  }

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

  Widget _containerAfiliado(BuildContext context, Afiliado a) {
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
              height: _size.height * 0.18,
              width: _size.width * 0.8,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loader.gif',
                image: a.img,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 5.0,
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    a.nombre,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Text("${a.rating}",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 22.0,
                        color: Colors.grey.shade600,
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
