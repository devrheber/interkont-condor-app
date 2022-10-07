// import 'dart:convert';

// List<DatosAlimentacion> projetsDetailFromJson(String str) => List<DatosAlimentacion>.from(json.decode(str).map((x) => DatosAlimentacion.fromJson(x)));

// String projetsDetailToJson(List<DatosAlimentacion> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// DatosAlimentacion datosAlimentacionFromJson(String str) => DatosAlimentacion.fromJson(json.decode(str));

// String datosAlimentacionToJson(DatosAlimentacion data) => json.encode(data.toJson());

// class DatosAlimentacion {
//     DatosAlimentacion({
//         this.limitePorcentajeAtraso,
//         this.limitePorcentajeAtrasoAmarillo,
//         this.periodos,
//         this.actividades,
//         this.indicadoresAlcance,
//         this.apectosEvaluar,
//         this.tiposFactorAtraso,
//         this.factoresAtraso,
//     });

//     double limitePorcentajeAtraso;
//     double limitePorcentajeAtrasoAmarillo;
//     List<Periodo> periodos;
//     List<Actividad> actividades;
//     List<dynamic> indicadoresAlcance;
//     List<ApectosEvaluar> apectosEvaluar;
//     List<TiposFactorAtraso> tiposFactorAtraso;
//     List<FactoresAtraso> factoresAtraso;

//     factory DatosAlimentacion.fromJson(Map<String, dynamic> json) => DatosAlimentacion(
//         limitePorcentajeAtraso: json["limitePorcentajeAtraso"].toDouble(),
//         limitePorcentajeAtrasoAmarillo: json["limitePorcentajeAtrasoAmarillo"].toDouble(),
//         periodos: List<Periodo>.from(json["periodos"].map((x) => Periodo.fromJson(x))),
//         actividades: List<Actividad>.from(json["actividades"].map((x) => Actividad.fromJson(x))),
//         indicadoresAlcance: List<dynamic>.from(json["indicadoresAlcance"].map((x) => x)),
//         apectosEvaluar: List<ApectosEvaluar>.from(json["apectosEvaluar"].map((x) => ApectosEvaluar.fromJson(x))),
//         tiposFactorAtraso: List<TiposFactorAtraso>.from(json["tiposFactorAtraso"].map((x) => TiposFactorAtraso.fromJson(x))),
//         factoresAtraso: List<FactoresAtraso>.from(json["factoresAtraso"].map((x) => FactoresAtraso.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "limitePorcentajeAtraso": limitePorcentajeAtraso,
//         "limitePorcentajeAtrasoAmarillo": limitePorcentajeAtrasoAmarillo,
//         "periodos": List<dynamic>.from(periodos.map((x) => x.toJson())),
//         "actividades": List<dynamic>.from(actividades.map((x) => x.toJson())),
//         "indicadoresAlcance": List<dynamic>.from(indicadoresAlcance.map((x) => x)),
//         "apectosEvaluar": List<dynamic>.from(apectosEvaluar.map((x) => x.toJson())),
//         "tiposFactorAtraso": List<dynamic>.from(tiposFactorAtraso.map((x) => x.toJson())),
//         "factoresAtraso": List<dynamic>.from(factoresAtraso.map((x) => x.toJson())),
//     };
// }

// class Actividad {
//     Actividad({
//         this.actividadId,
//         this.descripcionActividad,
//         this.unidadMedida,
//         this.valorUnitario,
//         this.cantidadProgramada,
//         this.cantidadEjecutada,
//         this.valorProgramado,
//         this.valorEjecutado,
//         this.porcentajeAvance,
//         this.cantidadEjecutadaInicial,
//         this.valorEjecutadoInicial,
//         this.porcentajeAvanceInicial,
//     });

//     int actividadId;
//     String descripcionActividad;
//     String unidadMedida;
//     double valorUnitario;
//     double cantidadProgramada;
//     double cantidadEjecutada;
//     double valorProgramado;
//     double valorEjecutado;
//     double porcentajeAvance;
//     double cantidadEjecutadaInicial;
//     double valorEjecutadoInicial;
//     double porcentajeAvanceInicial;

//     factory Actividad.fromJson(Map<String, dynamic> json) => Actividad(
//         actividadId: json["actividadId"],
//         descripcionActividad: json["descripcionActividad"],
//         unidadMedida: json["unidadMedida"],
//         valorUnitario: json["valorUnitario"].toDouble(),
//         cantidadProgramada: json["cantidadProgramada"].toDouble(),
//         cantidadEjecutada: json["cantidadEjecutada"].toDouble(),
//         valorProgramado: json["valorProgramado"].toDouble(),
//         valorEjecutado: json["valorEjecutado"].toDouble(),
//         porcentajeAvance: json["porcentajeAvance"].toDouble(),
//         cantidadEjecutadaInicial: json["cantidadEjecutadaInicial"].toDouble(),
//         valorEjecutadoInicial: json["valorEjecutadoInicial"].toDouble(),
//         porcentajeAvanceInicial: json["porcentajeAvanceInicial"].toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "actividadId": actividadId,
//         "descripcionActividad": descripcionActividad,
//         "unidadMedida": unidadMedida,
//         "valorUnitario": valorUnitario,
//         "cantidadProgramada": cantidadProgramada,
//         "cantidadEjecutada": cantidadEjecutada,
//         "valorProgramado": valorProgramado,
//         "valorEjecutado": valorEjecutado,
//         "porcentajeAvance": porcentajeAvance,
//         "cantidadEjecutadaInicial": cantidadEjecutadaInicial,
//         "valorEjecutadoInicial": valorEjecutadoInicial,
//         "porcentajeAvanceInicial": porcentajeAvanceInicial,
//     };
// }

// class ApectosEvaluar {
//     ApectosEvaluar({
//         this.aspectoEvaluarId,
//         this.descripcionAspectoEvaluar,
//     });

//     int aspectoEvaluarId;
//     String descripcionAspectoEvaluar;

//     factory ApectosEvaluar.fromJson(Map<String, dynamic> json) => ApectosEvaluar(
//         aspectoEvaluarId: json["aspectoEvaluarId"],
//         descripcionAspectoEvaluar: json["descripcionAspectoEvaluar"],
//     );

//     Map<String, dynamic> toJson() => {
//         "aspectoEvaluarId": aspectoEvaluarId,
//         "descripcionAspectoEvaluar": descripcionAspectoEvaluar,
//     };
// }

// class FactoresAtraso {
//     FactoresAtraso({
//         this.factorAtrasoId,
//         this.factorAtraso,
//         this.tipoFactorAtrasoId,
//     });

//     int factorAtrasoId;
//     String factorAtraso;
//     int tipoFactorAtrasoId;

//     factory FactoresAtraso.fromJson(Map<String, dynamic> json) => FactoresAtraso(
//         factorAtrasoId: json["factorAtrasoId"],
//         factorAtraso: json["factorAtraso"],
//         tipoFactorAtrasoId: json["tipoFactorAtrasoId"],
//     );

//     Map<String, dynamic> toJson() => {
//         "factorAtrasoId": factorAtrasoId,
//         "factorAtraso": factorAtraso,
//         "tipoFactorAtrasoId": tipoFactorAtrasoId,
//     };
// }

// class Periodo {
//     Periodo({
//         this.periodoId,
//         this.fechaIniPeriodo,
//         this.fechaFinPeriodo,
//         this.porcentajeProyectado,
//     });

//     int periodoId;
//     String fechaIniPeriodo;
//     String fechaFinPeriodo;
//     double porcentajeProyectado;

//     factory Periodo.fromJson(Map<String, dynamic> json) => Periodo(
//         periodoId: json["periodoId"],
//         fechaIniPeriodo: json["fechaIniPeriodo"],
//         fechaFinPeriodo: json["fechaFinPeriodo"],
//         porcentajeProyectado: json["porcentajeProyectado"].toDouble(),
//     );

//     Map<String, dynamic> toJson() => {
//         "periodoId": periodoId,
//         "fechaIniPeriodo": fechaIniPeriodo,
//         "fechaFinPeriodo": fechaFinPeriodo,
//         "porcentajeProyectado": porcentajeProyectado,
//     };
// }

// class TiposFactorAtraso {
//     TiposFactorAtraso({
//         this.tipoFactorAtrasoId,
//         this.tipoFactorAtraso,
//     });

//     int tipoFactorAtrasoId;
//     String tipoFactorAtraso;

//     factory TiposFactorAtraso.fromJson(Map<String, dynamic> json) => TiposFactorAtraso(
//         tipoFactorAtrasoId: json["tipoFactorAtrasoId"],
//         tipoFactorAtraso: json["tipoFactorAtraso"],
//     );

//     Map<String, dynamic> toJson() => {
//         "tipoFactorAtrasoId": tipoFactorAtrasoId,
//         "tipoFactorAtraso": tipoFactorAtraso,
//     };
// }
