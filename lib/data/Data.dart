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

const MECANICO =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Fmecanico.jpeg?alt=media&token=a1927787-cab3-438b-91f3-93364c3eb842';
const GRUAS =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Fgruas.jpg?alt=media&token=e80ef955-765f-476b-948e-e87a03ac7c48';
const ELECTRICO =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Felectrico.jpg?alt=media&token=24f791b5-6d94-43ce-95c6-35714abc6535';
const ALINEACION =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Falineacionybalanceo.jpg?alt=media&token=0c5ae9c1-64b0-4a87-8620-4010d993854a';
const VULCANIZADORA =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Fvulcanizadora.jpg?alt=media&token=38aee565-ce21-40a7-837b-34f9cfa0c2de';
const AUTOLAVADO =
    'https://firebasestorage.googleapis.com/v0/b/tta-app-20c4c.appspot.com/o/Categories%2Fautolavado.jpg?alt=media&token=a2e72b35-39af-4aeb-9045-e1ba8915f126';

class GlobalData {
  static List<Categoria> categorias = [
    Categoria(id: "1", nombre: "Mecánicos", imagen: MECANICO),
    Categoria(id: "2", nombre: "Grúas", imagen: GRUAS),
    Categoria(id: "13", nombre: "Vulcanizadora", imagen: VULCANIZADORA),
    Categoria(id: "14", nombre: "Eléctrico", imagen: ELECTRICO),
    Categoria(id: "15", nombre: "Alineación y balanceo", imagen: ALINEACION),
    Categoria(id: "16", nombre: "Autolavado", imagen: AUTOLAVADO),
  ];

  static List<Afiliado> afiliados = [
    Afiliado(
        id: '1',
        nombre: "Avante Llantas La Virgen",
        ubicacion: 'Santiaguito, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    Afiliado(
      id: '2',
      nombre: "Super llantas de Metepec",
      ubicacion: 'De Galeana 78, Santa Cruz, 52140 Metepec, Méx.',
      img: DEFAULT_IMAGE,
      fotos: [IMG1, IMG2, IMG3],
      telefono: '+527225947467',
    ),
    Afiliado(
        id: '1',
        nombre: "Dyna-Mate",
        ubicacion: 'Av Tecnológico 48, Llano Grande, 52149 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    Afiliado(
        id: '1',
        nombre: "Avante Llantas La Virgen",
        ubicacion: 'Santiaguito, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    Afiliado(
        id: '2',
        nombre: "Super llantas de Metepec",
        ubicacion: 'De Galeana 78, Santa Cruz, 52140 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
    Afiliado(
        id: '1',
        nombre: "Dyna-Mate",
        ubicacion: 'Av Tecnológico 48, Llano Grande, 52149 Metepec, Méx.',
        img: DEFAULT_IMAGE,
        fotos: [IMG1, IMG2, IMG3],
        telefono: '+527225947467'),
  ];
}
