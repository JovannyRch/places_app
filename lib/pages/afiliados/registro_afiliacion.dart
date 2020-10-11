import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places_app/components/blur_container.dart';
import 'package:places_app/components/custom_app_bar.dart';
import 'package:places_app/components/fotos_file_slider.dart';
import 'package:places_app/const/const.dart';
import 'package:places_app/data/Data.dart';
import 'package:places_app/helpers/alerts_helper.dart' as alerts;
import 'package:places_app/helpers/fotos_helper.dart';
import 'package:places_app/models/afiliado_model.dart';

import 'package:places_app/services/db_service.dart';
import 'package:smart_select/smart_select.dart';

class RegistroAfiliacion extends StatefulWidget {
  RegistroAfiliacion({Key key}) : super(key: key);

  @override
  _RegistroAfiliacionState createState() => _RegistroAfiliacionState();
}

class _RegistroAfiliacionState extends State<RegistroAfiliacion> {
  Size _size;
  final _formKey = GlobalKey<FormState>();
  PickedFile fotoFile = null;
  bool isLoading = false;
  bool isSaving = false;
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController telefonoCtrl = new TextEditingController();
  TextEditingController ubicacionCtrl = new TextEditingController();
  TextEditingController rfcCtrl = new TextEditingController();
  FirebaseDB db = FirebaseDB();
  List<PickedFile> fotos = [];

  String categoriaValue = '';
  List<S2Choice<String>> options = [
    ...GlobalData.categorias
        .map((e) => S2Choice(value: e.nombre, title: e.nombre))
        .toList()
  ];

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(
        context,
        'Registro de afiliado',
        center: true,
        elevation: 0,
      ),
      body: BlurContainer(
        isLoading: isSaving,
        text: "Registrando afiliación, espere un momento",
        children: [
          _formContainer(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: kBaseColor,
        onPressed: handleRegister,
        label: Text("Terminar registro"),
      ),
    );
  }

  Widget _formContainer() {
    return Form(
      key: _formKey,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            //color: Colors.white,
            color: Colors.white70,
            border: Border.all(
              color: Colors.grey.shade200,
            ),
          ),
          padding: EdgeInsets.all(20.0),
          width: _size.width * 0.8,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _containerImg(),
                TextFormField(
                  controller: nombreCtrl,
                  decoration: InputDecoration(
                    labelText: 'Razon social',
                  ),
                ),
                TextFormField(
                  controller: telefonoCtrl,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Número telefónico',
                  ),
                ),
                TextFormField(
                  controller: rfcCtrl,
                  decoration: InputDecoration(
                    labelText: 'RFC',
                  ),
                ),
                TextFormField(
                  controller: ubicacionCtrl,
                  decoration: InputDecoration(
                    labelText: 'Ubicación',
                  ),
                ),
                SmartSelect<String>.single(
                  title: 'Categoría',
                  value: categoriaValue,
                  choiceItems: options,
                  placeholder: "Seleccionar",
                  onChange: (state) =>
                      setState(() => categoriaValue = state.value),
                ),
                _fotosContainer(),
                /* SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: FlatButton(
                    minWidth: _size.width * 0.4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    color: kBaseColor,
                    onPressed: isSaving ? null : handleRegister,
                    child: Text(
                      "Registrar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ) */
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleAddFoto() async {
    PickedFile file = await cargarFoto(context, "Agregar foto del lugar");
    if (file != null) {
      fotos.add(file);
      setState(() {});
    }
  }

  Widget _fotosContainer() {
    if (fotos.isEmpty) {
      return GestureDetector(
        onTap: handleAddFoto,
        child: Container(
          height: 40.0,
          width: _size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.plus, color: Colors.grey, size: 13.0),
                SizedBox(width: 10.0),
                Text(
                  "Clic para agregar fotos del lugar",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: handleAddFoto,
            child: Container(
              width: _size.width * 0.3,
              height: 30.0,
              margin: EdgeInsets.only(bottom: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(FontAwesomeIcons.plus, color: Colors.grey, size: 13.0),
                  SizedBox(width: 10.0),
                  Text(
                    "Agregar foto",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
          ),
          FotosFileSlider(fotos: fotos),
        ],
      ),
    );
  }

  void setIsSaving(bool val) {
    setState(() {
      isSaving = val;
    });
  }

  void handleRegister() async {
    //TODO: Register
    setIsSaving(true);
    if (categoriaValue == '') {
      //Show Message
      return;
    }

    String urlImg = await subirImagen(fotoFile);
    List<String> urls = [];
    List<Future<String>> fs = fotos.map((e) => subirImagen(e)).toList();
    urls = await Future.wait(fs);

    Afiliado afiliado = new Afiliado(
      id: "",
      nombre: nombreCtrl.text,
      categoria: categoriaValue,
      telefono: telefonoCtrl.text,
      latitud: 0.0,
      longitud: 0.0,
      rfc: rfcCtrl.text,
      img: urlImg,
      fotos: urls,
      user: 'jovannyrch@gmail.com',
      aprobado: false,
    );
    db.crearAfiliado(afiliado);
    alerts.success(context, "Registro exitoso",
        "Su registro será revisado para su aprobación.");
    setIsSaving(false);
  }

  void setLoading(bool val) {
    isLoading = val;
    setState(() {});
  }

  Widget _containerImg() {
    if (isLoading) return CircularProgressIndicator();
    return GestureDetector(
      onTap: () async {
        setLoading(true);
        fotoFile = await cargarDeGaleria(context);
        setLoading(false);
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10.0,
        ),
        height: _size.height * 0.15,
        child: fotoFile == null ? _dottedContainer() : _portada(),
      ),
    );
  }

  Widget _portada() {
    return Image.file(File(fotoFile.path));
  }

  Widget _dottedContainer() {
    return DottedBorder(
      color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.upload_file,
              color: Colors.grey,
            ),
            SizedBox(height: 10.0),
            Text(
              "Cargar foto de portada",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
