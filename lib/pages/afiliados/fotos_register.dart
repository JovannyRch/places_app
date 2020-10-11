import 'package:flutter/material.dart';
import 'package:places_app/components/custom_app_bar.dart';

class FotosRegisgter extends StatefulWidget {
  FotosRegisgter({Key key}) : super(key: key);

  @override
  _FotosRegisgterState createState() => _FotosRegisgterState();
}

class _FotosRegisgterState extends State<FotosRegisgter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Subir fotos', center: true),
    );
  }
}
