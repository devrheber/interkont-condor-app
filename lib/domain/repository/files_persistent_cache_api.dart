import 'dart:convert';

import 'package:appalimentacion/domain/models/document.dart';
import 'package:appalimentacion/domain/models/complementary_image.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilesPersistentCacheApi extends FilesPersistentCacheRepository {
  FilesPersistentCacheApi({
    @required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  @visibleForTesting
  static const kMainPhotoKey = '__main_photo';
  static const kRequiredDocumentsKey = '__required_documents__';
  static const kAdditionalDocumentsKey = '__additional_documents__';
  static const kComplementaryImagesKey = '__complementary_images__';

  String _getValue(String key) => _plugin.getString(key);
  Future<bool> _setValue(String key, String value) async =>
      _plugin.setString(key, value);

  void _init() {
    final _mainPhoto = _getValue(kMainPhotoKey);
    final _requiredDocuments = _getValue(kRequiredDocumentsKey);
    final _additionalDocuments = _getValue(kAdditionalDocumentsKey);
    final _complementaryImages = _getValue(kComplementaryImagesKey);

    if (_mainPhoto != null) {
      mainPhoto = ComplementaryImage.fromJson(json.decode(_mainPhoto));
    }
  }

  ComplementaryImage mainPhoto;
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];
  List<ComplementaryImage> complementaryImages = [];

  @override
  List<Document> getAdditionalDocuments() {
    final documentString = _getValue(kAdditionalDocumentsKey);
    if (documentString == null) return [];
    additionalDocuments = documentsFromJson(documentString);

    return additionalDocuments;
  }

  @override
  List<ComplementaryImage> getComplementaryImages() {
    final imagesString = _getValue(kComplementaryImagesKey);
    if (imagesString == null) return [];
    complementaryImages = imagesFromJson(imagesString);
    return complementaryImages;
  }

  @override
  ComplementaryImage getMainPhoto() {
    final mainPhotoString = _getValue(kMainPhotoKey);
    if (mainPhotoString == null) return null;
    mainPhoto = ComplementaryImage.fromJson(json.decode(mainPhotoString));
    return mainPhoto;
  }

  @override
  List<Document> getRequiredDocuments() {
    final documentString = _getValue(kRequiredDocumentsKey);
    if (documentString == null) return [];
    requiredDocuments = documentsFromJson(documentString);
    return requiredDocuments;
  }

  @override
  void setAdditionalDocuments(List<Document> docs) {
    additionalDocuments = docs;
    _setValue(kAdditionalDocumentsKey, documentsToJson(additionalDocuments));
  }

  @override
  void setComplementaryImages(List<ComplementaryImage> images) {
    complementaryImages = images;
    _setValue(kComplementaryImagesKey, imagesToJson(complementaryImages));
  }

  @override
  void setMainPhoto(ComplementaryImage photo) {
    mainPhoto = photo;
    _setValue(kMainPhotoKey, json.encode(photo.toJson()));
  }

  @override
  void setRequiredDocuments(List<Document> docs) {
    requiredDocuments = docs;
    _setValue(kRequiredDocumentsKey, documentsToJson(docs));
  }

  @override
  void saveComplementaryImage(ComplementaryImage image) {
    complementaryImages.add(image);
    _setValue(kComplementaryImagesKey, imagesToJson(complementaryImages));
  }

  @override
  void removeComplementaryImage(ComplementaryImage image) {
    complementaryImages.remove(image);
    _setValue(kComplementaryImagesKey, imagesToJson(complementaryImages));
  }

  @override
  void saveRequiredDocument(Document doc) {
    requiredDocuments.add(doc);
    _setValue(kRequiredDocumentsKey, documentsToJson(requiredDocuments));
  }

  @override
  void removeRequiredDocument(Document doc) {
    requiredDocuments.remove(doc);
    _setValue(kRequiredDocumentsKey, documentsToJson(requiredDocuments));
  }

  @override
  void saveAdditionalDocument(Document doc) {
    additionalDocuments.add(doc);
    _setValue(kAdditionalDocumentsKey, documentsToJson(additionalDocuments));
  }

  @override
  void removeAdditionalDocument(Document doc) {
    additionalDocuments.remove(doc);
    _setValue(kAdditionalDocumentsKey, documentsToJson(additionalDocuments));
  }
}
