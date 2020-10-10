import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  bool withSearcher;
  String title;

  CustomHeader({this.withSearcher = false, this.title});
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

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
                  this.title,
                  style: const TextStyle(
                      fontSize: 27, fontWeight: FontWeight.bold),
                ),
                padding: const EdgeInsets.only(
                    top: 10, left: 10, bottom: 20, right: 10),
              ),
              if (withSearcher)
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
