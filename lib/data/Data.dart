import 'package:places_app/models/categoria_model.dart';

const DEFAULT_IMAGE =
    "https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

class GlobalData {
  static List<Categoria> categorias = [
    Categoria(nombre: "Mecánicos", img: DEFAULT_IMAGE),
    Categoria(nombre: "Grúas", img: DEFAULT_IMAGE),
    Categoria(nombre: "Vulcanizadora", img: DEFAULT_IMAGE),
    Categoria(nombre: "Eléctrico", img: DEFAULT_IMAGE),
    Categoria(nombre: "Alineación y balanceo", img: DEFAULT_IMAGE),
    Categoria(nombre: "Autolavado", img: DEFAULT_IMAGE),
  ];
}
