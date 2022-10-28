// To parse this JSON data, do
//
//     final aomDatosGenerales = aomDatosGeneralesFromJson(jsonString);

import 'dart:convert';

AomDatosGenerales aomDatosGeneralesFromJson(String str) =>
    AomDatosGenerales.fromJson(json.decode(str));

String aomDatosGeneralesToJson(AomDatosGenerales data) =>
    json.encode(data.toJson());

class AomDatosGenerales {
  AomDatosGenerales({
    required this.id,
    this.fechaInicio,
     this.operadorId,
     this.etapaAom,
     this.polizaAom,
    this.fechaPolizaAom,
     this.obraId,
     this.fechaFinalizacionRecursos,
     this.fechaRecepcionActivos,
    this.construccionContradoId,
    this.aomContradoId,
    this.periodoActualizacion,
    this.fechaActualizacion,
    required this.relacionContratos,
  });

  int id;
  String? fechaInicio;
  int? operadorId;
  String? etapaAom;
  bool? polizaAom;
  dynamic fechaPolizaAom;
  int? obraId;
  String? fechaFinalizacionRecursos;
  String? fechaRecepcionActivos;
  dynamic construccionContradoId;
  dynamic aomContradoId;
  dynamic periodoActualizacion;
  dynamic fechaActualizacion;
  List<RelacionContrato>? relacionContratos;

  factory AomDatosGenerales.fromJson(Map<String, dynamic> json) =>
      AomDatosGenerales(
        id: json["id"],
        fechaInicio: json["fechaInicio"],
        operadorId: json["operadorId"],
        etapaAom: json["etapaAom"],
        polizaAom: json["polizaAom"],
        fechaPolizaAom: json["fechaPolizaAom"],
        obraId: json["obraId"],
        fechaFinalizacionRecursos: json["fechaFinalizacionRecursos"],
        fechaRecepcionActivos: json["fechaRecepcionActivos"],
        construccionContradoId: json["construccionContradoId"],
        aomContradoId: json["aomContradoId"],
        periodoActualizacion: json["periodoActualizacion"],
        fechaActualizacion: json["fechaActualizacion"],
        relacionContratos: json["fechaActualizacion"] == null
            ? []
            : List<RelacionContrato>.from(json["relacionContratos"]
                .map((x) => RelacionContrato.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fechaInicio": fechaInicio,
        "operadorId": operadorId,
        "etapaAom": etapaAom,
        "polizaAom": polizaAom,
        "fechaPolizaAom": fechaPolizaAom,
        "obraId": obraId,
        "fechaFinalizacionRecursos": fechaFinalizacionRecursos,
        "fechaRecepcionActivos": fechaRecepcionActivos,
        "construccionContradoId": construccionContradoId,
        "aomContradoId": aomContradoId,
        "periodoActualizacion": periodoActualizacion,
        "fechaActualizacion": fechaActualizacion,
        "relacionContratos": relacionContratos == null
            ? []
            : List<dynamic>.from(relacionContratos!.map((x) => x.toJson())),
      };
}

class RelacionContrato {
  RelacionContrato({
    required this.id,
    required this.obraOriginal,
    required this.contrato,
    required this.numvalorrelacion,
  });

  int id;
  int obraOriginal;
  Contrato contrato;
  int numvalorrelacion;

  factory RelacionContrato.fromJson(Map<String, dynamic> json) =>
      RelacionContrato(
        id: json["id"],
        obraOriginal: json["obraOriginal"],
        contrato: Contrato.fromJson(json["contrato"]),
        numvalorrelacion: json["numvalorrelacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "obraOriginal": obraOriginal,
        "contrato": contrato.toJson(),
        "numvalorrelacion": numvalorrelacion,
      };
}

class Contrato {
  Contrato({
    required this.id,
    required this.numeroContrato,
    required this.valorDisponible,
    required this.tipoContrato,
  });

  int id;
  String numeroContrato;
  int valorDisponible;
  int tipoContrato;

  factory Contrato.fromJson(Map<String, dynamic> json) => Contrato(
        id: json["id"],
        numeroContrato: json["numeroContrato"],
        valorDisponible: json["valorDisponible"],
        tipoContrato: json["tipoContrato"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "numeroContrato": numeroContrato,
        "valorDisponible": valorDisponible,
        "tipoContrato": tipoContrato,
      };
}
