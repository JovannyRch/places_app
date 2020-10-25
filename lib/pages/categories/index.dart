import 'package:flutter/material.dart';
import 'package:places_app/components/custom_header.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/models/categoria_model.dart';
import 'package:places_app/pages/categories/column.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Categoria> categorias = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    this.initData();
  }

  void initData() async {
    this.categorias = await Categoria.fetchData();
    print(categorias);
    setState(() {
      isLoading = false;
    });
  }

  Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          CustomHeader(title: "Servicios"),
          Expanded(
            child: ColumnCategories(categorias),
          )
        ],
      )),
    );
  }
}
