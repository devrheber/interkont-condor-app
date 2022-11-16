// To parse this JSON data, do
//
//     final uploadFileResponse = uploadFileResponseFromJson(jsonString);

import 'dart:convert';

UploadFileResponse uploadFileResponseFromJson(String str) =>
    UploadFileResponse.fromJson(json.decode(str));

String uploadFileResponseToJson(UploadFileResponse data) =>
    json.encode(data.toJson());

class UploadFileResponse {
  UploadFileResponse({
    required this.status,
    required this.message,
    required this.id,
  });

  bool status;
  String message;
  int id;

  factory UploadFileResponse.fromJson(Map<String, dynamic> json) =>
      UploadFileResponse(
        status: json["status"],
        message: json["message"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "id": id,
      };
}
