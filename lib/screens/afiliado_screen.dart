import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/pages/afiliados/afiliados_home.dart';
import 'package:places_app/pages/afiliados/resenias.dart';

class AfiliadoScreen extends StatefulWidget {
  AfiliadoScreen({Key key}) : super(key: key);

  @override
  _AfiliadoScreenState createState() => _AfiliadoScreenState();
}

class _AfiliadoScreenState extends State<AfiliadoScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          AfiliadosHome(),
          AfiliadosResenias(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Reseñas"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kBaseColor,
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      ),
    );
  }
}
