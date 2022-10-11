import 'dart:convert';

import 'package:appalimentacion/domain/models/delay_factor.dart';
import 'package:appalimentacion/domain/models/project.dart';
import 'package:appalimentacion/domain/models/qualitative_progress.dart';

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
    this.filesFotosComplementarias,
  });

  final int projectCode;
  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final dynamic periodoIdSeleccionado;
  final dynamic porcentajeValorProyectadoSeleccionado;
  final dynamic porcentajeValorEjecutado;
  final dynamic newExecutedValue;
  final Map<String, dynamic> activitiesProgress;
  final List<QualitativeProgress> qualitativesProgress;
  final List<DelayFactor> delayFactors;
  final String comment;
  final String fileFotoPrincipal;
  final List<dynamic> filesFotosComplementarias;

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
        filesFotosComplementarias: json['filesFotosComplementarias'],
        qualitativesProgress: json['qualitatives_progress'] == null
            ? null
            : List<QualitativeProgress>.from(json["qualitatives_progress"]
                .map((x) => QualitativeProgress.fromJson(x))),
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
        'filesFotosComplementarias': filesFotosComplementarias,
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
  }) {
    return ProjectCache(
      projectCode: projectCode ?? this.projectCode,
      stepNumber: stepNumber ?? this.stepNumber,
      porPublicar: porPublicar ?? this.porPublicar,
      ultimaFechaSincro: ultimaFechaSincro ?? this.ultimaFechaSincro,
      periodoIdSeleccionado:
          periodoIdSeleccionado ?? this.periodoIdSeleccionado,
      porcentajeValorProyectadoSeleccionado:
          porcentajeValorProyectadoSeleccionado ??
              this.porcentajeValorProyectadoSeleccionado,
      porcentajeValorEjecutado:
          porcentajeValorEjecutado ?? porcentajeValorEjecutado,
      newExecutedValue: newExecutedValue ?? this.newExecutedValue,
      activitiesProgress: activitiesProgress ?? this.activitiesProgress,
      qualitativesProgress: qualitativesProgress ?? this.qualitativesProgress,
      delayFactors: delayFactors ?? this.delayFactors,
      fileFotoPrincipal: fileFotoPrincipal ?? this.fileFotoPrincipal,
      filesFotosComplementarias:
          filesFotosComplementarias ?? this.filesFotosComplementarias,
    );
  }

  String get getPorcentajeValorProyectado {
    return porcentajeValorProyectadoSeleccionado.round().toString();
  }

  double porcentajeAsiVaEn(double valorproyecto) =>
      ((newExecutedValue ?? 0) / valorproyecto) * 100;
}
