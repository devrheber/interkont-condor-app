import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void seleccionarGaleriaCamara(context,
    {void Function() onCameraTap, void Function() onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: Icon(Icons.photo),
                  title: Text('Galeria'),
                  onTap: () => {
                        Navigator.of(context).pop(),
                        onGalleryTap(),
                      }),
              ListTile(
                leading: Icon(FontAwesomeIcons.camera),
                title: Text('Camara'),
                onTap: () => {
                  Navigator.of(context).pop(),
                  onCameraTap(),
                },
              ),
            ],
          ),
        );
      });
}

bool getTypeFile(File document) {
  if (document == null) return false;
  String path = document.path;
  //if is all types of images return false else return true
  return !path.endsWith('.jpg') &&
      !path.endsWith('.jpeg') &&
      !path.endsWith('.png') &&
      !path.endsWith('.gif');
}
