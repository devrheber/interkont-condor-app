// To parse this JSON data, do
//
//     final uploadFileRequest = uploadFileRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

String uploadFileRequestToJson(UploadFileRequest data) =>
    json.encode(data.toJson());

class UploadFileRequest extends Equatable {
  UploadFileRequest({
    required this.clasificaciondoc,
    required this.file,
    required this.iddocumento,
    required this.idtipodocumento,
    required this.nombredocumento,
    required this.usuarioid,
  });

  final int clasificaciondoc;
  final File file;
  final int iddocumento;
  final int idtipodocumento;
  final String nombredocumento;
  final int usuarioid;

  Map<String, dynamic> toJson() => {
        "clasificaciondoc": clasificaciondoc,
        "iddocumento": iddocumento,
        "idtipodocumento": idtipodocumento,
        "nombredocumento": nombredocumento,
        "usuarioid": usuarioid,
      };

  String get getFileName => file.path.split('/').last;

  String get getFileExtension => getFileName.split('.').last;

  @override
  List<Object?> get props => [
        clasificaciondoc,
        file,
        iddocumento,
        idtipodocumento,
        nombredocumento,
        usuarioid,
      ];
}
