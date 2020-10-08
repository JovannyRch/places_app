import 'package:flutter/material.dart';

class MenuBar extends StatefulWidget {
  MenuBar();

  @override
  _MenuBarState createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> drawer = {
      "logo": "assets/images/logo.png",
      "background": null,
    };

    return Container(
      color: Colors.grey.shade100,
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height,
      child: Column(
        key: drawer['key'] != null ? Key(drawer['key']) : null,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (drawer['logo'] != null)
                      Container(
                        height: 38,
                        margin:
                            const EdgeInsets.only(bottom: 10, top: 10, left: 5),
                        child: imageContainer(drawer['logo']),
                      ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        Icons.star,
                        size: 20,
                      ),
                      title: Text("Reseñas"),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings, size: 20),
                      title: Text("Configuraciones"),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: const Icon(Icons.pages, size: 20),
                      title: Text("Terminos y condiciones"),
                      onTap: () => {},
                    ),
                    SizedBox(height: 10),
                    ListTile(
                      leading: const Icon(Icons.exit_to_app, size: 20),
                      title: Text("Cerrar sesión"),
                      onTap: () => {},
                    ),
                    SizedBox(height: 54),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget imageContainer(String link) {
    if (link.contains('http://') || link.contains('https://')) {
      return Image.network(
        link,
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      link,
      fit: BoxFit.cover,
    );
  }
}
