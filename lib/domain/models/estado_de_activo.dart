// To parse this JSON data, do
//
//     final estadoDeActivo = estadoDeActivoFromJson(jsonString);

import 'dart:convert';

List<EstadoDeActivo> estadoDeActivoFromJson(String str) =>
    List<EstadoDeActivo>.from(
        json.decode(str).map((x) => EstadoDeActivo.fromJson(x)));

String estadoDeActivoToJson(List<EstadoDeActivo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EstadoDeActivo {
  EstadoDeActivo({
    required this.id,
    required this.strNombreEstado,
    required this.tipoEstado,
  });

  int id;
  String strNombreEstado;
  int tipoEstado;

  factory EstadoDeActivo.fromJson(Map<String, dynamic> json) => EstadoDeActivo(
        id: json["id"],
        strNombreEstado: json["strNombreEstado"],
        tipoEstado: json["tipoEstado"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "strNombreEstado": strNombreEstado,
        "tipoEstado": tipoEstado,
      };
}
