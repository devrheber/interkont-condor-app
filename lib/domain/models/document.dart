import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../helpers/helpers.dart';

List<Document> documentsFromJson(String str) =>
    List<Document>.from(json.decode(str).map((x) => Document.fromJson(x)));

String documentsToJson(List<Document> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Document extends Equatable {
  Document({
    this.documento,
    this.extension,
    this.nombre,
    required this.tipoId,
    this.file,
    this.typeName,
  });

  final String? documento;
  final String? extension;
  final String? nombre;
  final int tipoId;
  final File? file;
  final String? typeName;

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        documento: json['documento'],
        extension: json['extension'],
        nombre: json['nombre'],
        tipoId: json['tipoId'],
        typeName: json['typeName'],
      );

  Map<String, dynamic> toJson() => {
        'documento': documento,
        'extension': extension,
        'nombre': nombre,
        'tipoId': tipoId,
        'typeName': typeName,
      };

  Document copyWith({
    String? documento,
    String? extension,
    String? nombre,
    int? tipoId,
    File? file,
    String? typeName,
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

  Future<Document> fromFileString() async {
    assert(documento != null, nombre != null);
    return Document(
      nombre: nombre,
      extension: extension,
      file: await base64StringToFile(
        image: documento!,
        name: nombre!,
        extension: extension!,
      ),
      tipoId: tipoId,
      typeName: typeName,
    );
  }

  Document removeFile() {
    return Document(
      documento: documento,
      extension: null,
      tipoId: tipoId,
      file: null,
      typeName: typeName,
    );
  }

  Document saveCache({required String stringDoc}) {
    return Document(
      nombre: nombre,
      extension: extension,
      tipoId: tipoId,
      typeName: typeName,
      documento: stringDoc,
    );
  }

  @override
  List<Object> get props => [tipoId];
}
