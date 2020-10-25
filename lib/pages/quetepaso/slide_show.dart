import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/models/slider_model.dart';
import 'package:provider/provider.dart';
import 'dart:math' as Math;

class SlideShow extends StatelessWidget {
  final int currentPage = 0;
  final List<String> images = [
    "assets/svgs/slide-1.svg",
    "assets/svgs/slide-2.svg",
    "assets/svgs/slide-3.svg",
    "assets/svgs/slide-4.svg",
    "assets/svgs/slide-5.svg"
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => new SliderModel(),
      child: Scaffold(
          body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: _Slides(images),
              ),
              Dots(images.length),
            ],
          ),
        ),
      )),
    );
  }
}

class Dots extends StatelessWidget {
  double pageViewIndex = 0.0;
  final size;
  Dots(this.size);
  @override
  Widget build(BuildContext context) {
    pageViewIndex = Provider.of<SliderModel>(context).currentPage;
    return Container(
      width: double.infinity,
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: genDots(),
      ),
    );
  }

  genDots() {
    List<Widget> res = [];
    for (int i = 0; i < size; i++) {
      res.add(_dot(i));
    }
    return res;
  }

  Widget _dot(int index) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: 12.0,
        height: 12.0,
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
            color: pageViewIndex == index ? kBaseColor : Colors.grey,
            shape: BoxShape.circle));
  }
}

class _Slides extends StatefulWidget {
  final List<String> images;
  _Slides(@required this.images);

  @override
  __SlidesState createState() => __SlidesState();
}

class __SlidesState extends State<_Slides> {
  final PageController pageController = new PageController();

  @override
  void initState() {
    pageController.addListener(() {
      print("Pagina actual: ${pageController.page}");
      //Actualizar la instancia de la clase
      Provider.of<SliderModel>(context, listen: false).currentPage =
          pageController.page.round().toDouble();
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: PageView(
          controller: pageController,
          children: widget.images.map((e) => Slide(e)).toList()),
    );
  }
}

class Slide extends StatelessWidget {
  String svg;
  Slide(this.svg);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(30.0),
        child: SvgPicture.asset(svg));
  }
}
