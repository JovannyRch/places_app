import 'package:flutter/material.dart';
import 'package:places_app/menu.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments;

    print('Mensaje recibido desde notificacion $arg');

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: MenuBar(),
      appBar: AppBar(
        backgroundColor: Colors.white10,
        title: Text("Home"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("HOME PAGE"),
      ),
    );
  }
}
