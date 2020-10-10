import 'package:places_app/models/categoria_model.dart';

const DEFAULT_IMAGE =
    "https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

class GlobalData {
  static List<Categoria> categorias = [
    Categoria(id: "1", nombre: "Mecánicos", img: DEFAULT_IMAGE),
    Categoria(id: "2", nombre: "Grúas", img: DEFAULT_IMAGE),
    Categoria(id: "13", nombre: "Vulcanizadora", img: DEFAULT_IMAGE),
    Categoria(id: "14", nombre: "Eléctrico", img: DEFAULT_IMAGE),
    Categoria(id: "15", nombre: "Alineación y balanceo", img: DEFAULT_IMAGE),
    Categoria(id: "16", nombre: "Autolavado", img: DEFAULT_IMAGE),
  ];
}
