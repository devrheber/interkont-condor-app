import 'dart:convert';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:flutter/foundation.dart';

import 'package:shared_preferences/shared_preferences.dart';

class FilesPersistentCacheApi extends FilesPersistentCacheRepository {
  FilesPersistentCacheApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  int? _currentProjectCode;

  String? get projectCode => _currentProjectCode.toString();

  @visibleForTesting
  static const kFilesCacheKey = '__files_cache__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<bool> _setValue(String key, String value) async =>
      _plugin.setString(key, value);

  void _init() {
    try {
      final cache = _getValue(kFilesCacheKey);

      if (cache == null) return;

      final jsonCache = filesCacheFromJson(cache);

      _filesCache = jsonCache;

    } catch (_) {
      if (kDebugMode) {
        print('ocurrió un error al intentar obtener el cache de archivos');
      }
    }
  }

  Map<String, FilesCache> _filesCache = {};

  @override
  List<Document> getAdditionalDocuments() {
    if (!_filesCache.containsKey(projectCode)) return [];
    final filesCache = _filesCache[projectCode];
    if (filesCache?.additionalDocuments == null) return [];
    return filesCache?.additionalDocuments ?? [];
  }

  @override
  List<ComplementaryImage> getComplementaryImages() {
    if (!_filesCache.containsKey(projectCode)) return [];
    final filesCache = _filesCache[projectCode];
    if (filesCache?.complementaryImages == null) return [];
    return filesCache?.complementaryImages ?? [];
  }

  @override
  ComplementaryImage? getMainPhoto() {
    if (!_filesCache.containsKey(projectCode)) return null;
    final filesCache = _filesCache[projectCode];
    if (filesCache?.mainPhoto == null) return null;

    return filesCache?.mainPhoto;
  }

  @override
  List<Document> getRequiredDocuments() {
    if (!_filesCache.containsKey(projectCode)) return [];
    final filesCache = _filesCache[projectCode];
    if (filesCache?.requiredDocuments == null) return [];

    return filesCache?.requiredDocuments ?? [];
  }

  @override
  void setAdditionalDocuments(List<Document> docs) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.copyWith(additionalDocuments: docs) ??
            FilesCache(
              additionalDocuments: docs,
            );

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void setComplementaryImages(List<ComplementaryImage> images) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.copyWith(complementaryImages: images) ??
            FilesCache(
              complementaryImages: images,
            );

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void setMainPhoto(ComplementaryImage photo) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.copyWith(mainPhoto: photo) ??
            FilesCache(
              mainPhoto: photo,
            );

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void removeMainPhoto() {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.removeMainPhoto() ?? FilesCache();

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void setRequiredDocuments(List<Document> docs) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.copyWith(requiredDocuments: docs) ??
            FilesCache(
              requiredDocuments: docs,
            );

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void saveComplementaryImage(ComplementaryImage image) {
    FilesCache fileCache = _filesCache[projectCode] ?? FilesCache();

    fileCache = fileCache.copyWith(
        complementaryImages: [...fileCache.complementaryImages ?? [], image]);

    _filesCache[projectCode!] = _filesCache[projectCode!]!
        .copyWith(complementaryImages: fileCache.complementaryImages);

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void removeComplementaryImage(ComplementaryImage image) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.removeComplementaryImages() ?? FilesCache();

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void saveRequiredDocument(Document doc) {
    FilesCache fileCache = _filesCache[projectCode] ?? FilesCache();

    fileCache = fileCache.copyWith(
        requiredDocuments: [...fileCache.requiredDocuments ?? [], doc]);

    _filesCache[projectCode!] = _filesCache[projectCode!]!
        .copyWith(requiredDocuments: fileCache.requiredDocuments);

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void removeRequiredDocument(Document doc) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.removeRequiredDocuments() ?? FilesCache();

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void saveAdditionalDocument(Document doc) {
    FilesCache fileCache = _filesCache[projectCode] ?? FilesCache();

    fileCache = fileCache.copyWith(
        additionalDocuments: [...fileCache.additionalDocuments ?? [], doc]);

    _filesCache[projectCode!] = _filesCache[projectCode!]!
        .copyWith(additionalDocuments: fileCache.additionalDocuments);

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void removeAdditionalDocument(Document doc) {
    _filesCache[projectCode!] =
        _filesCache[projectCode!]?.removeAdditionalDocuments() ?? FilesCache();

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }

  @override
  void clearData() {
    _plugin.remove(kFilesCacheKey);

    _filesCache = {};
  }

  @override
  void setCurrentProjectCode(int projectCode) {
    _currentProjectCode = projectCode;
  }

  @override
  void removeCacheByCode(int projectCode) {
    if (!_filesCache.containsKey(projectCode.toString())) return;

    _filesCache.remove(projectCode.toString());

    _setValue(kFilesCacheKey, filesCacheToJson(_filesCache));
  }
}
