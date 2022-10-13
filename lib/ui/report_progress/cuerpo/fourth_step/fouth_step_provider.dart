import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/non_persistent_cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/helpers/helpers.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FourthStepProvider extends ChangeNotifier {
  FourthStepProvider({
    @required ProjectsRepository projectRepository,
    @required ProjectsCacheRepository projectsCacheRepository,
    @required NonPersistentCacheRepository nonPersistentCacheRepository,
  })  : _projectsRepository = projectRepository,
        _projectsCacheRepository = projectsCacheRepository,
        _nonPersistentCacheRepository = nonPersistentCacheRepository {
    loadDocumentsTypes();
    cache = _projectsCacheRepository.getCache();

    loadFilesFromCacheNonPersistent();
  }

  final ProjectsCacheRepository _projectsCacheRepository;
  final ProjectsRepository _projectsRepository;
  final NonPersistentCacheRepository _nonPersistentCacheRepository;

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

  Future<void> loadDocumentsTypes() async {
    gettingTypesDocument = true;
    final remoteTypesDocument = await _projectsRepository.getTipoDoc();

    // TODO Remove
    // TODO El primer tipo de documento es obligatorio
    for (int i = 0; i < 3; i++) {
      remoteTypesDocument[i] =
          remoteTypesDocument[i].copyWith(obligatorio: true);
    }

    for (final doc in remoteTypesDocument) {
      if (doc.obligatorio) {
        requiredDocuments.add(
          Document(
            tipoId: doc.id,
            typeName: doc.nombre,
          ),
        );
      } else {
        this.listaTipoDoc.add(doc);
      }
    }

    final requiredDocumentsCache =
        _nonPersistentCacheRepository.getRequiredDocuments();

    for (int i = 0; i < requiredDocuments.length; i++) {
      final index = requiredDocumentsCache
          .indexWhere((doc) => doc.tipoId == requiredDocuments[i].tipoId);

      if (index >= 0) {
        final newDoc = Document(
          nombre: requiredDocumentsCache[index].nombre,
          extension: requiredDocumentsCache[index].extension,
          file: await base64StringToFile(
            image: requiredDocumentsCache[index].documento,
            name: requiredDocumentsCache[index].nombre,
            extension: requiredDocumentsCache[index].extension,
          ),
          tipoId: requiredDocumentsCache[index].tipoId,
          typeName: requiredDocumentsCache[index].typeName,
        );

        requiredDocuments[i] = newDoc;
      }
    }

    // TODO Load additional documents, replace only wheter now is not a required document

    gettingTypesDocument = false;
  }

  saveMainPhoto(XFile file) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    mainPhoto = ComplementaryImage(
      name: nameExtension.first,
      imageFile: File(file.path),
      type: nameExtension.last,
    );

    notifyListeners();

    _nonPersistentCacheRepository.setMainPhoto(
      mainPhoto.saveCache(
        imageString: base64Encode(File(file.path).readAsBytesSync()),
      ),
    );
  }

  void removeMainPhoto() {
    mainPhoto = null;

    notifyListeners();

    _nonPersistentCacheRepository.setMainPhoto(null);
  }

  void addDocument(File file, {@required int index}) {
    final List<String> nameExtension = file.path.split('/').last.split('.');
    requiredDocuments[index] = requiredDocuments[index].copyWith(
      file: file,
      nombre: nameExtension.first,
      extension: nameExtension.last,
    );

    notifyListeners();

    _nonPersistentCacheRepository
        .saveRequiredDocument(requiredDocuments[index].saveCache(
      stringDoc: base64Encode(File(file.path).readAsBytesSync()),
    ));
  }

  void removeDocument(int index) {
    requiredDocuments[index] = requiredDocuments[index].removeFile();
    notifyListeners();

    _nonPersistentCacheRepository
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

    // TODO Save in cache Non Persisten
    // _nonPersistentCacheRepository
    //     .saveAdditionalDocument(additionalDocuments.last.saveCache(
    //   stringDoc: base64Encode(File(file.path).readAsBytesSync()),
    // ));
  }

  void removeAdditionalDocument(Document document) {
    additionalDocuments.remove(document);
    notifyListeners();

    // TODO remove
    // _nonPersistentCacheRepository.removeRequiredDocument(document);
  }

  Future<void> loadFilesFromCacheNonPersistent() async {
    final mainPhotoCache = _nonPersistentCacheRepository.getMainPhoto();

    if (mainPhotoCache != null) {
      this.mainPhoto = ComplementaryImage(
        name: mainPhotoCache.name,
        type: mainPhotoCache.type,
        imageFile: await base64StringToFile(
          image: mainPhotoCache.imageString,
          name: mainPhotoCache.name,
          extension: mainPhotoCache.type,
        ),
      );
    }

    final imagesCache = _nonPersistentCacheRepository.getComplementaryImages();

    for (final image in imagesCache) {
      final newImage = ComplementaryImage(
        name: image.name,
        type: image.type,
        imageFile: await base64StringToFile(
          image: image.imageString,
          name: image.name,
          extension: image.type,
        ),
      );

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

    _nonPersistentCacheRepository.saveComplementaryImage(newImage.saveCache(
        imageString: base64Encode(
      File(picked.path).readAsBytesSync(),
    )));
  }

  Future<void> removeImage(ComplementaryImage image) async {
    complementaryImages.remove(image);

    notifyListeners();

    _nonPersistentCacheRepository.removeComplementaryImage(image);
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
