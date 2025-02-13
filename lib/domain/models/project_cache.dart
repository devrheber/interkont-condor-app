import 'dart:convert';

import 'package:appalimentacion/helpers/helpers.dart';
import 'package:equatable/equatable.dart';

import 'models.dart';

Map<String, ProjectCache> projectsCacheFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, ProjectCache>(k, ProjectCache.fromJson(v)));

String projectsCacheToJson(Map<String, ProjectCache> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ProjectCache extends Equatable {
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
    this.valorReintegroRendimientos,
    this.valorSaldoFinalExtracto,
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
  final String? incomeGenerationDate;
  final String? rentalRepaymentDate;
  final double? generatedReturns;
  final double? valorReintegroRendimientos;
  final double? valorSaldoFinalExtracto;

  factory ProjectCache.fromJson(Map<String, dynamic> json) => ProjectCache(
        projectCode: json['project_code'],
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'] == null ? false : json['porPublicar'],
        lastSyncDate: json['ultimaFechaSincro'] == null
            ? null
            : DateTime.parse(json['ultimaFechaSincro']),
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
        incomeGenerationDate: json['fechaGeneracionRendimientos'],
        rentalRepaymentDate: json['fechaReintegroRendimientos'],
        generatedReturns: json['valorRendimientosGenerados'],
        valorReintegroRendimientos: json['valorReintegroRendimientos'],
        valorSaldoFinalExtracto: json['valorSaldoFinalExtracto'],
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
        'fechaGeneracionRendimientos': incomeGenerationDate,
        'fechaReintegroRendimientos': rentalRepaymentDate,
        'valorRendimientosGenerados':
            generatedReturns == null ? 0.0 : generatedReturns,
        'valorReintegroRendimientos': valorReintegroRendimientos == null
            ? 0.0
            : valorReintegroRendimientos,
        'valorSaldoFinalExtracto':
            valorSaldoFinalExtracto == null ? 0.0 : valorSaldoFinalExtracto,
      };

  ProjectCache copyWith({
    int? projectCode,
    int? stepNumber,
    bool? porPublicar,
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
    String? incomeGenerationDate,
    String? rentalRepaymentDate,
    double? generatedReturns,
    double? valorReintegroRendimientos,
    double? valorSaldoFinalExtracto,
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
      valorReintegroRendimientos:
          valorReintegroRendimientos ?? this.valorReintegroRendimientos,
      valorSaldoFinalExtracto:
          valorSaldoFinalExtracto ?? this.valorSaldoFinalExtracto,
    );
  }

  ProjectCache newCache() => ProjectCache(
        projectCode: projectCode,
        lastSyncDate: this.lastSyncDate,
      );

  static ProjectCache empty(int projectCode) => ProjectCache(
        projectCode: projectCode,
      );

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

  DateTime? get getIncomeGenerationDate {
    if (incomeGenerationDate == null) return null;
    return DateTime.parse(incomeGenerationDate!);
  }

  DateTime? get getRentalRepaymentDate {
    if (rentalRepaymentDate == null) return null;
    return DateTime.parse(rentalRepaymentDate!);
  }

  @override
  List<Object?> get props => [
        projectCode,
        stepNumber,
        porPublicar,
        lastSyncDate,
        periodoIdSeleccionado,
        porcentajeValorProyectadoSeleccionado,
        porcentajeValorEjecutado,
        activitiesProgress,
        rangeIndicators,
        qualitativesProgress,
        delayFactors,
        comment,
        fileFotoPrincipal,
        incomeGenerationDate,
        rentalRepaymentDate,
        generatedReturns,
        valorReintegroRendimientos,
        valorSaldoFinalExtracto,
      ];
}
