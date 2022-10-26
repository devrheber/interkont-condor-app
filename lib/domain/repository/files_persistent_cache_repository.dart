import '../models/models.dart';

abstract class FilesPersistentCacheRepository {
  const FilesPersistentCacheRepository();

  ComplementaryImage? getMainPhoto();

  List<Document> getRequiredDocuments();

  List<Document> getAdditionalDocuments();

  List<ComplementaryImage> getComplementaryImages();

  void setMainPhoto(ComplementaryImage photo);

  void removeMainPhoto();

  void setRequiredDocuments(List<Document> docs);

  void setAdditionalDocuments(List<Document> docs);

  void setComplementaryImages(List<ComplementaryImage> images);

  void saveComplementaryImage(ComplementaryImage image);

  void removeComplementaryImage(ComplementaryImage image);

  void saveRequiredDocument(Document doc);

  void removeRequiredDocument(Document doc);

  void saveAdditionalDocument(Document doc);

  void removeAdditionalDocument(Document doc);

  void clearData();

  void setCurrentProjectCode(int projectCode);

  void removeCacheByCode(int projectCode);
}
