import 'dart:convert';

import 'package:appalimentacion/domain/models/project.dart';

Map<String, ProjectCache> projectsCacheFromJson(String str) =>
    Map.from(json.decode(str)).map(
        (k, v) => MapEntry<String, ProjectCache>(k, ProjectCache.fromJson(v)));

String projectsCacheToJson(Map<String, ProjectCache> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ProjectCache {
  const ProjectCache({
    this.stepNumber = 0,
    this.porPublicar,
    this.ultimaFechaSincro,
    this.periodoIdSeleccionado,
    this.porcentajeValorProyectadoSeleccionado,
    this.porcentajeValorEjecutado,
    this.newExecutedValue,
  });

  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final dynamic periodoIdSeleccionado;
  // TODO
  final double porcentajeValorProyectadoSeleccionado;
  final dynamic porcentajeValorEjecutado;
  final double newExecutedValue;

  factory ProjectCache.fromJson(Map<String, dynamic> json) => ProjectCache(
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'],
        ultimaFechaSincro: json['ultimaFechaSincro'],
        periodoIdSeleccionado: json['periodoIdSeleccionado'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'].toDouble(),
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
        newExecutedValue: json['new_executed_value'].toDouble(),
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
    );
  }

  String get getPorcentajeValorProyectado {
    return porcentajeValorProyectadoSeleccionado.round().toString();
  }
}
