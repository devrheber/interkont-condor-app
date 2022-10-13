import 'dart:convert';

import 'dart:io';

List<Document> documentsFromJson(String str) =>
    List<Document>.from(json.decode(str).map((x) => Document.fromJson(x)));

String documentsToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document {
  Document({
    this.documento,
    this.extension,
    this.nombre,
    this.tipoId,
    this.file,
    this.typeName,
  });

  final String documento;
  final String extension;
  final String nombre;
  final int tipoId;
  final File file;
  final String typeName;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documento: json["documento"],
        extension: json["extension"],
        nombre: json["nombre"],
        tipoId: json["tipoId"],
      );

  Map<String, dynamic> toJson() => {
        "documento": documento,
        "extension": extension,
        "nombre": nombre,
        "tipoId": tipoId,
      };

  Document copyWith({
    String documento,
    String extension,
    String nombre,
    int tipoId,
    File file,
    String typeName,
  }) {
    return Document(
      documento: documento ?? this.documento,
      extension: extension ?? this.extension,
      nombre: nombre ?? this.nombre,
      tipoId: tipoId ?? this.tipoId,
      file: file ?? this.file,
      typeName: typeName ?? this.typeName,
    );
  }

  Document removeFile() {
    return Document(
      documento: documento,
      extension: null,
      nombre: nombre,
      tipoId: tipoId,
      file: null,
      typeName: typeName,
    );
  }
}
