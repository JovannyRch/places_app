import 'package:flutter/material.dart';
import 'package:places_app/components/custom_header.dart';

import 'package:places_app/models/rate_model.dart';

import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';

class HistorialPage extends StatefulWidget {
  HistorialPage({Key key}) : super(key: key);

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Rating> ratings = [];
  Size _size;
  bool loading = false;
  AppState appState = new AppState();

  @override
  void initState() {
    //init();
    super.initState();
  }

  void init() async {}

  setLoading(bool val) {
    setState(() {
      loading = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    appState = Provider.of<AppState>(context);
    ratings = appState.ratings;

    return Scaffold(
      body: loading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Column(
                children: <Widget>[
                  CustomHeader(title: "Historial de calificaciones"),
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10.0),
                        ...ratings.map((r) => _reviewContainer(r)).toList(),
                      ],
                    ),
                  ))
                ],
              ),
            ),
    );
  }

  Widget _iconPlace(String url) {
    return Container(
      width: 60.0,
      height: 60.0,
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.fill,
          image: new NetworkImage(
            url,
          ),
        ),
      ),
    );
  }

  Widget _reviewContainer(Rating r) {
    return Container(
      width: _size.width,
      padding: EdgeInsets.symmetric(horizontal: 7.0),
      height: 130.0,
      child: Column(
        children: [
          _reviewTitle(r),
          SizedBox(height: 10.0),
          Divider(),
        ],
      ),
    );
  }

  Widget _reviewTitle(Rating r) {
    return Row(
      children: [
        Container(
          child: _iconPlace(r.imgNegocio),
          width: 40.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _title(r.nombreAfiliacion),
              _subtitle(r.ubicacion ?? ""),
              _rating(
                r.rate.toDouble(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _subtitle(String text) {
    if (text.isEmpty) return Container();
    return Container(
      width: _size.width * 0.5,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
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
      stars.add(Icon(
        Icons.star,
        color: Colors.yellow.shade700,
      ));
    }

    if (halfs == 1) {
      stars.add(Icon(Icons.star_half, color: Colors.yellow.shade700));
    }

    return Container(
      width: _size.width * 0.7,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        children: <Widget>[
          ...stars,
          SizedBox(width: 5.0),
          Text(
            "$value",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
