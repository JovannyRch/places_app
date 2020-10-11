import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/pages/categories/index.dart';
import 'package:places_app/pages/historial_page.dart';
import 'package:places_app/pages/home_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomePage(),
          CategoriesPage(),
          HistorialPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: "Categorías",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Historial",
          ),
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
