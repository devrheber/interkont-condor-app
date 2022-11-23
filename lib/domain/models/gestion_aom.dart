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
    required this.estadoAomId,
    required this.estadoNombreAom,
    required this.updatedAt,
    required this.obraId,
    required this.vidaUtil,
    required this.nivelTension,
    required this.descripcionDetalle,
    required this.unidadId,
    required this.strNombreUnidad,
    this.observacion,
    required this.valorInicial,
    required this.anosRestantes,
    required this.tipoMapaActivo,
    required this.clasificacionRelacionObraActivos,
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
  final int estadoAomId;
  final String estadoNombreAom;
  final String updatedAt;
  final int obraId;
  final int vidaUtil;
  final int nivelTension;
  final String descripcionDetalle;
  final int unidadId;
  final String strNombreUnidad;
  final String? observacion;
  final double valorInicial;
  final int anosRestantes;
  final int tipoMapaActivo;
  final int clasificacionRelacionObraActivos;
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
        estadoAomId: json["estadoAomId"],
        estadoNombreAom: json["estadoNombreAom"],
        updatedAt: json["updated_at"],
        obraId: json["obraId"],
        vidaUtil: json["vidaUtil"],
        nivelTension: json["nivelTension"],
        descripcionDetalle: json["descripcionDetalle"],
        unidadId: json["unidadId"],
        strNombreUnidad: json["strNombreUnidad"],
        observacion: json["observacion"],
        valorInicial: json["valorInicial"],
        anosRestantes: json["anosRestantes"].round(),
        tipoMapaActivo: json["tipoMapaActivo"],
        clasificacionRelacionObraActivos:
            json["clasificacionRelacionObraActivos"],
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
        "estadoAomId": estadoAomId,
        "estadoNombreAom": estadoNombreAom,
        "updated_at": updatedAt,
        "obraId": obraId,
        "vidaUtil": vidaUtil,
        "nivelTension": nivelTension,
        "descripcionDetalle": descripcionDetalle,
        "unidadId": unidadId,
        "strNombreUnidad": strNombreUnidad,
        "observacion": observacion,
        "valorInicial": valorInicial,
        "anosRestantes": anosRestantes,
        "tipoMapaActivo": tipoMapaActivo,
        "clasificacionRelacionObraActivos": clasificacionRelacionObraActivos,
        'operatividad': operatividad,
      };
}
