import 'package:flutter/material.dart';
import 'package:places_app/components/fotos_slider.dart';
import 'package:places_app/components/title.dart';
import 'package:places_app/const/const.dart';

import 'package:places_app/models/afiliado_model.dart';

class AfiliadosDetailsPage extends StatefulWidget {
  AfiliadoModel afiliado;

  AfiliadosDetailsPage({this.afiliado});

  @override
  _AfiliadosDetailsPageState createState() => _AfiliadosDetailsPageState();
}

class _AfiliadosDetailsPageState extends State<AfiliadosDetailsPage> {
  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
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
        Column(
          children: [
            _fotoMain(),
            TitleComponent("Fotos"),
            FotosSlider(fotos: widget.afiliado.fotos),
            SizedBox(height: 20.0),
            _details(),
          ],
        ),
        Positioned(
          child: _calificar(),
          bottom: 20.0,
        ),
      ],
    ));
  }

  Widget _calificar() {
    return Container(
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
                  info,
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
      height: _size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          Image.network(
            widget.afiliado.img,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            width: double.infinity,
            child: Text(
              widget.afiliado.nombre,
              style: TextStyle(
                fontSize: 27.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
