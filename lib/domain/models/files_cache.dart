import 'dart:convert';

import 'complementary_image.dart';
import 'document.dart';

Map<String, FilesCache> filesCacheFromJson(String str) =>
    Map.from(json.decode(str))
        .map((k, v) => MapEntry<String, FilesCache>(k, FilesCache.fromJson(v)));

String filesCacheToJson(Map<String, FilesCache> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class FilesCache {
  const FilesCache({
    this.mainPhoto,
    this.requiredDocuments,
    this.additionalDocuments,
    this.complementaryImages,
  });

  final ComplementaryImage? mainPhoto;
  final List<Document>? requiredDocuments;
  final List<Document>? additionalDocuments;
  final List<ComplementaryImage>? complementaryImages;

  factory FilesCache.fromJson(Map<String, dynamic> json) => FilesCache(
        mainPhoto: ComplementaryImage.fromJson(json['mainPhoto']),
        requiredDocuments: List<Document>.from(
            json['requiredDocuments'].map((x) => Document.fromJson(x))),
        additionalDocuments: List<Document>.from(
            json['additionalDocuments'].map((x) => Document.fromJson(x))),
        complementaryImages: List<ComplementaryImage>.from(
            json['complementaryImages']
                .map((x) => ComplementaryImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'mainPhoto': mainPhoto?.toJson(),
        'requiredDocuments':
            List<dynamic>.from(requiredDocuments?.map((x) => x.toJson()) ?? []),
        'additionalDocuments': List<dynamic>.from(
            additionalDocuments?.map((x) => x.toJson()) ?? []),
        'complementaryImages': List<dynamic>.from(
            complementaryImages?.map((x) => x.toJson()) ?? [])
      };

  FilesCache copyWith({
    ComplementaryImage? mainPhoto,
    List<Document>? requiredDocuments,
    List<Document>? additionalDocuments,
    List<ComplementaryImage>? complementaryImages,
  }) {
    return FilesCache(
      mainPhoto: mainPhoto ?? this.mainPhoto,
      requiredDocuments: requiredDocuments ?? this.requiredDocuments,
      additionalDocuments: additionalDocuments ?? this.additionalDocuments,
      complementaryImages: complementaryImages ?? this.complementaryImages,
    );
  }

  FilesCache removeMainPhoto() {
    return FilesCache(
      mainPhoto: null,
      requiredDocuments: requiredDocuments,
      additionalDocuments: additionalDocuments,
      complementaryImages: complementaryImages,
    );
  }

  FilesCache removeRequiredDocuments() {
    return FilesCache(
      mainPhoto: mainPhoto,
      requiredDocuments: null,
      additionalDocuments: additionalDocuments,
      complementaryImages: complementaryImages,
    );
  }

  FilesCache removeAdditionalDocuments() {
    return FilesCache(
      mainPhoto: mainPhoto,
      requiredDocuments: requiredDocuments,
      additionalDocuments: null,
      complementaryImages: complementaryImages,
    );
  }

  FilesCache removeComplementaryImages() {
    return FilesCache(
      mainPhoto: mainPhoto,
      requiredDocuments: requiredDocuments,
      additionalDocuments: additionalDocuments,
      complementaryImages: null,
    );
  }
}
