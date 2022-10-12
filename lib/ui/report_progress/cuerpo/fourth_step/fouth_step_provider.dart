import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/utils/base64_to_file.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FourthStepProvider extends ChangeNotifier {
  FourthStepProvider({
    @required ProjectsRepository projectRepository,
    @required ProjectsCacheRepository projectsCacheRepository,
  })  : _projectsRepository = projectRepository,
        _projectsCacheRepository = projectsCacheRepository {
    loadDocumentsTypes();
    cache = _projectsCacheRepository.getCache();
  }


  final ProjectsCacheRepository _projectsCacheRepository;
  final ProjectsRepository _projectsRepository;

  ProjectCache cache;
  List<File> listaDocumentos = [];
  List<TipoDoc> listaTipoDoc = [];
  List<ComplementaryImage> listaImagenes = [];

  get projectCode => this.cache.projectCode;

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

  Future<void> saveImage(XFile picked) async {
    final newImage = ComplementaryImage(
      name: 'imagenesComplementarias',
      imageString: base64Encode(File(picked.path).readAsBytesSync()),
      imageFile: File(picked.path),
      position: listaImagenes.length,
    );

    listaImagenes.add(newImage);

    notifyListeners();

    await _projectsCacheRepository.saveProjectCache(
      projectCode,
      this.cache.copyWith(
            listaImagenes: listaImagenes,
          ),
    );
  }

  Future<void> removeImage(int posicion) async {
    //remover imagen de la lista y asignar posición anterior

    listaImagenes.removeWhere((element) => element.position == posicion);
    for (int i = 0; i < listaImagenes.length; i++) {
      listaImagenes[i] = listaImagenes[i].copyWith(position: i);
    }
    notifyListeners();

    await _projectsCacheRepository.saveProjectCache(
      projectCode,
      this.cache.copyWith(
            listaImagenes: listaImagenes,
          ),
    );
  }

  Future<void> onChangedComment(String value) async {
    await _projectsCacheRepository.saveProjectCache(
      projectCode,
      this.cache.copyWith(
            comment: value,
          ),
    );
  }
}
