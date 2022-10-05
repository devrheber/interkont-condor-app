import 'dart:convert';

import 'package:appalimentacion/app/data/model/project.dart';
import 'package:flutter/foundation.dart';

List<LocalProject> localProjectFromJson(String str) => List<LocalProject>.from(
    json.decode(str).map((x) => LocalProject.fromJson(x)));

String localProjectsToJson(List<LocalProject> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocalProject {
  const LocalProject({
    @required this.project,
    @required this.stepNumber,
    this.porPublicar,
    this.ultimaFechaSincro,
    this.periodoIdSeleccionado,
    this.porcentajeValorProyectadoSeleccionado,
    this.porcentajeValorEjecutado,
  });

  final Project project;
  final int stepNumber;
  final dynamic porPublicar;
  final dynamic ultimaFechaSincro;
  final dynamic periodoIdSeleccionado;
  // TODO
  final dynamic porcentajeValorProyectadoSeleccionado;
  final dynamic porcentajeValorEjecutado;

  factory LocalProject.fromJson(Map<String, dynamic> json) => LocalProject(
        project: Project.fromJson(json['project']),
        stepNumber: json['strep_number'],
        porPublicar: json['porPublicar'],
        ultimaFechaSincro: json['ultimaFechaSincro'],
        porcentajeValorProyectadoSeleccionado:
            json['porcentajeValorProyectadoSeleccionado'],
        porcentajeValorEjecutado: json['porcentajeValorEjecutado'],
      );

  Map<String, dynamic> toJson() => {
        'project': project.toJson(),
        'strep_number': stepNumber,
        'porPublicar': porPublicar,
        'periodoIdSeleccionado': periodoIdSeleccionado,
        'porcentajeValorProyectadoSeleccionado':
            porcentajeValorProyectadoSeleccionado,
        'porcentajeValorEjecutado': porcentajeValorEjecutado,
      };

  copyWith({
    Project project,
    int stepNumber,
    dynamic porPublicar,
    dynamic ultimaFechaSincro,
    dynamic periodoIdSeleccionado,
    dynamic porcentajeValorProyectadoSeleccionado,
    dynamic porcentajeValorEjecutado,
  }) {
    return LocalProject(
      project: project ?? this.project,
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
