// To parse this JSON data, do
//
//     final gestionAom = gestionAomFromJson(jsonString);

import 'dart:convert';

List<GestionAom> gestionAomFromJson(String str) => List<GestionAom>.from(json.decode(str).map((x) => GestionAom.fromJson(x)));

String gestionAomToJson(List<GestionAom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
    });

    int id;
    int categoriaId;
    int descripcionId;
    String descripcionCategoria;
    int valorDepreciacion;
    int estadoSupervisorId;
    String estadoNombreSupervisor;
    int cantidad;
    dynamic estadoInventarioId;
    dynamic estadoNombreInventario;
    int estadoAomId;
    String estadoNombreAom;
    String updatedAt;
    int obraId;
    int vidaUtil;
    int nivelTension;
    String descripcionDetalle;
    int unidadId;
    String strNombreUnidad;
    dynamic rutaInforme;
    dynamic rutaPoliza;
    dynamic rutaImagen;
    double latitud;
    double longitud;
    String ubicacion;
    dynamic observacion;
    int valorInicial;
    DateTime vidaUtilRemanente;
    int anosRestantes;
    dynamic kmlLineaUrl;
    dynamic kmlPoligonoUrl;
    int tipoMapaActivo;
    int clasificacionRelacionObraActivos;
    dynamic strNombreImagen;

    factory GestionAom.fromJson(Map<String, dynamic> json) => GestionAom(
        id: json["id"],
        categoriaId: json["categoriaId"],
        descripcionId: json["descripcionId"],
        descripcionCategoria: json["descripcionCategoria"],
        valorDepreciacion: json["valor_depreciacion"],
        estadoSupervisorId: json["estadoSupervisorId"],
        estadoNombreSupervisor: json["estadoNombreSupervisor"],
        cantidad: json["cantidad"],
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
        anosRestantes: json["anosRestantes"],
        kmlLineaUrl: json["kmlLineaUrl"],
        kmlPoligonoUrl: json["kmlPoligonoUrl"],
        tipoMapaActivo: json["tipoMapaActivo"],
        clasificacionRelacionObraActivos: json["clasificacionRelacionObraActivos"],
        strNombreImagen: json["strNombreImagen"],
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
        "vidaUtilRemanente": "${vidaUtilRemanente.year.toString().padLeft(4, '0')}-${vidaUtilRemanente.month.toString().padLeft(2, '0')}-${vidaUtilRemanente.day.toString().padLeft(2, '0')}",
        "anosRestantes": anosRestantes,
        "kmlLineaUrl": kmlLineaUrl,
        "kmlPoligonoUrl": kmlPoligonoUrl,
        "tipoMapaActivo": tipoMapaActivo,
        "clasificacionRelacionObraActivos": clasificacionRelacionObraActivos,
        "strNombreImagen": strNombreImagen,
    };
}
