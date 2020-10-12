import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/usuario_model.dart';
import 'package:places_app/pages/afiliados/afiliados_home.dart';
import 'package:places_app/pages/categories/index.dart';
import 'package:places_app/pages/historial_page.dart';
import 'package:places_app/pages/home_page.dart';
import 'package:places_app/routes/routes.dart';
import 'package:places_app/services/afiliados_service.dart';
import 'package:places_app/shared/user_preferences.dart';

import 'package:flutter/scheduler.dart';

enum TipoUsuario {
  NORMAL,
  ADMIN,
  AFILIADO,
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isChecking = false;
  UserPreferences preferences = new UserPreferences();
  TipoUsuario tipoUsuario = TipoUsuario.NORMAL;
  Usuario user = new Usuario();
  bool isOnline = false;

  AfiliadosService afiliadosService = new AfiliadosService();

  var connectivityResult;
  @override
  void initState() {
    super.initState();
    //initData();
    check();
  }

  void initData() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      isOnline = true;
    } else {
      isOnline = false;
    }
    setState(() {});
  }

  void check() async {
    setChecking(true);

    String tipoUsrStr = preferences.tipoUsuario;
    if (tipoUsrStr.isEmpty) {
      user = await user.fetchData(preferences.email);
      if (user != null) {
        tipoUsrStr = user.tipoUsuario;
      }
    }

    if (tipoUsrStr == 'afiliado') {
      tipoUsuario = TipoUsuario.AFILIADO;

      Afiliado a = await afiliadosService.getByUser(preferences.email);
      if (a != null) {
        preferences.nombreAfiliacion = a.nombre;
        preferences.afiliacionAprobada = a.aprobado;

        //`preferences.
      } else {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed(registroAfilicacion);
        });
        print("afiliacion no encontrada");
      }
    } else if (tipoUsrStr == 'admin') {
      tipoUsuario = TipoUsuario.ADMIN;
    } else if (tipoUsrStr == 'normal') {
      tipoUsuario = TipoUsuario.NORMAL;
    }
    setChecking(false);
  }

  void setChecking(bool val) {
    setState(() {
      isChecking = val;
    });
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    if (isChecking) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    BottomNavigationBar bottomNavigationBar;
    List<Widget> pages = [];
    if (tipoUsuario == TipoUsuario.NORMAL) {
      pages = [
        HomePage(),
        CategoriesPage(),
        HistorialPage(),
      ];
      bottomNavigationBar = BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_on),
            label: "Categorías",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Historial",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kBaseColor,
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      );
    } else if (tipoUsuario == TipoUsuario.AFILIADO) {
      /*  if (preferences.nombreAfiliacion.toString().isEmpty) {
        Navigator.pushReplacementNamed(context, registroAfilicacion);
        return Container();
      } */

      pages = [
        AfiliadosHome(),
        HistorialPage(),
      ];
      bottomNavigationBar = BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Historial",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kBaseColor,
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      );
    } else {
      //Admin
      bottomNavigationBar = BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Inicio Admin",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Historial Admin",
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kBaseColor,
        onTap: (val) {
          setState(() {
            _selectedIndex = val;
          });
        },
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          ...pages,
        ],
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
