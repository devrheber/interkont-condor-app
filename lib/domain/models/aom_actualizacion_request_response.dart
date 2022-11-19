import 'dart:convert';

import 'package:equatable/equatable.dart';

AomActualizacionRequestResponse aomActualizacionRequestResponseFromJson(
        String str) =>
    AomActualizacionRequestResponse.fromJson(json.decode(str));

String aomActualizacionRequestResponseToJson(
        AomActualizacionRequestResponse data) =>
    json.encode(data.toJson());

class AomActualizacionRequestResponse extends Equatable {
  AomActualizacionRequestResponse({
    required this.id,
    required this.createdAt,
    required this.createdBy,
    required this.estadoRevisionTecnica,
    required this.repuesta1,
    required this.repuesta2,
    required this.repuesta3,
    required this.repuesta4,
    required this.repuesta5,
    required this.repuesta6,
    required this.repuesta7,
    required this.strObservacionNoVidaUtil,
    required this.vidaUtilConsiderada,
    required this.obraId,
    required this.clasificacionId,
    required this.documentosRelacionados,
    required this.activosRelacionesClasificacion,
    this.observacionesRevisionTecnica,
  });

  final int id;
  final DateTime createdAt;
  final String createdBy;
  final int estadoRevisionTecnica;
  final bool repuesta1;
  final bool repuesta2;
  final bool repuesta3;
  final bool repuesta4;
  final bool repuesta5;
  final bool repuesta6;
  final bool repuesta7;
  final String strObservacionNoVidaUtil;
  final int vidaUtilConsiderada;
  final int obraId;
  final int clasificacionId;
  final List<dynamic> documentosRelacionados;
  final List<dynamic> activosRelacionesClasificacion;
  final dynamic observacionesRevisionTecnica;

  factory AomActualizacionRequestResponse.fromJson(Map<String, dynamic> json) =>
      AomActualizacionRequestResponse(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        createdBy: json['createdBy'],
        estadoRevisionTecnica: json['estadoRevisionTecnica'],
        repuesta1: json['repuesta1'],
        repuesta2: json['repuesta2'],
        repuesta3: json['repuesta3'],
        repuesta4: json['repuesta4'],
        repuesta5: json['repuesta5'],
        repuesta6: json['repuesta6'],
        repuesta7: json['repuesta7'],
        strObservacionNoVidaUtil: json['strObservacionNoVidaUtil'],
        vidaUtilConsiderada: json['vidaUtilConsiderada'],
        obraId: json['obraId'],
        clasificacionId: json['clasificacionId'],
        documentosRelacionados:
            List<dynamic>.from(json['documentosRelacionados'].map((x) => x)),
        activosRelacionesClasificacion: List<dynamic>.from(
            json['activosRelacionesClasificacion'].map((x) => x)),
        observacionesRevisionTecnica: json['observacionesRevisionTecnica'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'createdBy': createdBy,
        'estadoRevisionTecnica': estadoRevisionTecnica,
        'repuesta1': repuesta1,
        'repuesta2': repuesta2,
        'repuesta3': repuesta3,
        'repuesta4': repuesta4,
        'repuesta5': repuesta5,
        'repuesta6': repuesta6,
        'repuesta7': repuesta7,
        'strObservacionNoVidaUtil': strObservacionNoVidaUtil,
        'vidaUtilConsiderada': vidaUtilConsiderada,
        'obraId': obraId,
        'clasificacionId': clasificacionId,
        'documentosRelacionados':
            List<dynamic>.from(documentosRelacionados.map((x) => x)),
        'activosRelacionesClasificacion':
            List<dynamic>.from(activosRelacionesClasificacion.map((x) => x)),
        'observacionesRevisionTecnica': observacionesRevisionTecnica,
      };

  @override
  List<Object?> get props => [
        id,
        createdAt,
        createdBy,
        estadoRevisionTecnica,
        repuesta1,
        repuesta2,
        repuesta3,
        repuesta4,
        repuesta5,
        repuesta6,
        repuesta7,
        strObservacionNoVidaUtil,
        vidaUtilConsiderada,
        obraId,
        clasificacionId,
        documentosRelacionados,
        activosRelacionesClasificacion,
        observacionesRevisionTecnica,
      ];
}
