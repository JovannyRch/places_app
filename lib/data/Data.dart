import 'package:places_app/models/afiliado_model.dart';
import 'package:places_app/models/categoria_model.dart';

const DEFAULT_IMAGE =
    "https://images.pexels.com/photos/3311574/pexels-photo-3311574.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940";

const IMG1 =
    'https://media.metrolatam.com/2019/08/13/lamborghinihurac-5dc3dbea2634f3c3262dbc4700f01b04-600x400.jpg';

const IMG2 =
    'https://neoauto.com/noticias/wp-content/uploads/2017/03/Autos-deportivos-los-4-modelos-m%C3%A1s-so%C3%B1ados-NeoAuto.com_.jpg';

const IMG3 =
    'https://img.autosblogmexico.com/2019/12/20/hVoAV2LR/bugatti-chiron-8591.png';

class GlobalData {
  static List<Categoria> categorias = [
    Categoria(id: "1", nombre: "Mecánicos", img: DEFAULT_IMAGE),
    Categoria(id: "2", nombre: "Grúas", img: DEFAULT_IMAGE),
    Categoria(id: "13", nombre: "Vulcanizadora", img: DEFAULT_IMAGE),
    Categoria(id: "14", nombre: "Eléctrico", img: DEFAULT_IMAGE),
    Categoria(id: "15", nombre: "Alineación y balanceo", img: DEFAULT_IMAGE),
    Categoria(id: "16", nombre: "Autolavado", img: DEFAULT_IMAGE),
  ];

  static List<AfiliadoModel> afiliados = [
    AfiliadoModel(
        id: '1',
        nombre: "Avante Llantas La Virgen",
        comoLlegar: 'Santiaguito, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    AfiliadoModel(
      id: '2',
      nombre: "Super llantas de Metepec",
      comoLlegar: 'De Galeana 78, Santa Cruz, 52140 Metepec, Méx.',
      img: DEFAULT_IMAGE,
      fotos: [IMG1, IMG2, IMG3],
      telefono: '+527225947467',
    ),
    AfiliadoModel(
        id: '1',
        nombre: "Dyna-Mate",
        comoLlegar: 'Av Tecnológico 48, Llano Grande, 52149 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    AfiliadoModel(
        id: '1',
        nombre: "Avante Llantas La Virgen",
        comoLlegar: 'Santiaguito, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    AfiliadoModel(
        id: '2',
        nombre: "Super llantas de Metepec",
        comoLlegar: 'De Galeana 78, Santa Cruz, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    AfiliadoModel(
        id: '1',
        nombre: "Dyna-Mate",
        comoLlegar: 'Av Tecnológico 48, Llano Grande, 52149 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
  ];
}
