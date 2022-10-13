import 'package:appalimentacion/domain/models/document.dart';
import 'package:appalimentacion/domain/models/complementary_image.dart';
import 'package:appalimentacion/domain/repository/non_persistent_cache_repository.dart';

class NonPersistentCacheApi extends NonPersistentCacheRepository {
  ComplementaryImage mainPhoto;
  List<Document> requiredDocuments = [];
  List<Document> additionalDocuments = [];
  List<ComplementaryImage> complementaryImages = [];

  @override
  List<Document> getAdditionalDocuments() {
    return additionalDocuments;
  }

  @override
  List<ComplementaryImage> getComplementaryImages() {
    return complementaryImages;
  }

  @override
  ComplementaryImage getMainPhoto() {
    return mainPhoto;
  }

  @override
  List<Document> getRequiredDocuments() {
    return requiredDocuments;
  }

  @override
  void setAdditionalDocuments(List<Document> docs) {
    additionalDocuments = docs;
  }

  @override
  void setComplementaryImages(List<ComplementaryImage> images) {
    complementaryImages = images;
  }

  @override
  void setMainPhoto(ComplementaryImage photo) {
    mainPhoto = photo;
  }

  @override
  void setRequiredDocuments(List<Document> docs) {
    requiredDocuments = docs;
  }

  @override
  void saveComplementaryImage(ComplementaryImage image) {
    complementaryImages.add(image);
  }

  @override
  void removeComplementaryImage(ComplementaryImage image) {
    complementaryImages.remove(image);
  }

  @override
  void saveRequiredDocument(Document doc) {
    requiredDocuments.add(doc);
  }

  @override
  void removeRequiredDocument(Document doc) {
    requiredDocuments.remove(doc);
  }

  @override
  void saveAdditionalDocument(Document doc) {
    additionalDocuments.add(doc);
  }

  @override
  void removeAdditionalDocument(Document doc) {
    additionalDocuments.remove(doc);
  }
}
