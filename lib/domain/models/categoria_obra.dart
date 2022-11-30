// To parse this JSON data, do
//
//     final categoriaObra = categoriaObraFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<CategoriaObra> categoriaObraFromJson(String str) =>
    List<CategoriaObra>.from(
        json.decode(str).map((x) => CategoriaObra.fromJson(x)));

String categoriaObraToJson(List<CategoriaObra> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoriaObra {
  CategoriaObra({
    required this.id,
    required this.clasificacionActivos,
    required this.obraId,
    this.idNeon,
    this.longitud,
    this.latitud,
    this.tipo,
    this.urlKmlLinea,
    this.urlKmlPoligono,
    this.direccion,
    required this.estadoClasificacion,
    required this.relacionReporteHistorial,
  });

  int id;
  ClasificacionActivos clasificacionActivos;
  int obraId;
  dynamic idNeon;
  dynamic longitud;
  dynamic latitud;
  dynamic tipo;
  dynamic urlKmlLinea;
  dynamic urlKmlPoligono;
  dynamic direccion;
  List<dynamic> relacionReporteHistorial;
  int estadoClasificacion;

  factory CategoriaObra.fromJson(Map<String, dynamic> json) => CategoriaObra(
        id: json['id'],
        clasificacionActivos: json['clasificacionActivos'] == null
            ? ClasificacionActivos.empty
            : ClasificacionActivos.fromJson(json['clasificacionActivos']),
        obraId: json['obraId'],
        idNeon: json['idNeon'],
        longitud: json['longitud'],
        latitud: json['latitud'],
        tipo: json['tipo'],
        urlKmlLinea: json['urlKmlLinea'],
        urlKmlPoligono: json['urlKmlPoligono'],
        direccion: json['direccion'],
        relacionReporteHistorial:
            List<dynamic>.from(json['relacionReporteHistorial'].map((x) => x)),
        estadoClasificacion: json['estadoClasificacion'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'clasificacionActivos': clasificacionActivos.toJson(),
        'obraId': obraId,
        'idNeon': idNeon,
        'longitud': longitud,
        'latitud': latitud,
        'tipo': tipo,
        'urlKmlLinea': urlKmlLinea,
        'urlKmlPoligono': urlKmlPoligono,
        'direccion': direccion,
        'relacionReporteHistorial':
            List<dynamic>.from(relacionReporteHistorial.map((x) => x)),
        'estadoClasificacion': estadoClasificacion,
      };
}

class ClasificacionActivos extends Equatable {
  const ClasificacionActivos({
    required this.id,
    required this.categoria,
    required this.descripcion,
    required this.nivelTension,
    required this.vidaUtil,
  });

  final int id;
  final int categoria;
  final String descripcion;
  final int nivelTension;
  final int vidaUtil;

  factory ClasificacionActivos.fromJson(Map<String, dynamic> json) =>
      ClasificacionActivos(
        id: json['id'],
        categoria: json['categoria'],
        descripcion: json['descripcion'],
        nivelTension: json['nivelTension'],
        vidaUtil: json['vidaUtil'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'categoria': categoria,
        'descripcion': descripcion,
        'nivelTension': nivelTension,
        'vidaUtil': vidaUtil,
      };

  static const empty = ClasificacionActivos(
    id: -1,
    categoria: -1,
    descripcion: '--',
    nivelTension: 0,
    vidaUtil: 0,
  );

  @override
  List<Object?> get props => [
        id,
        categoria,
        descripcion,
        nivelTension,
        vidaUtil,
      ];
}
