// To parse this JSON data, do
//
//     final uploadFileRequest = uploadFileRequestFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

String uploadFileRequestToJson(UploadFileRequest data) =>
    json.encode(data.toJson());

class UploadFileRequest {
  UploadFileRequest({
    required this.clasificaciondoc,
    required this.file,
    required this.iddocumento,
    required this.idtipodocumento,
    required this.nombredocumento,
    required this.usuarioid,
  });

  int clasificaciondoc;
  File file;
  int iddocumento;
  int idtipodocumento;
  String nombredocumento;
  int usuarioid;

  Map<String, dynamic> toJson() => {
        "clasificaciondoc": clasificaciondoc,
        "iddocumento": iddocumento,
        "idtipodocumento": idtipodocumento,
        "nombredocumento": nombredocumento,
        "usuarioid": usuarioid,
      };
}
