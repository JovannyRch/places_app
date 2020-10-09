import 'package:flutter/material.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/models/categoria_model.dart';
import 'package:places_app/pages/categories/column.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Categoria> categorias = GlobalData.categorias;

  Size _size;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: <Widget>[
          renderHeader(),
          Expanded(
            child: ColumnCategories(categorias),
          )
        ],
      )),
    );
  }

  Widget _row(Categoria c1, Categoria c2) {
    return Container(
      width: double.infinity,
      child: Row(
        children: [
          _categoria(c1),
          _categoria(c2),
        ],
      ),
    );
  }

  Widget _appBar() {
    return renderHeader();
  }

  Widget _categoria(Categoria c) {
    return Container(
      width: _size.width * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        children: [
          Image.network(c.img),
          Text(c.nombre),
        ],
      ),
    );
  }

  Widget renderHeader() {
    final screenSize = _size;
    return Container(
      width: screenSize.width,
      child: FittedBox(
        fit: BoxFit.cover,
        child: Container(
          width:
              screenSize.width / (2 / (screenSize.height / screenSize.width)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                child: Text(
                  "Categorias",
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 20, right: 10),
              ),
              if (true)
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).accentColor.withOpacity(0.6),
                  ),
                  onPressed: () {
                    //Navigator.of(context).pushNamed(RouteList.categorySearch);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
