import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:mime_type/mime_type.dart';
/* import 'package:flutter_image_compress/flutter_image_compress.dart'; */
/* import 'package:compressimage/compressimage.dart'; */

final picker = new ImagePicker();

Future<String> subirImagen(PickedFile imagen) async {
  /*  await CompressImage.compress(imageSrc: imagen.path, desiredQuality: 80); */
  File imgFile = File(imagen.path);

  File compressedFile =
      await FlutterNativeImage.compressImage(imgFile.path, quality: 80);

  final url = Uri.parse(
      'https://api.cloudinary.com/v1_1/jovannyrch/image/upload?upload_preset=ri0byjug');
  final mimeType = mime(compressedFile.path).split('/');

  final imageUploadRequest = http.MultipartRequest('POST', url);

  final file = await http.MultipartFile.fromPath('file', compressedFile.path,
      contentType: MediaType(mimeType[0], mimeType[1]));

  imageUploadRequest.files.add(file);

  final streamResponse = await imageUploadRequest.send();
  final resp = await http.Response.fromStream(streamResponse);

  if (resp.statusCode != 200 && resp.statusCode != 201) {
    return null;
  }

  final respData = json.decode(resp.body);
  return respData['secure_url'];
}

Future<int> showModal(context) async {
  int selection = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(8),
          height: 200,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectionWidget(FontAwesomeIcons.camera, "Tomar foto", 1),
              selectionWidget(
                  FontAwesomeIcons.images, "Cargar de la galería", 2),
            ],
          ),
        );
      });
  return selection;
}

Widget selectionWidget(IconData icon, String text, int result) {
  return GestureDetector(
    child: Container(
      child: Row(
        children: <Widget>[
          FaIcon(
            icon,
            size: 15.0,
          ),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    ),
    onTap: () {
      return result;
    },
  );
}

Future<PickedFile> cargarDeGaleria(BuildContext context) async {
  return await picker.getImage(source: ImageSource.gallery);
}

Future<PickedFile> cargarFoto(BuildContext context, String title,
    {bool isMultipleSource = true, ImageSource src}) async {
  if (!isMultipleSource) {
    return await picker.getImage(source: src);
  }
  final option = await showDialog(
      context: context,
      child: SimpleDialog(
        title: Text(title),
        children: <Widget>[
          SimpleDialogOption(
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      FaIcon(
                        FontAwesomeIcons.camera,
                        size: 15.0,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Text('Tomar foto'),
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
              onPressed: () {
                Navigator.pop(context, 1);
              }),
          SimpleDialogOption(
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.images,
                      size: 15.0,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(
                      child: Text('Elegir una foto de la galería'),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
            onPressed: () {
              Navigator.pop(context, 2);
            },
          ),
        ],
      ));

  /* final option = await showModal(context); */

  if (option == null) return null;
  PickedFile pickedFile;

  switch (option) {
    case 1:
      pickedFile = await picker.getImage(source: ImageSource.camera);
      break;
    case 2:
      pickedFile = await picker.getImage(source: ImageSource.gallery);
      break;
  }
  return pickedFile;
}

Future<String> cargarSubirFoto(BuildContext context) async {
  final option = await showDialog(
      context: context,
      child: SimpleDialog(
        title: Text('Cargar foto'),
        children: <Widget>[
          SimpleDialogOption(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('Tomar foto'),
                  ),
                  FaIcon(
                    FontAwesomeIcons.camera,
                    size: 15.0,
                  )
                ],
              ),
              onPressed: () {
                Navigator.pop(context, 1);
              }),
          SimpleDialogOption(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text('Elegir una foto de la galería'),
                ),
                FaIcon(
                  FontAwesomeIcons.images,
                  size: 15.0,
                )
              ],
            ),
            onPressed: () {
              Navigator.pop(context, 2);
            },
          ),
        ],
      ));

  if (option == null) return null;
  String url;
  PickedFile pickedFile;

  switch (option) {
    case 1:
      pickedFile = await picker.getImage(source: ImageSource.camera);
      break;
    case 2:
      pickedFile = await picker.getImage(source: ImageSource.gallery);
      break;
  }
  url = await subirImagen(pickedFile);
  return url;
}
