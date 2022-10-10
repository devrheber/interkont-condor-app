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

  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final dynamic periodoIdSeleccionado;
  // TODO
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
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'],
        ultimaFechaSincro: json['ultimaFechaSincro'],
        periodoIdSeleccionado: json['periodoIdSeleccionado'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'],
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
        newExecutedValue: json['new_executed_value'],
        activitiesProgress: json['activities_progress'] ?? <String, String>{},
        delayFactors: json['delay_factors'],
        comment: json['comment'],
        fileFotoPrincipal: json['fileFotoPrincipal'],
        filesFotosComplementarias: json['filesFotosComplementarias'],
      );

  Map<String, dynamic> toJson() => {
        'strep_number': stepNumber,
        'porPublicar': porPublicar,
        'ultimaFechaSincro': ultimaFechaSincro,
        'periodoIdSeleccionado': periodoIdSeleccionado,
        'porcentajeValorProyectadoSeleccionado':
            porcentajeValorProyectadoSeleccionado,
        'porcentajeValorEjecutado': porcentajeValorEjecutado,
        'new_executed_value': newExecutedValue,
        'activities_progress': activitiesProgress,
        'qualitatives_progress': qualitativesProgress,
        'delay_factors': delayFactors,
        'comment': comment,
        'fileFotoPrincipal': fileFotoPrincipal,
        'filesFotosComplementarias': filesFotosComplementarias,
      };

  ProjectCache copyWith({
    Project project,
    int stepNumber,
    dynamic porPublicar,
    dynamic ultimaFechaSincro,
    dynamic periodoIdSeleccionado,
    double porcentajeValorProyectadoSeleccionado,
    dynamic porcentajeValorEjecutado,
    double newExecutedValue,
    Map<String, dynamic> activitiesProgress,
    List<QualitativeProgress> qualitativesProgress,
    List<DelayFactor> delayFactors,
    String fileFotoPrincipal,
    List<dynamic> filesFotosComplementarias,
  }) {
    return ProjectCache(
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
      filesFotosComplementarias: filesFotosComplementarias ?? this.filesFotosComplementarias,
    );
  }

  String get getPorcentajeValorProyectado {
    return porcentajeValorProyectadoSeleccionado.round().toString();
  }

  double porcentajeAsiVaEn(double valorproyecto) =>
      ((newExecutedValue ?? 0) / valorproyecto) * 100;
}
