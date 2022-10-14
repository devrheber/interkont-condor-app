import 'dart:convert';
import 'package:appalimentacion/domain/models/models.dart';

Map<String, ProjectCache> projectsCacheFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, ProjectCache>(k, ProjectCache.fromJson(v)));

String projectsCacheToJson(Map<String, ProjectCache> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ProjectCache {
  const ProjectCache({
    this.projectCode,
    this.stepNumber = 1,
    this.porPublicar,
    this.ultimaFechaSincro,
    this.periodoIdSeleccionado,
    this.porcentajeValorProyectadoSeleccionado,
    this.porcentajeValorEjecutado,
    this.newExecutedValue = 0.0,
    this.activitiesProgress,
    this.qualitativesProgress,
    this.delayFactors,
    this.comment,
    this.fileFotoPrincipal,
    this.incomeGenerationDate,
    this.rentalRepaymentDate,
    this.generatedReturns,
    this.currentMonthReturns,
    this.pastDueMonthReturns,
  });
  final int projectCode;
  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final int periodoIdSeleccionado;
  final dynamic porcentajeValorProyectadoSeleccionado;
  final double porcentajeValorEjecutado;
  final dynamic newExecutedValue;
  final Map<String, dynamic> activitiesProgress;
  final List<QualitativeProgress> qualitativesProgress;
  final List<DelayFactor> delayFactors;
  final String comment;
  final String fileFotoPrincipal;
  final String incomeGenerationDate;
  final String rentalRepaymentDate;
  final double generatedReturns;
  final double currentMonthReturns;
  final double pastDueMonthReturns;

  factory ProjectCache.fromJson(Map<String, dynamic> json) => ProjectCache(
        projectCode: json['project_code'],
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'],
        ultimaFechaSincro: json['ultimaFechaSincro'],
        periodoIdSeleccionado: json['periodoIdSeleccionado'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'],
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
        newExecutedValue: json['new_executed_value'],
        activitiesProgress: json['activities_progress'] ?? <String, String>{},
        delayFactors: json['delay_factors'] == null
            ? null
            : List<DelayFactor>.from(
                json["delay_factors"].map((x) => DelayFactor.fromJson(x))),
        comment: json['comment'],
        fileFotoPrincipal: json['fileFotoPrincipal'],
        qualitativesProgress: json['qualitatives_progress'] == null
            ? null
            : List<QualitativeProgress>.from(json["qualitatives_progress"]
                .map((x) => QualitativeProgress.fromJson(x))),
        incomeGenerationDate: json['fechaGeneracionRendimientos'],
        rentalRepaymentDate: json['fechaReintegroRendimientos'],
        generatedReturns: json['valorRendimientosGenerados'],
        currentMonthReturns: json['valorRendimientosMesActual'],
        pastDueMonthReturns: json['valorRendimientosMesVencido'],
      );

  Map<String, dynamic> toJson() => {
        'project_code': projectCode,
        'strep_number': stepNumber,
        'porPublicar': porPublicar,
        'ultimaFechaSincro': ultimaFechaSincro,
        'periodoIdSeleccionado': periodoIdSeleccionado,
        'porcentajeValorProyectadoSeleccionado':
            porcentajeValorProyectadoSeleccionado,
        'porcentajeValorEjecutado': porcentajeValorEjecutado,
        'new_executed_value': newExecutedValue,
        'activities_progress': activitiesProgress,
        'qualitatives_progress': qualitativesProgress == null
            ? null
            : List<dynamic>.from(qualitativesProgress.map((x) => x.toJson())),
        'delay_factors': delayFactors == null
            ? null
            : List<dynamic>.from(delayFactors.map((x) => x.toJson())),
        'comment': comment,
        'fileFotoPrincipal': fileFotoPrincipal,
        'fechaGeneracionRendimientos': incomeGenerationDate,
        'fechaReintegroRendimientos': rentalRepaymentDate,
        'valorRendimientosGenerados': generatedReturns,
        'valorRendimientosMesActual': currentMonthReturns,
        'valorRendimientosMesVencido': pastDueMonthReturns,
      };

  ProjectCache copyWith({
    int projectCode,
    int stepNumber,
    dynamic porPublicar,
    dynamic ultimaFechaSincro,
    dynamic periodoIdSeleccionado,
    double porcentajeValorProyectadoSeleccionado,
    double porcentajeValorEjecutado,
    double newExecutedValue,
    Map<String, dynamic> activitiesProgress,
    List<QualitativeProgress> qualitativesProgress,
    List<DelayFactor> delayFactors,
    String fileFotoPrincipal,
    List<dynamic> filesFotosComplementarias,
    String comment,
    String incomeGenerationDate,
    String rentalRepaymentDate,
    double generatedReturns,
    double currentMonthReturns,
    double pastDueMonthReturns,
  }) {
    return ProjectCache(
      projectCode: projectCode ?? this.projectCode,
      stepNumber: stepNumber ?? this.stepNumber,
      porPublicar: porPublicar ?? this.porPublicar,
      ultimaFechaSincro: ultimaFechaSincro ?? this.ultimaFechaSincro,
      periodoIdSeleccionado: periodoIdSeleccionado ?? this.periodoIdSeleccionado,
      porcentajeValorProyectadoSeleccionado: porcentajeValorProyectadoSeleccionado ?? this.porcentajeValorProyectadoSeleccionado,
      porcentajeValorEjecutado: porcentajeValorEjecutado ?? this.porcentajeValorEjecutado,
      newExecutedValue: newExecutedValue ?? this.newExecutedValue,
      activitiesProgress: activitiesProgress ?? this.activitiesProgress,
      qualitativesProgress: qualitativesProgress ?? this.qualitativesProgress,
      delayFactors: delayFactors ?? this.delayFactors,
      fileFotoPrincipal: fileFotoPrincipal ?? this.fileFotoPrincipal,
      comment: comment ?? this.comment,
      incomeGenerationDate: incomeGenerationDate ?? this.incomeGenerationDate,
      rentalRepaymentDate: rentalRepaymentDate ?? this.rentalRepaymentDate,
      generatedReturns: generatedReturns ?? this.generatedReturns,
      currentMonthReturns: currentMonthReturns ?? this.currentMonthReturns,
      pastDueMonthReturns: pastDueMonthReturns ?? this.pastDueMonthReturns,
    );
  }

  String get getPorcentajeValorProyectado {
    return porcentajeValorProyectadoSeleccionado.round().toString();
  }

  double porcentajeAsiVaEn(double valorproyecto) =>
      ((newExecutedValue ?? 0) / valorproyecto) * 100;
}
