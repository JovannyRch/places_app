import 'package:flutter/material.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key key}) : super(key: key);

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
