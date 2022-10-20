import 'dart:convert';

import 'package:equatable/equatable.dart';

// List<DatosAlimentacion> projetsDetailFromJson(String str) => List<DatosAlimentacion>.from(json.decode(str).map((x) => DatosAlimentacion.fromJson(x)));

Map<String, DatosAlimentacion> projectsDetailFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, DatosAlimentacion>(k, DatosAlimentacion.fromJson(v)));

String projetsDetailToJson(Map<String, DatosAlimentacion> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

DatosAlimentacion datosAlimentacionFromJson(String str) =>
    DatosAlimentacion.fromJson(json.decode(str));

String datosAlimentacionToJson(DatosAlimentacion data) =>
    json.encode(data.toJson());

class DatosAlimentacion {
  DatosAlimentacion({
    required this.limitePorcentajeAtraso,
    required this.limitePorcentajeAtrasoAmarillo,
    required this.periodos,
    required this.actividades,
    required this.indicadoresAlcance,
    required this.apectosEvaluar,
    required this.tiposFactorAtraso,
    required this.factoresAtraso,
  });

  double limitePorcentajeAtraso;
  double limitePorcentajeAtrasoAmarillo;
  List<Periodo> periodos;
  List<Actividad> actividades;
  List<dynamic> indicadoresAlcance; // TODO List<RangeIndicator>
  List<AspectoEvaluar> apectosEvaluar;
  List<TiposFactorAtraso> tiposFactorAtraso;
  List<FactoresAtraso> factoresAtraso;

  factory DatosAlimentacion.fromJson(Map<String, dynamic> json) =>
      DatosAlimentacion(
        limitePorcentajeAtraso: json["limitePorcentajeAtraso"].toDouble(),
        limitePorcentajeAtrasoAmarillo:
            json["limitePorcentajeAtrasoAmarillo"].toDouble(),
        periodos: List<Periodo>.from(
            json["periodos"].map((x) => Periodo.fromJson(x))),
        actividades: List<Actividad>.from(
            json["actividades"].map((x) => Actividad.fromJson(x))),
        indicadoresAlcance:
            List<dynamic>.from(json["indicadoresAlcance"].map((x) => x)),
        apectosEvaluar: List<AspectoEvaluar>.from(
            json["apectosEvaluar"].map((x) => AspectoEvaluar.fromJson(x))),
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

  // static DatosAlimentacion get empty {
  //   return DatosAlimentacion();
  // }
}

class Actividad {
  Actividad({
    required this.actividadId,
    required this.descripcionActividad,
    required this.unidadMedida,
    required this.valorUnitario,
    required this.cantidadProgramada,
    required this.cantidadEjecutada,
    required this.valorProgramado,
    required this.valorEjecutado,
    required this.porcentajeAvance,
    required this.cantidadEjecutadaInicial,
    required this.valorEjecutadoInicial,
    required this.porcentajeAvanceInicial,
  });

  final int actividadId;
  final String descripcionActividad;
  final String unidadMedida;
  final double valorUnitario;
  final double cantidadProgramada;
  final double cantidadEjecutada;
  final double valorProgramado;
  final double valorEjecutado;
  final double porcentajeAvance;
  final double cantidadEjecutadaInicial;
  final double valorEjecutadoInicial;
  final double porcentajeAvanceInicial;

  factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
        actividadId: json["actividadId"],
        descripcionActividad: json["descripcionActividad"],
        unidadMedida: json["unidadMedida"],
        valorUnitario: json["valorUnitario"].toDouble(),
        cantidadProgramada: json["cantidadProgramada"].toDouble(),
        cantidadEjecutada: json["cantidadEjecutada"] is int
            ? double.parse(json["cantidadEjecutada"])
            : json["cantidadEjecutada"] as double,
        valorProgramado: json["valorProgramado"].toDouble(),
        valorEjecutado: json["valorEjecutado"].toDouble(),
        porcentajeAvance: json["porcentajeAvance"].toDouble(),
        cantidadEjecutadaInicial: json["cantidadEjecutadaInicial"].toDouble(),
        valorEjecutadoInicial: json["valorEjecutadoInicial"].toDouble(),
        porcentajeAvanceInicial: json["porcentajeAvanceInicial"].toDouble(),
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

  String get ejecutadoActual {
    final value = (cantidadEjecutadaInicial / cantidadProgramada) * 100;
    return '${value.round()} %';
  }

  double get getCurrentProgressDouble {
    return (cantidadEjecutadaInicial / cantidadProgramada) * 100;
  }

  String avanceAHoy(double valorAvance) {
    final value = (cantidadEjecutadaInicial / cantidadProgramada) * 100;

    return '${(value + valorAvance).round()} %';
  }

  String faltantePorEjecutar(double valorAvance) {
    final value = (cantidadEjecutadaInicial / cantidadProgramada) * 100;

    return '${(100 - (value + valorAvance)).round()} %';
  }

  double getNewExecutedValue(double valorAvance) {
    final progressValuePercentage = valorProgramado * valorAvance / 100;
    final newExcutedValue =
        cantidadProgramada * (progressValuePercentage / valorProgramado);
    return newExcutedValue;
  }

  String get getStringId {
    return actividadId.toString();
  }
}

class AspectoEvaluar {
  AspectoEvaluar({
    required this.aspectoEvaluarId,
    required this.descripcionAspectoEvaluar,
  });

  final int aspectoEvaluarId;
  final String descripcionAspectoEvaluar;

  factory AspectoEvaluar.fromJson(Map<String, dynamic> json) => AspectoEvaluar(
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
    required this.factorAtrasoId,
    required this.factorAtraso,
    required this.tipoFactorAtrasoId,
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

class Periodo extends Equatable {
  Periodo({
    required this.periodoId,
    required this.fechaIniPeriodo,
    required this.fechaFinPeriodo,
    required this.porcentajeProyectado,
  });

  final int periodoId;
  final String fechaIniPeriodo;
  final String fechaFinPeriodo;
  final double porcentajeProyectado;

  factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
        periodoId: json["periodoId"],
        fechaIniPeriodo: json["fechaIniPeriodo"],
        fechaFinPeriodo: json["fechaFinPeriodo"],
        porcentajeProyectado: json["porcentajeProyectado"] == null
            ? null
            : json["porcentajeProyectado"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "periodoId": periodoId,
        "fechaIniPeriodo": fechaIniPeriodo,
        "fechaFinPeriodo": fechaFinPeriodo,
        "porcentajeProyectado": porcentajeProyectado,
      };

  // static Periodo empty() => Periodo();

  @override
  List<Object> get props =>
      [periodoId, fechaFinPeriodo, fechaFinPeriodo, porcentajeProyectado];
}

class TiposFactorAtraso {
  TiposFactorAtraso({
    required this.tipoFactorAtrasoId,
    required this.tipoFactorAtraso,
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
