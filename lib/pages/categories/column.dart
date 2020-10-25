import 'package:flutter/material.dart';
import 'package:places_app/models/categoria_model.dart';
import 'package:places_app/pages/afiliados_page.dart';
import 'package:places_app/routes/routes.dart' as routes;
import 'package:places_app/storage/App.dart';
import 'package:provider/provider.dart';

class ColumnCategories extends StatefulWidget {
  final List<Categoria> categories;

  ColumnCategories(this.categories);

  @override
  State<StatefulWidget> createState() {
    return ColumnCategoriesState();
  }
}

class ColumnCategoriesState extends State<ColumnCategories> {
  AppState _appState;

  @override
  Widget build(BuildContext context) {
    _appState = Provider.of<AppState>(context);
    return GridView.builder(
      itemCount: widget.categories.length,
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200.0,
        mainAxisSpacing: 0.0,
        crossAxisSpacing: 0.0,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: _edgeInsetsForIndex(index),
          child: CategoryColumnItem(
            widget.categories[index],
            !_appState.isInvitado,
          ),
        );
      },
    );
  }

  EdgeInsets _edgeInsetsForIndex(int index) {
    if (index % 2 == 0) {
      return const EdgeInsets.only(
          top: 4.0, left: 8.0, right: 4.0, bottom: 4.0);
    } else {
      return const EdgeInsets.only(
          top: 4.0, left: 4.0, right: 8.0, bottom: 4.0);
    }
  }
}

class CategoryColumnItem extends StatelessWidget {
  final Categoria category;
  final bool canTap;
  CategoryColumnItem(this.category, this.canTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        if (canTap)
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AfiliadosPage(categoria: category)),
            )
          }
        else
          {Navigator.pushNamed(context, routes.login)}
      },
      child: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(category.imagen), fit: BoxFit.cover),
              ),
            ),
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.4),
              child: Center(
                child: Text(
                  category.nombre,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
