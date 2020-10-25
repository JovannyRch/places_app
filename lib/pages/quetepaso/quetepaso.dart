import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:places_app/const/const.dart';

class QueTePasoPage extends StatelessWidget {
  const QueTePasoPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _title(),
            _containerItems(),
            _cancelButton(context),
          ],
        ),
      )),
    );
  }

  Widget _cancelButton(BuildContext context) {
    return Container(
        child: IconButton(
      icon: Icon(
        Icons.cancel,
        color: kBaseColor,
        size: 35.0,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ));
  }

  Widget _title() {
    return Container(
      child: Text(
        "¿Qué te pasó?",
        style: TextStyle(
          fontSize: 27.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _containerItems() {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _itemMenu("Me paró una patrulla", Icons.policy),
                _itemMenu("Mi carro no está", FontAwesomeIcons.search),
              ],
            ),
            SizedBox(height: 80.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _itemMenu("Tuve un accidente", FontAwesomeIcons.carCrash),
                _itemMenu("Me pusieron la araña", Icons.car_repair),
              ],
            )
          ],
        ));
  }

  Widget _itemMenu(String text, IconData icon) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: FaIcon(
                icon,
                color: kBaseColor,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            text,
            style: TextStyle(
              fontSize: 17.0,
            ),
          ),
        ],
      ),
    );
  }
}
