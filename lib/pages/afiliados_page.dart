import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places_app/components/afiliados_slider.dart';
import 'package:places_app/models/categoria_model.dart';

CameraPosition _initialPosition =
    CameraPosition(target: LatLng(26.8206, 30.8025));
Completer<GoogleMapController> _controller = Completer();

class AfiliadosPage extends StatefulWidget {
  Categoria categoria;

  AfiliadosPage({this.categoria});
  @override
  _AfiliadosPageState createState() => _AfiliadosPageState();
}

class _AfiliadosPageState extends State<AfiliadosPage> {
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Size _size;

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoria.nombre,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      body: SafeArea(
        child: Container(
          height: _size.height * .9,
          padding: EdgeInsets.only(bottom: 10.0),
          child: Stack(
            children: <Widget>[
              _mapContainer(),
              Positioned(
                child: _afiliandosCarousel(),
                bottom: 5.0,
                left: _size.width * .05,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _afiliandosCarousel() {
    return Container(
      decoration: BoxDecoration(),
      width: _size.width * .9,
      height: _size.height * 0.35,
      child: AfiliadosCarousel(
        categoria: widget.categoria,
      ),
    );
  }

  Widget _mapContainer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      height: _size.height * 0.6,
      child: Placeholder(),
    );
  }
}

/* GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ), */
