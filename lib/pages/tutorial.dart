import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  const Tutorial({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorial"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Tutorial"),
      ),
    );
  }
}
