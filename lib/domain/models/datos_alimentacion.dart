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

class DatosAlimentacion extends Equatable {
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

  final double limitePorcentajeAtraso;
  final double limitePorcentajeAtrasoAmarillo;
  final List<Periodo> periodos;
  final List<Actividad> actividades;
  final List<IndicadoresDeAlcance> indicadoresAlcance;
  final List<AspectoEvaluar> apectosEvaluar;
  final List<TiposFactorAtraso> tiposFactorAtraso;
  final List<FactoresAtraso> factoresAtraso;

  factory DatosAlimentacion.fromJson(Map<String, dynamic> json) =>
      DatosAlimentacion(
        limitePorcentajeAtraso: json["limitePorcentajeAtraso"].toDouble(),
        limitePorcentajeAtrasoAmarillo:
            json["limitePorcentajeAtrasoAmarillo"].toDouble(),
        periodos: List<Periodo>.from(
            json["periodos"].map((x) => Periodo.fromJson(x))),
        actividades: List<Actividad>.from(
            json["actividades"].map((x) => Actividad.fromJson(x))),
        indicadoresAlcance: List<IndicadoresDeAlcance>.from(
            json["indicadoresAlcance"]
                .map((x) => IndicadoresDeAlcance.fromJson(x))),
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

  @override
  List<Object?> get props => [
        limitePorcentajeAtraso,
        limitePorcentajeAtrasoAmarillo,
        periodos,
        actividades,
        indicadoresAlcance,
        apectosEvaluar,
        tiposFactorAtraso,
        factoresAtraso,
      ];

  // static DatosAlimentacion get empty {
  //   return DatosAlimentacion();
  // }
}

class Actividad extends Equatable {
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
        cantidadEjecutada: json["cantidadEjecutada"] == null
            ? 0.0
            : json["cantidadEjecutada"] is int
                ? double.parse(json["cantidadEjecutada"])
                : json["cantidadEjecutada"] as double,
        valorProgramado: json["valorProgramado"].toDouble(),
        valorEjecutado: json["valorEjecutado"].toDouble(),
        porcentajeAvance: json["porcentajeAvance"] == null
            ? 0.0
            : json["porcentajeAvance"].toDouble(),
        cantidadEjecutadaInicial: json["cantidadEjecutadaInicial"] == null
            ? 0.0
            : json["cantidadEjecutadaInicial"].toDouble(),
        valorEjecutadoInicial: json["valorEjecutadoInicial"].toDouble(),
        porcentajeAvanceInicial:
            (json["porcentajeAvanceInicial"] ?? 0.0).toDouble(),
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

  double getNewExecutedValue(double porcentajeAvance) {
    final nuevoValorDeAvance = valorProgramado * (porcentajeAvance / 100);
    final nuevaCantidadDeAvance =
        cantidadProgramada * (nuevoValorDeAvance / valorProgramado);
    return nuevaCantidadDeAvance;
  }

  String get getStringId {
    return actividadId.toString();
  }

  @override
  List<Object?> get props => [
        actividadId,
        descripcionActividad,
        unidadMedida,
        valorUnitario,
        cantidadProgramada,
        cantidadEjecutada,
        valorProgramado,
        valorEjecutado,
        porcentajeAvance,
        cantidadEjecutadaInicial,
        valorEjecutadoInicial,
        porcentajeAvanceInicial,
      ];
}

class AspectoEvaluar extends Equatable {
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

  @override
  List<Object?> get props => [
        aspectoEvaluarId,
        descripcionAspectoEvaluar,
      ];
}

class FactoresAtraso extends Equatable {
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

  @override
  List<Object?> get props => [
        factorAtrasoId,
        factorAtraso,
        tipoFactorAtrasoId,
      ];
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

class TiposFactorAtraso extends Equatable {
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

  @override
  List<Object?> get props => [
        tipoFactorAtrasoId,
        tipoFactorAtraso,
      ];
}

List<IndicadoresDeAlcance> indicadoresDeAlcanceFromJson(String str) =>
    List<IndicadoresDeAlcance>.from(
        json.decode(str).map((x) => IndicadoresDeAlcance.fromJson(x)));

String indicadoresDeAlcanceToJson(List<IndicadoresDeAlcance> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IndicadoresDeAlcance extends Equatable {
  IndicadoresDeAlcance({
    required this.indicadorAlcanceId,
    required this.descripcionIndicadorAlcance,
    required this.unidadMedida,
    required this.cantidadProgramada,
    required this.cantidadEjecutada,
    required this.porcentajeAvance,
    required this.cantidadEjecutadaInicial,
    required this.porcentajeAvanceInicial,
  });

  int indicadorAlcanceId;
  String descripcionIndicadorAlcance;
  String unidadMedida;
  double cantidadProgramada;
  double cantidadEjecutada;
  double porcentajeAvance;
  double cantidadEjecutadaInicial;
  double porcentajeAvanceInicial;

  factory IndicadoresDeAlcance.fromJson(Map<String, dynamic> json) =>
      IndicadoresDeAlcance(
        indicadorAlcanceId: json["indicadorAlcanceId"],
        descripcionIndicadorAlcance: json["descripcionIndicadorAlcance"],
        unidadMedida: json["unidadMedida"],
        cantidadProgramada: json["cantidadProgramada"] is int
            ? double.parse(json["cantidadProgramada"])
            : json["cantidadProgramada"] ?? 0.0,
        cantidadEjecutada: json["cantidadEjecutada"] is int
            ? double.parse(json["cantidadEjecutada"])
            : json["cantidadEjecutada"] ?? 0.0,
        porcentajeAvance: json["porcentajeAvance"].toDouble(),
        cantidadEjecutadaInicial: json["cantidadEjecutadaInicial"] is int
            ? double.parse(json["cantidadEjecutadaInicial"])
            : json["cantidadEjecutadaInicial"] ?? 0.0,
        porcentajeAvanceInicial: json["porcentajeAvanceInicial"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "indicadorAlcanceId": indicadorAlcanceId,
        "descripcionIndicadorAlcance": descripcionIndicadorAlcance,
        "unidadMedida": unidadMedida,
        "cantidadProgramada": cantidadProgramada,
        "cantidadEjecutada": cantidadEjecutada,
        "porcentajeAvance": porcentajeAvance,
        "cantidadEjecutadaInicial": cantidadEjecutadaInicial,
        "porcentajeAvanceInicial": porcentajeAvanceInicial,
      };

  String get getId => indicadorAlcanceId.toString();

  @override
  List<Object?> get props => [
        indicadorAlcanceId,
        descripcionIndicadorAlcance,
        unidadMedida,
        cantidadProgramada,
        cantidadEjecutada,
        porcentajeAvance,
        cantidadEjecutadaInicial,
        porcentajeAvanceInicial,
      ];
}
