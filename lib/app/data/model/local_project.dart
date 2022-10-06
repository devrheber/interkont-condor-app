import 'dart:convert';

import 'package:appalimentacion/app/data/model/project.dart';
import 'package:flutter/foundation.dart';

List<ProjectCache> projectsCacheFromJson(String str) => List<ProjectCache>.from(
    json.decode(str).map((x) => ProjectCache.fromJson(x)));

String projectsCacheToJson(List<ProjectCache> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectCache {
  const ProjectCache({
    @required this.stepNumber,
    this.porPublicar,
    this.ultimaFechaSincro,
    this.periodoIdSeleccionado,
    this.porcentajeValorProyectadoSeleccionado,
    this.porcentajeValorEjecutado,
  });

  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final dynamic periodoIdSeleccionado;
  // TODO
  final dynamic porcentajeValorProyectadoSeleccionado;
  final dynamic porcentajeValorEjecutado;

  factory ProjectCache.fromJson(Map<String, dynamic> json) => ProjectCache(
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'],
        ultimaFechaSincro: json['ultimaFechaSincro'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'],
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
      );

  Map<String, dynamic> toJson() => {
        'strep_number': stepNumber,
        'porPublicar': porPublicar,
        'periodoIdSeleccionado': periodoIdSeleccionado,
        'porcentajeValorProyectadoSeleccionado':
            porcentajeValorProyectadoSeleccionado,
        'porcentajeValorEjecutado': porcentajeValorEjecutado,
      };

  ProjectCache copyWith({
    Project project,
    int stepNumber,
    dynamic porPublicar,
    dynamic ultimaFechaSincro,
    dynamic periodoIdSeleccionado,
    dynamic porcentajeValorProyectadoSeleccionado,
    dynamic porcentajeValorEjecutado,
  }) {
    return ProjectCache(
      stepNumber: stepNumber ?? this.stepNumber,
      porPublicar: porPublicar ?? this.porPublicar,
      ultimaFechaSincro: ultimaFechaSincro ?? this.ultimaFechaSincro,
      periodoIdSeleccionado:
          periodoIdSeleccionado ?? this.periodoIdSeleccionado,
      porcentajeValorProyectadoSeleccionado:
          porcentajeValorProyectadoSeleccionado ??
              porcentajeValorProyectadoSeleccionado,
      porcentajeValorEjecutado:
          porcentajeValorEjecutado ?? porcentajeValorEjecutado,
    );
  }
}
