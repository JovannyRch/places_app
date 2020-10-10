import 'package:flutter/material.dart';
import 'package:places_app/components/fotos_slider.dart';
import 'package:places_app/components/title.dart';

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
        child: Column(
      children: [
        _fotoMain(),
        SizedBox(height: 10.0),
        TitleComponent("Fotos"),
        FotosSlider(fotos: widget.afiliado.fotos),
        SizedBox(height: 20.0),
        _details(),
      ],
    ));
  }

  Widget _details() {
    return Container(
      child: Column(
        children: [
          _row(Icon(Icons.phone), widget.afiliado.telefono),
        ],
      ),
    );
  }

  Widget _row(Icon icon, String info) {
    return Container(
      width: _size.width * 0.9,
      child: Row(
        children: [
          icon,
          Text(info),
        ],
      ),
    );
  }

  Widget _fotoMain() {
    return Container(
      height: _size.height * 0.4,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Image.network(
        widget.afiliado.img,
        fit: BoxFit.cover,
      ),
    );
  }
}
