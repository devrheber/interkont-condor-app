import 'dart:convert';

import '../../helpers/project_helpers.dart';
import 'models.dart';

Map<String, ProjectCache> projectsCacheFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, ProjectCache>(k, ProjectCache.fromJson(v)));

String projectsCacheToJson(Map<String, ProjectCache> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ProjectCache {
  const ProjectCache({
    required this.projectCode,
    this.stepNumber = 1,
    this.porPublicar = false,
    this.lastSyncDate,
    this.periodoIdSeleccionado,
    this.porcentajeValorProyectadoSeleccionado,
    this.porcentajeValorEjecutado,
    this.activitiesProgress,
    this.rangeIndicators,
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
  final bool porPublicar;
  final DateTime? lastSyncDate;
  final int? periodoIdSeleccionado;
  final double? porcentajeValorProyectadoSeleccionado;
  final double? porcentajeValorEjecutado;
  final Map<String, dynamic>? activitiesProgress;
  final Map<String, dynamic>? rangeIndicators;
  final List<QualitativeProgress>? qualitativesProgress;
  final List<DelayFactor>? delayFactors;
  final String? comment;
  final String? fileFotoPrincipal;
  final DateTime? incomeGenerationDate;
  final DateTime? rentalRepaymentDate;
  final String? generatedReturns;
  final String? currentMonthReturns;
  final String? pastDueMonthReturns;

  factory ProjectCache.fromJson(Map<String, dynamic> json) => ProjectCache(
        projectCode: json['project_code'],
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'] == null ? false : json['porPublicar'],
        lastSyncDate: DateTime.parse(json['ultimaFechaSincro']),
        periodoIdSeleccionado: json['periodoIdSeleccionado'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'],
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
        activitiesProgress: json['activities_progress'] ?? <String, String>{},
        rangeIndicators: json['range_indicators'] ?? <String, String>{},
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
        incomeGenerationDate: json['fechaGeneracionRendimientos'] == null
            ? null
            : DateTime.parse(json['fechaGeneracionRendimientos']),
        rentalRepaymentDate: json['fechaReintegroRendimientos'] == null
            ? null
            : DateTime.parse(json['fechaReintegroRendimientos']),
        generatedReturns: json['valorRendimientosGenerados'].toString(),
        currentMonthReturns: json['valorRendimientosMesActual'].toString(),
        pastDueMonthReturns: json['valorRendimientosMesVencido'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'project_code': projectCode,
        'strep_number': stepNumber,
        'porPublicar': porPublicar,
        'ultimaFechaSincro': lastSyncDate?.toIso8601String(),
        'periodoIdSeleccionado': periodoIdSeleccionado,
        'porcentajeValorProyectadoSeleccionado':
            porcentajeValorProyectadoSeleccionado,
        'porcentajeValorEjecutado': porcentajeValorEjecutado,
        'activities_progress': activitiesProgress,
        'range_indicators': rangeIndicators,
        'qualitatives_progress': qualitativesProgress == null
            ? null
            : List<dynamic>.from(qualitativesProgress!.map((x) => x.toJson())),
        'delay_factors': delayFactors == null
            ? null
            : List<dynamic>.from(delayFactors!.map((x) => x.toJson())),
        'comment': comment,
        'fileFotoPrincipal': fileFotoPrincipal,
        'fechaGeneracionRendimientos': incomeGenerationDate == null
            ? null
            : incomeGenerationDate?.toIso8601String(),
        'fechaReintegroRendimientos': rentalRepaymentDate == null
            ? null
            : rentalRepaymentDate?.toIso8601String(),
        'valorRendimientosGenerados':
            generatedReturns == null || generatedReturns == ''
                ? 0.0
                : generatedReturns,
        'valorRendimientosMesActual':
            currentMonthReturns == null || currentMonthReturns == ''
                ? 0.0
                : currentMonthReturns,
        'valorRendimientosMesVencido':
            pastDueMonthReturns == null || pastDueMonthReturns == ''
                ? 0.0
                : pastDueMonthReturns,
      };

  ProjectCache copyWith({
    int? projectCode,
    int? stepNumber,
    dynamic porPublicar,
    DateTime? lastSyncDate,
    dynamic periodoIdSeleccionado,
    double? porcentajeValorProyectadoSeleccionado,
    double? porcentajeValorEjecutado,
    Map<String, dynamic>? activitiesProgress,
    Map<String, dynamic>? rangeIndicators,
    List<QualitativeProgress>? qualitativesProgress,
    List<DelayFactor>? delayFactors,
    String? fileFotoPrincipal,
    List<dynamic>? filesFotosComplementarias,
    String? comment,
    DateTime? incomeGenerationDate,
    DateTime? rentalRepaymentDate,
    String? generatedReturns,
    String? currentMonthReturns,
    String? pastDueMonthReturns,
  }) {
    return ProjectCache(
      projectCode: projectCode ?? this.projectCode,
      stepNumber: stepNumber ?? this.stepNumber,
      porPublicar: porPublicar ?? this.porPublicar,
      lastSyncDate: lastSyncDate ?? this.lastSyncDate,
      periodoIdSeleccionado:
          periodoIdSeleccionado ?? this.periodoIdSeleccionado,
      porcentajeValorProyectadoSeleccionado:
          porcentajeValorProyectadoSeleccionado ??
              this.porcentajeValorProyectadoSeleccionado,
      porcentajeValorEjecutado:
          porcentajeValorEjecutado ?? this.porcentajeValorEjecutado,
      activitiesProgress: activitiesProgress ?? this.activitiesProgress,
      rangeIndicators: rangeIndicators ?? this.rangeIndicators,
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

  double get getPorcentajeValorProyectado {
    return porcentajeValorProyectadoSeleccionado ?? 0;
  }

  double porcentajeAsiVaEn(double valorproyecto) =>
      (porcentajeValorEjecutado ?? 0.0);

  String get getLastDateSyncFormatted {
    if (lastSyncDate == null) {
      return 'Nunca';
    }

    if (lastSyncDate!.difference(DateTime.now()).inSeconds > -10) {
      return 'Justo Ahora';
    }

    return ProjectHelpers.getlastSyncDateFormatted(lastSyncDate!);
  }

  bool get synchronizationRequired {
    return lastSyncDate == null;
  }
}
