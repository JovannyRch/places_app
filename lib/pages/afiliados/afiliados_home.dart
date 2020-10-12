import 'package:flutter/material.dart';
import 'package:places_app/menu.dart';
import 'package:places_app/routes/routes.dart';
import 'package:places_app/shared/user_preferences.dart';

class AfiliadosHome extends StatefulWidget {
  AfiliadosHome({Key key}) : super(key: key);

  @override
  _AfiliadosHomeState createState() => _AfiliadosHomeState();
}

class _AfiliadosHomeState extends State<AfiliadosHome> {
  UserPreferences preferences = new UserPreferences();
  bool hasAfiliacion = false;
  bool isAprobado = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    hasAfiliacion = preferences.nombreAfiliacion.toString().isNotEmpty;
    if (hasAfiliacion) {
      isAprobado = preferences.afiliacionAprobada;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MenuBar(),
      body: _stack(),
    );
  }

  Widget _enEsperaDeAprobacion() {
    return Center(child: Text("Su solicitud está en revisión."));
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
    Widget body = Container();
    if (hasAfiliacion && !isAprobado) {
      body = _enEsperaDeAprobacion();
    }
    if (hasAfiliacion && isAprobado) {
      body = Center(
        child: Text(preferences.nombreAfiliacion),
      );
    }

    return SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
            child: body));
  }
}
