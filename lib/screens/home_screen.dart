import 'package:flutter/material.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/pages/categories/index.dart';
import 'package:places_app/pages/home_page.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

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
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Inicio"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            title: Text("Categorías"),
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
