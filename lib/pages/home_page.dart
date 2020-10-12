import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:places_app/components/afiliados_slider.dart';
import 'package:places_app/components/noticias_slider.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/menu.dart';
import 'package:places_app/shared/user_preferences.dart';
import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Size _size;
  UserPreferences preferences = new UserPreferences();
  AppState appState = new AppState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    _size = MediaQuery.of(context).size;
    final arg = ModalRoute.of(context).settings.arguments;

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
          child: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => scaffoldKey.currentState.openDrawer(),
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
      height: _size.height * 0.25,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "https://ca-times.brightspotcdn.com/dims4/default/589e1df/2147483647/strip/true/crop/1280x720+0+0/resize/840x473!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F1f%2F22%2F634b5db1fb5e944d75eb6054aeee%2Fhoyla-aut-ford-lanza-una-masiva-campana-public-001",
            fit: BoxFit.fill,
          );
        },
        autoplay: true,
        itemCount: 4,
        pagination: new SwiperPagination(),
      ),
    );
  }
}
