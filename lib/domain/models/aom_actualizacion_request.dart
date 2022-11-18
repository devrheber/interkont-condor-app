// To parse this JSON data, do
//
//     final aomActualizacionRequest = aomActualizacionRequestFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

AomActualizacionRequest aomActualizacionRequestFromJson(String str) =>
    AomActualizacionRequest.fromJson(json.decode(str));

String aomActualizacionRequestToJson(AomActualizacionRequest data) =>
    json.encode(data.toJson());

class AomActualizacionRequest extends Equatable {
  AomActualizacionRequest({
    required this.activosUpdate,
    required this.clasificacionId,
    required this.imagenesVideosOr,
    required this.obraId,
    required this.respuesta1,
    required this.respuesta2,
    required this.respuesta3,
    required this.respuesta4,
    required this.respuesta5,
    required this.respuesta6,
    required this.respuesta7,
    required this.userId,
    required this.vidaUtilRemanenteConsideradaOff,
    required this.vidaUtilRemanenteNoConsideradaText,
  });

  final List<ActivoUpdateRequest> activosUpdate;
  final int clasificacionId;
  final List<ImagenesVideosOrRequest> imagenesVideosOr;
  final int obraId;
  final bool respuesta1;
  final bool respuesta2;
  final bool respuesta3;
  final bool respuesta4;
  final bool respuesta5;
  final bool respuesta6;
  final bool respuesta7;
  final int userId;
  final int vidaUtilRemanenteConsideradaOff;
  final String vidaUtilRemanenteNoConsideradaText;

  factory AomActualizacionRequest.fromJson(Map<String, dynamic> json) =>
      AomActualizacionRequest(
        activosUpdate: List<ActivoUpdateRequest>.from(
            json['activosUpdate'].map((x) => ActivoUpdateRequest.fromJson(x))),
        clasificacionId: json['clasificacionId'],
        imagenesVideosOr: List<ImagenesVideosOrRequest>.from(
            json['imagenesVideosOr']
                .map((x) => ImagenesVideosOrRequest.fromJson(x))),
        obraId: json['obraId'],
        respuesta1: json['respuesta1'],
        respuesta2: json['respuesta2'],
        respuesta3: json['respuesta3'],
        respuesta4: json['respuesta4'],
        respuesta5: json['respuesta5'],
        respuesta6: json['respuesta6'],
        respuesta7: json['respuesta7'],
        userId: json['userId'],
        vidaUtilRemanenteConsideradaOff:
            json['vidaUtilRemanenteConsideradaOff'],
        vidaUtilRemanenteNoConsideradaText:
            json['vidaUtilRemanenteNoConsideradaText'],
      );

  Map<String, dynamic> toJson() => {
        'activosUpdate':
            List<dynamic>.from(activosUpdate.map((x) => x.toJson())),
        'clasificacionId': clasificacionId,
        'imagenesVideosOr':
            List<dynamic>.from(imagenesVideosOr.map((x) => x.toJson())),
        'obraId': obraId,
        'respuesta1': respuesta1,
        'respuesta2': respuesta2,
        'respuesta3': respuesta3,
        'respuesta4': respuesta4,
        'respuesta5': respuesta5,
        'respuesta6': respuesta6,
        'respuesta7': respuesta7,
        'userId': userId,
        'vidaUtilRemanenteConsideradaOff': vidaUtilRemanenteConsideradaOff,
        'vidaUtilRemanenteNoConsideradaText':
            vidaUtilRemanenteNoConsideradaText,
      };

  @override
  List<Object?> get props => [
        activosUpdate,
        clasificacionId,
        imagenesVideosOr,
        obraId,
        respuesta1,
        respuesta2,
        respuesta3,
        respuesta4,
        respuesta5,
        respuesta6,
        respuesta7,
        userId,
        vidaUtilRemanenteConsideradaOff,
        vidaUtilRemanenteNoConsideradaText,
      ];
}

class ActivoUpdateRequest extends Equatable {
  ActivoUpdateRequest({
    required this.cantidad,
    required this.cantidadPropuesta,
    required this.estadoAomId,
    required this.id,
    required this.observacion,
    required this.operatividad,
  });

  final int cantidad;
  final int cantidadPropuesta;
  final int estadoAomId;
  final int id;
  final String observacion;
  final bool operatividad;

  factory ActivoUpdateRequest.fromJson(Map<String, dynamic> json) =>
      ActivoUpdateRequest(
        cantidad: json['cantidad'],
        cantidadPropuesta: json['cantidadPropuesta'],
        estadoAomId: json['estadoAomId'],
        id: json['id'],
        observacion: json['observacion'],
        operatividad: json['operatividad'],
      );

  Map<String, dynamic> toJson() => {
        'cantidad': cantidad,
        'cantidadPropuesta': cantidadPropuesta,
        'estadoAomId': estadoAomId,
        'id': id,
        'observacion': observacion,
        'operatividad': operatividad,
      };

  @override
  List<Object?> get props => [
        cantidad,
        cantidadPropuesta,
        estadoAomId,
        id,
        observacion,
        operatividad,
      ];

  ActivoUpdateRequest copyWith({
    int? cantidad,
    int? cantidadPropuesta,
    int? estadoAomId,
    int? id,
    String? observacion,
    bool? operatividad,
  }) {
    return ActivoUpdateRequest(
      cantidad: cantidad ?? this.cantidad,
      cantidadPropuesta: cantidadPropuesta ?? this.cantidadPropuesta,
      estadoAomId: estadoAomId ?? this.estadoAomId,
      id: id ?? this.id,
      observacion: observacion ?? this.observacion,
      operatividad: operatividad ?? this.operatividad,
    );
  }
}

class ImagenesVideosOrRequest extends Equatable {
  ImagenesVideosOrRequest({
    required this.fileExt,
    required this.id,
    required this.iddocumento,
    required this.name,
    required this.tipoMovimiento,
  });

  final String fileExt;
  final int id;
  final int iddocumento;
  final String name;
  final int tipoMovimiento;

  factory ImagenesVideosOrRequest.fromJson(Map<String, dynamic> json) =>
      ImagenesVideosOrRequest(
        fileExt: json['fileExt'],
        id: json['id'],
        iddocumento: json['iddocumento'],
        name: json['name'],
        tipoMovimiento: json['tipoMovimiento'],
      );

  Map<String, dynamic> toJson() => {
        'fileExt': fileExt,
        'id': id,
        'iddocumento': iddocumento,
        'name': name,
        'tipoMovimiento': tipoMovimiento,
      };

  @override
  List<Object?> get props => [
        fileExt,
        id,
        iddocumento,
        name,
        tipoMovimiento,
      ];
}
