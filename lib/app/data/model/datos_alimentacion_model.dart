// To parse this JSON data, do
//
//     final datosAlimentacion = datosAlimentacionFromJson(jsonString);

import 'dart:convert';

DatosAlimentacion datosAlimentacionFromJson(String str) =>
    DatosAlimentacion.fromJson(json.decode(str));

String datosAlimentacionToJson(DatosAlimentacion data) =>
    json.encode(data.toJson());

class DatosAlimentacion {
  DatosAlimentacion({
    this.limitePorcentajeAtraso,
    this.limitePorcentajeAtrasoAmarillo,
    this.periodos,
    this.actividades,
    this.indicadoresAlcance,
    this.apectosEvaluar,
    this.tiposFactorAtraso,
    this.factoresAtraso,
  });

  final int limitePorcentajeAtraso;
  final int limitePorcentajeAtrasoAmarillo;
  final List<Periodo> periodos;
  final List<Actividade> actividades;
  final List<dynamic> indicadoresAlcance;
  final List<ApectosEvaluar> apectosEvaluar;
  final List<TiposFactorAtraso> tiposFactorAtraso;
  final List<FactoresAtraso> factoresAtraso;

  factory DatosAlimentacion.fromJson(Map<String, dynamic> json) =>
      DatosAlimentacion(
        limitePorcentajeAtraso: json["limitePorcentajeAtraso"],
        limitePorcentajeAtrasoAmarillo: json["limitePorcentajeAtrasoAmarillo"],
        periodos: List<Periodo>.from(
            json["periodos"].map((x) => Periodo.fromJson(x))),
        actividades: List<Actividade>.from(
            json["actividades"].map((x) => Actividade.fromJson(x))),
        indicadoresAlcance:
            List<dynamic>.from(json["indicadoresAlcance"].map((x) => x)),
        apectosEvaluar: List<ApectosEvaluar>.from(
            json["apectosEvaluar"].map((x) => ApectosEvaluar.fromJson(x))),
        tiposFactorAtraso: List<TiposFactorAtraso>.from(
            json["tiposFactorAtraso"]
                .map((x) => TiposFactorAtraso.fromJson(x))),
        factoresAtraso: List<FactoresAtraso>.from(
            json["factoresAtraso"].map((x) => FactoresAtraso.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limitePorcentajeAtraso": limitePorcentajeAtraso,
        "limitePorcentajeAtrasoAmarillo": limitePorcentajeAtrasoAmarillo,
        "periodos": List<dynamic>.from(periodos.map((x) => x.toJson())),
        "actividades": List<dynamic>.from(actividades.map((x) => x.toJson())),
        "indicadoresAlcance":
            List<dynamic>.from(indicadoresAlcance.map((x) => x)),
        "apectosEvaluar":
            List<dynamic>.from(apectosEvaluar.map((x) => x.toJson())),
        "tiposFactorAtraso":
            List<dynamic>.from(tiposFactorAtraso.map((x) => x.toJson())),
        "factoresAtraso":
            List<dynamic>.from(factoresAtraso.map((x) => x.toJson())),
      };
}

class Actividade {
  Actividade({
    this.actividadId,
    this.descripcionActividad,
    this.unidadMedida,
    this.valorUnitario,
    this.cantidadProgramada,
    this.cantidadEjecutada,
    this.valorProgramado,
    this.valorEjecutado,
    this.porcentajeAvance,
    this.cantidadEjecutadaInicial,
    this.valorEjecutadoInicial,
    this.porcentajeAvanceInicial,
  });

  final int actividadId;
  final String descripcionActividad;
  final String unidadMedida;
  final double valorUnitario;
  final int cantidadProgramada;
  final int cantidadEjecutada;
  final double valorProgramado;
  final int valorEjecutado;
  final int porcentajeAvance;
  final int cantidadEjecutadaInicial;
  final int valorEjecutadoInicial;
  final int porcentajeAvanceInicial;

  factory Actividade.fromJson(Map<String, dynamic> json) => Actividade(
        actividadId: json["actividadId"],
        descripcionActividad: json["descripcionActividad"],
        unidadMedida: json["unidadMedida"],
        valorUnitario: json["valorUnitario"]?.toDouble()??0.0,
        cantidadProgramada: json["cantidadProgramada"],
        cantidadEjecutada: json["cantidadEjecutada"],
        valorProgramado: json["valorProgramado"]?.toDouble()??0.0,
        valorEjecutado: json["valorEjecutado"],
        porcentajeAvance: json["porcentajeAvance"],
        cantidadEjecutadaInicial: json["cantidadEjecutadaInicial"],
        valorEjecutadoInicial: json["valorEjecutadoInicial"],
        porcentajeAvanceInicial: json["porcentajeAvanceInicial"],
      );

  Map<String, dynamic> toJson() => {
        "actividadId": actividadId,
        "descripcionActividad": descripcionActividad,
        "unidadMedida": unidadMedida,
        "valorUnitario": valorUnitario,
        "cantidadProgramada": cantidadProgramada,
        "cantidadEjecutada": cantidadEjecutada,
        "valorProgramado": valorProgramado,
        "valorEjecutado": valorEjecutado,
        "porcentajeAvance": porcentajeAvance,
        "cantidadEjecutadaInicial": cantidadEjecutadaInicial,
        "valorEjecutadoInicial": valorEjecutadoInicial,
        "porcentajeAvanceInicial": porcentajeAvanceInicial,
      };
}

class ApectosEvaluar {
  ApectosEvaluar({
    this.aspectoEvaluarId,
    this.descripcionAspectoEvaluar,
  });

  final int aspectoEvaluarId;
  final String descripcionAspectoEvaluar;

  factory ApectosEvaluar.fromJson(Map<String, dynamic> json) => ApectosEvaluar(
        aspectoEvaluarId: json["aspectoEvaluarId"],
        descripcionAspectoEvaluar: json["descripcionAspectoEvaluar"],
      );

  Map<String, dynamic> toJson() => {
        "aspectoEvaluarId": aspectoEvaluarId,
        "descripcionAspectoEvaluar": descripcionAspectoEvaluar,
      };
}

class FactoresAtraso {
  FactoresAtraso({
    this.factorAtrasoId,
    this.factorAtraso,
    this.tipoFactorAtrasoId,
  });

  final int factorAtrasoId;
  final String factorAtraso;
  final int tipoFactorAtrasoId;

  factory FactoresAtraso.fromJson(Map<String, dynamic> json) => FactoresAtraso(
        factorAtrasoId: json["factorAtrasoId"],
        factorAtraso: json["factorAtraso"],
        tipoFactorAtrasoId: json["tipoFactorAtrasoId"],
      );

  Map<String, dynamic> toJson() => {
        "factorAtrasoId": factorAtrasoId,
        "factorAtraso": factorAtraso,
        "tipoFactorAtrasoId": tipoFactorAtrasoId,
      };
}

class Periodo {
  Periodo({
    this.periodoId,
    this.fechaIniPeriodo,
    this.fechaFinPeriodo,
    this.porcentajeProyectado,
  });

  final int periodoId;
  final DateTime fechaIniPeriodo;
  final DateTime fechaFinPeriodo;
  final double porcentajeProyectado;

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
        periodoId: json["periodoId"],
        fechaIniPeriodo: DateTime.parse(json["fechaIniPeriodo"]),
        fechaFinPeriodo: DateTime.parse(json["fechaFinPeriodo"]),
        porcentajeProyectado: json["porcentajeProyectado"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "periodoId": periodoId,
        "fechaIniPeriodo": fechaIniPeriodo.toIso8601String(),
        "fechaFinPeriodo": fechaFinPeriodo.toIso8601String(),
        "porcentajeProyectado": porcentajeProyectado,
      };
}

class TiposFactorAtraso {
  TiposFactorAtraso({
    this.tipoFactorAtrasoId,
    this.tipoFactorAtraso,
  });

  final int tipoFactorAtrasoId;
  final String tipoFactorAtraso;

  factory TiposFactorAtraso.fromJson(Map<String, dynamic> json) =>
      TiposFactorAtraso(
        tipoFactorAtrasoId: json["tipoFactorAtrasoId"],
        tipoFactorAtraso: json["tipoFactorAtraso"],
      );

  Map<String, dynamic> toJson() => {
        "tipoFactorAtrasoId": tipoFactorAtrasoId,
        "tipoFactorAtraso": tipoFactorAtraso,
      };
}
