import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/utils/base64_to_file.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FourthStepProvider extends ChangeNotifier {
  FourthStepProvider({
    @required ProjectsRepository projectRepository,
  }) {
    _projectsRepository = projectRepository;
    loadDocumentsTypes();
  }

  ProjectsRepository _projectsRepository;
  List<File> listaDocumentos = [];
  List<TipoDoc> listaTipoDoc = [];
  List<ComplementaryImage> listaImagenes = [];

  TipoDoc _tipoDocValue;

  TipoDoc get tipoDocValue => _tipoDocValue;

  void addToListaDocumentos(File file) {
    listaDocumentos.add(file);
    notifyListeners();
  }

  set tipoDocValue(TipoDoc value) {
    _tipoDocValue = value;
    notifyListeners();
  }

  Future<void> loadDocumentsTypes() async {
    listaTipoDoc = await _projectsRepository.getTipoDoc();
    // recorrer listaTipoDoc e imprimir el nombre
    listaTipoDoc.forEach((element) {
      print(element.nombre);
    });
    notifyListeners();
  }

  void addDocument(File file) {
    listaDocumentos.add(file);
    notifyListeners();
  }

  void removeDocument(int key) {
    listaDocumentos.removeAt(key);
    notifyListeners();
  }

  Future<void> loadImageToListaImagenes() async {
    // TODO
    final cache = {};
    // var filesFotosComplementarias = cache['filesFotosComplementarias'];
    final List<ComplementaryImage> cacheImages = [];

    if (cacheImages.isEmpty) return;

    cacheImages.forEach((element) async {
      var name = element.name + element.position.toString();
      var file = await base64StringToFile(
        image: element.imageString,
        name: element.name,
        extension: element.type,
      );
      //* si listaImagenes contiene el mismo nombre de archivo, no lo agrega

      if (!listaImagenes.any((imagen) => imagen.name == name)) {
        listaImagenes.add(ComplementaryImage(
          imageFile: file,
          name: file.path.split('/').last.split('.').first,
          position: listaImagenes.length,
        ));
      }
    });

    notifyListeners();
  }

  Future saveImage(XFile picked) async {
    final newImage = ComplementaryImage(
      name: 'imagenesComplementarias',
      imageString: base64Encode(File(picked.path).readAsBytesSync()),
      imageFile: File(picked.path),
      position: listaImagenes.length,
    );

    listaImagenes.add(newImage);
    // TODO save images in cache

    notifyListeners();
  }

  void removeImage(int posicion) {
    //remover imagen de la lista y asignar posición anterior

    listaImagenes.removeWhere((element) => element.position == posicion);
    for (int i = 0; i < listaImagenes.length; i++) {
      listaImagenes[i] = listaImagenes[i].copyWith(position: i);
    }
    
    // TODO save images in cache
    notifyListeners();
  }
}
