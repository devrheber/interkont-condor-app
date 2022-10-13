import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/base64_to_file.dart';

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
    // TODO Get Cache no persistente
    loadImageToListaImagenes();
  }

  final ProjectsCacheRepository _projectsCacheRepository;
  final ProjectsRepository _projectsRepository;

  ProjectCache cache;

  ComplementaryImage mainPhoto;
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];
  List<TipoDoc> listaTipoDoc = [];
  List<ComplementaryImage> complementaryImages = [];

  List<File> listaDocumentos = [];

  bool _gettingTypesDocument = false;

  bool get gettingTypesDocument => _gettingTypesDocument;

  get projectCode => this.cache.projectCode;

  TipoDoc _tipoDocValue;

  TipoDoc get tipoDocValue => _tipoDocValue;

  set tipoDocValue(TipoDoc value) {
    _tipoDocValue = value;
    notifyListeners();
  }

  set gettingTypesDocument(bool value) {
    _gettingTypesDocument = value;
    notifyListeners();
  }

  Future<void> loadDocumentsTypes() async {
    gettingTypesDocument = true;
    this.listaTipoDoc = await _projectsRepository.getTipoDoc();

    // TODO Remove
    // TODO El primer tipo de documento es obligatorio
    for (int i = 0; i < 3; i++) {
      listaTipoDoc[i] = listaTipoDoc[i].copyWith(obligatorio: true);
    }

    for (final doc in listaTipoDoc) {
      if (doc.obligatorio) {
        requiredDocuments.add(
          Document(
            tipoId: doc.id,
            typeName: doc.nombre,
          ),
        );
      }
    }

    gettingTypesDocument = false;

  }

  // String base64Image;
  //   Future<void> loadImageToListaImagenes() async {
  //   String fileFotoPrincipal = contenidoWebService[0]['proyectos']
  //       [posListaProySelec]['datos']['fileFotoPrincipal'];
  //   File file = await base64StringToFile(
  //     image: fileFotoPrincipal,
  //     name: 'fotoPrincipal',
  //   );
  //   if (file != null) {
  //     context.read<ReportarAvanceProvider>().listaImagenes.add(file);
  //   }
  //   setState(() {});
  // }

  saveMainPhoto(XFile file) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    mainPhoto = ComplementaryImage(
      name: nameExtension.first,
      imageFile: File(file.path),
      type: nameExtension.last,
    );

    notifyListeners();

    // TODO Save in cache no persistente
    // final imageString = base64Encode(File(picked.path).readAsBytesSync());
  }

  void removeMainPhoto() {
    mainPhoto = null;

    notifyListeners();
    // TODO Remove from cache no persistente
  }

  void addDocument(File file, {@required int index}) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    requiredDocuments[index] = requiredDocuments[index].copyWith(
      file: file,
      nombre: nameExtension.first,
      documento: base64Encode(File(file.path).readAsBytesSync()),
      extension: nameExtension.last,
    );

    notifyListeners();
  }

  void removeDocument(int index) {
    requiredDocuments[index] = requiredDocuments[index].removeFile();
    notifyListeners();
  }

  void addAdditionalDocument(File file) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    additionalDocuments.add(Document(
      documento: base64Encode(File(file.path).readAsBytesSync()),
      tipoId: tipoDocValue.id,
      nombre: nameExtension.first,
      extension: nameExtension.last,
      file: file,
      typeName: tipoDocValue.nombre,
    ));

    tipoDocValue = null;

    notifyListeners();
  }

  void removeAdditionalDocument(Document document) {
    additionalDocuments.remove(document);
    notifyListeners();
  }

  Future<void> loadImageToListaImagenes() async {
    // TODO Load from cache no persistente
    final images = [];

    for (final image in images) {
      final newImage = ComplementaryImage(
          name: image.name,
          imageFile: await base64StringToFile(
            image: image.imageString,
            name: image.name,
            extension: image.type,
          ),
          type: image.type);

      complementaryImages.add(newImage);
    }

    notifyListeners();

    inspect(complementaryImages);
  }

  Future<void> saveImage(XFile picked) async {
    final List<String> nameExtension = picked.path.split('/').last.split('.');
    final newImage = ComplementaryImage(
      type: nameExtension.last,
      name: nameExtension.first,
      imageString: base64Encode(File(picked.path).readAsBytesSync()),
      imageFile: File(picked.path),
    );

    complementaryImages.add(newImage);

    notifyListeners();

    // TODO Save in Cache no persistente

    inspect(_projectsCacheRepository.getCache());
  }

  Future<void> removeImage(ComplementaryImage image) async {
    complementaryImages.remove(image);

    notifyListeners();

    // TODO remove from cache no persistente
  }

  Future<void> onChangedComment(String value) async {
    // TODO Add dobouncer
    await _projectsCacheRepository.saveProjectCache(
      projectCode,
      this.cache.copyWith(
            comment: value,
          ),
    );
  }
}
