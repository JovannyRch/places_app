import 'package:places_app/models/categoria_model.dart';

const DEFAULT_URL =
    "https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

class GlobalData {
  static List<Categoria> categorias = [
    Categoria(nombre: "Mecánicos", img: DEFAULT_URL),
    Categoria(nombre: "Grúas", img: DEFAULT_URL),
    Categoria(nombre: "Vulcanizadora", img: DEFAULT_URL),
    Categoria(nombre: "Eléctrico", img: DEFAULT_URL),
    Categoria(nombre: "Alineación y balanceo", img: DEFAULT_URL),
    Categoria(nombre: "Autolavado", img: DEFAULT_URL),
  ];
}
