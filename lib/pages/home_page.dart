import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:places_app/components/afiliados_slider.dart';
import 'package:places_app/components/noticias_slider.dart';

import 'package:places_app/menu.dart';
import 'package:places_app/models/anuncio.model.dart';
import 'package:places_app/shared/user_preferences.dart';
import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Anuncio> anuncios = [];
  bool isLoading = true;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Size _size;
  UserPreferences preferences = new UserPreferences();

  AppState appState = new AppState();

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    this.anuncios = await Anuncio.fetchData();
    print(anuncios);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    _size = MediaQuery.of(context).size;
    final arg = ModalRoute.of(context).settings.arguments;

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    print('Mensaje recibido desde notificacion $arg');

    return Scaffold(
      key: scaffoldKey,
      resizeToAvoidBottomPadding: false,
      drawer: MenuBar(),
      body: _stack(),
    );
  }

  Widget _stack() {
    return Stack(
      children: <Widget>[
        _body(),
        Positioned(
          left: 10,
          top: 25,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(200.0),
            ),
            child: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => scaffoldKey.currentState.openDrawer(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _publicidad(),
            SizedBox(height: 25.0),
            _title("Afiliados"),
            AfiliadosCarousel(),
            SizedBox(height: 5.0),
            _title("Contenido"),
            NoticiasSlider(),
          ],
        ),
      ),
    );
  }

  Widget _title(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: Colors.grey.shade800,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.3,
        ),
      ),
      margin: EdgeInsets.only(
        bottom: 20.0,
      ),
    );
  }

  Widget _publicidad() {
    return Container(
      height: _size.height < 100 ? _size.height * 0.25 : 250.0,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            anuncios[index].imagen,
            fit: BoxFit.fill,
          );
        },
        autoplay: true,
        itemCount: anuncios.length,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
