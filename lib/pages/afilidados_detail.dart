import 'package:flutter/material.dart';
import 'package:places_app/components/fotos_slider.dart';
import 'package:places_app/components/title.dart';
import 'package:places_app/const/const.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/rate_model.dart';
import 'package:places_app/shared/user_preferences.dart';
import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';

class AfiliadosDetailsPage extends StatefulWidget {
  Afiliado afiliado;

  AfiliadosDetailsPage({this.afiliado});

  @override
  _AfiliadosDetailsPageState createState() => _AfiliadosDetailsPageState();
}

class _AfiliadosDetailsPageState extends State<AfiliadosDetailsPage> {
  Size _size;
  BuildContext _context;
  bool isCalificando = false;
  UserPreferences preferences = new UserPreferences();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AppState appState = new AppState();

  setCalificando(bool val) {
    setState(() {
      isCalificando = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    _size = MediaQuery.of(context).size;
    _context = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          widget.afiliado.nombre,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
        child: Stack(
      children: [
        Container(
          height: _size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _fotoMain(),
              TitleComponent("Fotos"),
              FotosSlider(fotos: widget.afiliado.fotos),
              SizedBox(height: 20.0),
              _details(),
            ],
          ),
        ),
        Positioned(
          child: _calificar(),
          bottom: 20.0,
        ),
      ],
    ));
  }

  showAlert(BuildContext context, String title) {
    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(title),
          content: _rating(5),
          actions: <Widget>[
            MaterialButton(
              child: Text('Guardar calificación'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      );
    }

    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              title: Text(title),
              content: _rating(5),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Ok'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ));
  }

  void handleCalificar(int calificacion) {
    //print("Calificacion $calificacion");
    Rating rating = new Rating(
      rate: calificacion,
      afiliadoId: widget.afiliado.id,
      usuarioId: preferences.email,
      nombreAfiliacion: widget.afiliado.nombre,
      imgNegocio: widget.afiliado.img,
      nombreUsuario: "",
    );
    rating.save();
    appState.updateRatings();
    showInSnackBar("Califición guardada");
    setCalificando(false);
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(value)));
  }

  Widget _rating(double value) {
    List<Widget> stars = [];
    int total = value.toInt();

    int halfs = 0;
    double rest = value - total;

    if (rest >= 0.24) {
      if (rest >= .69)
        total += 1;
      else
        halfs += 1;
    }
    for (int i = 0; i < total; ++i) {
      stars.add(GestureDetector(
        onTap: () {
          handleCalificar(i + 1);
        },
        child: Icon(
          Icons.star,
          color: Colors.yellow.shade700,
          size: 35.0,
        ),
      ));
    }

    if (halfs == 1) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow.shade700));
    }

    return Container(
      height: _size.height * 0.2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ...stars,
          // SizedBox(width: 15.0),
          /* GestureDetector(
            onTap: () {},
            child: Text(
              "$value",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ) */
        ],
      ),
    );
  }

  Widget _calificar() {
    if (isCalificando) {
      return Container(
        width: _size.width * 0.8,
        margin: EdgeInsets.only(
          left: _size.width * 0.1,
        ),
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: _rating(5),
        ),
      );
    }

    return GestureDetector(
      onTap: () => setCalificando(true),
      child: Container(
        width: _size.width * 0.8,
        margin: EdgeInsets.only(
          left: _size.width * 0.1,
        ),
        height: 40.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.yellow[800]),
              SizedBox(width: 10.0),
              Text(
                "Calificar",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _details() {
    return Container(
      child: Row(
        children: [
          Column(
            children: [
              _row(
                Icon(Icons.phone, color: kBaseColor),
                widget.afiliado.telefono,
              ),
              _row(
                Icon(Icons.place, color: kBaseColor),
                widget.afiliado.ubicacion,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _row(Icon icon, String info) {
    if (info == null) return Container();
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(bottom: 10.0),
      width: _size.width * 0.9,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 15.0),
            child: icon,
          ),
          Flexible(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text(
                  info ?? '',
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _fotoMain() {
    return Container(
      height: _size.height * 0.33,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _size.height * 0.25,
            child: Image.network(
              widget.afiliado.img,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            widget.afiliado.nombre,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 27.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
