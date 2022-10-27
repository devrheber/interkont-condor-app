// To parse this JSON data, do
//
//     final clasificacion = clasificacionFromJson(jsonString);

import 'dart:convert';

List<Clasificacion> clasificacionFromJson(String str) =>
    List<Clasificacion>.from(
        json.decode(str).map((x) => Clasificacion.fromJson(x)));

String clasificacionToJson(List<Clasificacion> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Clasificacion {
  Clasificacion({
    required this.id,
    required this.categoria,
    required this.descripcion,
    required this.nivelTension,
    required this.vidaUtil,
  });

  int id;
  int categoria;
  String descripcion;
  int nivelTension;
  int vidaUtil;

  factory Clasificacion.fromJson(Map<String, dynamic> json) => Clasificacion(
        id: json["id"],
        categoria: json["categoria"],
        descripcion: json["descripcion"],
        nivelTension: json["nivelTension"],
        vidaUtil: json["vidaUtil"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoria": categoria,
        "descripcion": descripcion,
        "nivelTension": nivelTension,
        "vidaUtil": vidaUtil,
      };
}
