import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FourthStepProvider extends ChangeNotifier {
  FourthStepProvider({
    @required ProjectsRepository projectRepository,
    @required ProjectsCacheRepository projectsCacheRepository,
    @required FilesPersistentCacheRepository nonPersistentCacheRepository,
  })  : _projectsRepository = projectRepository,
        _projectsCacheRepository = projectsCacheRepository,
        _filesPersistentCacheRepository = nonPersistentCacheRepository {
    getDocumentTypes();
    cache = _projectsCacheRepository.getCache();

    loadFilesFromCacheNonPersistent();
  }

  final ProjectsCacheRepository _projectsCacheRepository;
  final ProjectsRepository _projectsRepository;
  final FilesPersistentCacheRepository _filesPersistentCacheRepository;

  ProjectCache cache;

  ComplementaryImage mainPhoto;
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];
  List<TipoDoc> listaTipoDoc = [];
  List<ComplementaryImage> complementaryImages = [];

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 800),
  );

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

  Future<void> getDocumentTypes() async {
    List<TipoDoc> types = [];
    try {
      gettingTypesDocument = true;
      types = _projectsCacheRepository.getDocumentTypes();

      if (types == null) {
        types = await getDocumentTypesFromRemote();
      }

      listaTipoDoc = types;
      await _loadRequiredDocumentsFromCache(types);
      await _loadAdditionalDocumentsFromCache();

      gettingTypesDocument = false;
    } catch (_) {
      // TODO
      gettingTypesDocument = false;
      if (kDebugMode) {
        print(
            'no se encontró tipos de docs en localstorage y se falló al intentar obtenerlos de funte remota');
      }
    }
  }

  Future<List<TipoDoc>> getDocumentTypesFromRemote() async {
    try {
      final remoteTypesDocument = await _projectsRepository.getTipoDoc();

      _projectsCacheRepository.saveDocumentTypes(remoteTypesDocument);

      return remoteTypesDocument;
    } catch (_) {
      throw '';
    }
  }

  Future<void> _loadRequiredDocumentsFromCache(List<TipoDoc> list) async {
    //* First type document is always required
    list[0] = list[0].copyWith(obligatorio: true);

    for (final doc in list) {
      if (!doc.obligatorio) continue;
      requiredDocuments.add(
        Document(tipoId: doc.id, typeName: doc.nombre),
      );
    }

    final requiredDocumentsCache =
        _filesPersistentCacheRepository.getRequiredDocuments();

    for (int i = 0; i < requiredDocuments.length; i++) {
      final index = requiredDocumentsCache
          .indexWhere((doc) => doc.tipoId == requiredDocuments[i].tipoId);

      if (index < 0) continue;

      final newDocument = await requiredDocumentsCache[index].fromFileString();

      requiredDocuments[i] = newDocument;
    }
  }

  Future<void> _loadAdditionalDocumentsFromCache() async {
    final additionalDocumentsCache =
        _filesPersistentCacheRepository.getAdditionalDocuments();

    inspect(additionalDocumentsCache);

    for (int i = 0; i < additionalDocumentsCache.length; i++) {
      final newDocument = await additionalDocumentsCache[i].fromFileString();

      additionalDocuments.add(newDocument);
    }
  }

  saveMainPhoto(XFile file) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    mainPhoto = ComplementaryImage(
      name: nameExtension.first,
      imageFile: File(file.path),
      type: nameExtension.last,
    );

    notifyListeners();

    _filesPersistentCacheRepository.setMainPhoto(
      mainPhoto.saveCache(
        imageString: base64Encode(File(file.path).readAsBytesSync()),
      ),
    );
  }

  void removeMainPhoto() {
    mainPhoto = null;

    notifyListeners();

    _filesPersistentCacheRepository.removeMainPhoto();
  }

  void addDocument(File file, {@required int index}) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    requiredDocuments[index] = requiredDocuments[index].copyWith(
      file: file,
      nombre: nameExtension.first,
      extension: nameExtension.last,
      typeName: requiredDocuments[index].typeName,
      tipoId: requiredDocuments[index].tipoId,
    );

    notifyListeners();

    _filesPersistentCacheRepository
        .saveRequiredDocument(requiredDocuments[index].saveCache(
      stringDoc: base64Encode(File(file.path).readAsBytesSync()),
    ));
  }

  void removeDocument(int index) {
    requiredDocuments[index] = requiredDocuments[index].removeFile();
    notifyListeners();

    _filesPersistentCacheRepository
        .removeRequiredDocument(requiredDocuments[index]);
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

    // TODO Remove or hide type item from typesDocuments
    _filesPersistentCacheRepository
        .saveAdditionalDocument(additionalDocuments.last.saveCache(
      stringDoc: base64Encode(File(file.path).readAsBytesSync()),
    ));

    inspect(_filesPersistentCacheRepository.getAdditionalDocuments());
  }

  void removeAdditionalDocument(Document document) {
    additionalDocuments.remove(document);
    notifyListeners();

    _filesPersistentCacheRepository.removeAdditionalDocument(document);
  }

  Future<void> loadFilesFromCacheNonPersistent() async {
    final mainPhotoCache = _filesPersistentCacheRepository.getMainPhoto();

    if (mainPhotoCache != null) {
      this.mainPhoto = await mainPhotoCache.fromImageString();
    }

    final imagesCache =
        _filesPersistentCacheRepository.getComplementaryImages();

    for (final image in imagesCache) {
      final newImage = await image.fromImageString();

      complementaryImages.add(newImage);
    }

    notifyListeners();
  }

  Future<void> saveImage(XFile picked) async {
    final List<String> nameExtension = picked.path.split('/').last.split('.');
    final newImage = ComplementaryImage(
      type: nameExtension.last,
      name: nameExtension.first,
      imageFile: File(picked.path),
    );

    complementaryImages.add(newImage);

    notifyListeners();

    _filesPersistentCacheRepository.saveComplementaryImage(newImage.saveCache(
        imageString: base64Encode(
      File(picked.path).readAsBytesSync(),
    )));
  }

  Future<void> removeImage(ComplementaryImage image) async {
    complementaryImages.remove(image);

    notifyListeners();

    _filesPersistentCacheRepository.removeComplementaryImage(image);
  }

  Future<void> onChangedComment(String comment) async {
    debouncer.value = comment;
    debouncer.onValue = (value) async {
      await _projectsCacheRepository.saveProjectCache(
        projectCode,
        this.cache.copyWith(
              comment: value,
            ),
      );
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = comment;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
