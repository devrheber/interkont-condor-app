// To parse this JSON data, do
//
//     final gestionAom = gestionAomFromJson(jsonString);

import 'dart:convert';

List<GestionAom> gestionAomFromJson(String str) =>
    List<GestionAom>.from(json.decode(str).map((x) => GestionAom.fromJson(x)));

String gestionAomToJson(List<GestionAom> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GestionAom {
  GestionAom({
    required this.id,
    required this.categoriaId,
    required this.descripcionId,
    required this.descripcionCategoria,
    required this.valorDepreciacion,
    required this.estadoSupervisorId,
    required this.estadoNombreSupervisor,
    required this.cantidad,
    this.estadoInventarioId,
    this.estadoNombreInventario,
    required this.estadoAomId,
    required this.estadoNombreAom,
    required this.updatedAt,
    required this.obraId,
    required this.vidaUtil,
    required this.nivelTension,
    required this.descripcionDetalle,
    required this.unidadId,
    required this.strNombreUnidad,
    this.rutaInforme,
    this.rutaPoliza,
    this.rutaImagen,
    required this.latitud,
    required this.longitud,
    required this.ubicacion,
    this.observacion,
    required this.valorInicial,
    required this.vidaUtilRemanente,
    required this.anosRestantes,
    this.kmlLineaUrl,
    this.kmlPoligonoUrl,
    required this.tipoMapaActivo,
    required this.clasificacionRelacionObraActivos,
    this.strNombreImagen,
    required this.operatividad,
  });

  final int id;
  final int categoriaId;
  final int descripcionId;
  final String descripcionCategoria;
  final double valorDepreciacion;
  final int estadoSupervisorId;
  final String estadoNombreSupervisor;
  final int cantidad;
  final dynamic estadoInventarioId;
  final dynamic estadoNombreInventario;
  final int estadoAomId;
  final String estadoNombreAom;
  final String updatedAt;
  final int obraId;
  final int vidaUtil;
  final int nivelTension;
  final String descripcionDetalle;
  final int unidadId;
  final String strNombreUnidad;
  final dynamic rutaInforme;
  final dynamic rutaPoliza;
  final dynamic rutaImagen;
  final double latitud;
  final double longitud;
  final String ubicacion;
  final String? observacion;
  final double valorInicial;
  final DateTime vidaUtilRemanente;
  final int anosRestantes;
  final dynamic kmlLineaUrl;
  final dynamic kmlPoligonoUrl;
  final int tipoMapaActivo;
  final int clasificacionRelacionObraActivos;
  final dynamic strNombreImagen;
  final bool operatividad;

  factory GestionAom.fromJson(Map<String, dynamic> json) => GestionAom(
        id: json["id"],
        categoriaId: json["categoriaId"],
        descripcionId: json["descripcionId"],
        descripcionCategoria: json["descripcionCategoria"],
        valorDepreciacion: json["valor_depreciacion"],
        estadoSupervisorId: json["estadoSupervisorId"],
        estadoNombreSupervisor: json["estadoNombreSupervisor"],
        cantidad: json["cantidad"].round(),
        estadoInventarioId: json["estadoInventarioId"],
        estadoNombreInventario: json["estadoNombreInventario"],
        estadoAomId: json["estadoAomId"],
        estadoNombreAom: json["estadoNombreAom"],
        updatedAt: json["updated_at"],
        obraId: json["obraId"],
        vidaUtil: json["vidaUtil"],
        nivelTension: json["nivelTension"],
        descripcionDetalle: json["descripcionDetalle"],
        unidadId: json["unidadId"],
        strNombreUnidad: json["strNombreUnidad"],
        rutaInforme: json["rutaInforme"],
        rutaPoliza: json["rutaPoliza"],
        rutaImagen: json["rutaImagen"],
        latitud: json["latitud"].toDouble(),
        longitud: json["longitud"].toDouble(),
        ubicacion: json["ubicacion"],
        observacion: json["observacion"],
        valorInicial: json["valorInicial"],
        vidaUtilRemanente: DateTime.parse(json["vidaUtilRemanente"]),
        anosRestantes: json["anosRestantes"].round(),
        kmlLineaUrl: json["kmlLineaUrl"],
        kmlPoligonoUrl: json["kmlPoligonoUrl"],
        tipoMapaActivo: json["tipoMapaActivo"],
        clasificacionRelacionObraActivos:
            json["clasificacionRelacionObraActivos"],
        strNombreImagen: json["strNombreImagen"],
        operatividad: json['operatividad'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoriaId": categoriaId,
        "descripcionId": descripcionId,
        "descripcionCategoria": descripcionCategoria,
        "valor_depreciacion": valorDepreciacion,
        "estadoSupervisorId": estadoSupervisorId,
        "estadoNombreSupervisor": estadoNombreSupervisor,
        "cantidad": cantidad,
        "estadoInventarioId": estadoInventarioId,
        "estadoNombreInventario": estadoNombreInventario,
        "estadoAomId": estadoAomId,
        "estadoNombreAom": estadoNombreAom,
        "updated_at": updatedAt,
        "obraId": obraId,
        "vidaUtil": vidaUtil,
        "nivelTension": nivelTension,
        "descripcionDetalle": descripcionDetalle,
        "unidadId": unidadId,
        "strNombreUnidad": strNombreUnidad,
        "rutaInforme": rutaInforme,
        "rutaPoliza": rutaPoliza,
        "rutaImagen": rutaImagen,
        "latitud": latitud,
        "longitud": longitud,
        "ubicacion": ubicacion,
        "observacion": observacion,
        "valorInicial": valorInicial,
        "vidaUtilRemanente":
            "${vidaUtilRemanente.year.toString().padLeft(4, '0')}-${vidaUtilRemanente.month.toString().padLeft(2, '0')}-${vidaUtilRemanente.day.toString().padLeft(2, '0')}",
        "anosRestantes": anosRestantes,
        "kmlLineaUrl": kmlLineaUrl,
        "kmlPoligonoUrl": kmlPoligonoUrl,
        "tipoMapaActivo": tipoMapaActivo,
        "clasificacionRelacionObraActivos": clasificacionRelacionObraActivos,
        "strNombreImagen": strNombreImagen,
        'operatividad': operatividad,
      };
}
