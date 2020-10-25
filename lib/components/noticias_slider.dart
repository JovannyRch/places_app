import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:places_app/components/web_view.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/models/noticia_model.dart';
import 'package:places_app/routes/routes.dart' as routes;
import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NoticiasSlider extends StatefulWidget {
  NoticiasSlider({Key key}) : super(key: key);

  @override
  _NoticiasSliderState createState() => _NoticiasSliderState();
}

class _NoticiasSliderState extends State<NoticiasSlider> {
  Size _size;
  bool isLoading = true;
  List<Noticia> noticias = [];
  AppState _appState;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    this.noticias = await Noticia.fetchData();
    print(noticias);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    _size = MediaQuery.of(context).size;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return CarouselSlider(
      items: noticias.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return _containerNoticia(i);
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
    return GestureDetector(
      onTap: () {
        if (_appState.isInvitado) {
          Navigator.pushNamed(context, routes.login);
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WebViewComponent(n.link)),
          );
        }
      },
      child: Container(
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
            Container(
              margin: EdgeInsets.only(top: 5.0),
              width: double.infinity,
              child: Text(
                n.contenido,
                style: TextStyle(
                  fontSize: 12.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
