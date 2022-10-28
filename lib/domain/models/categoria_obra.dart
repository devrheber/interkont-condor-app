// To parse this JSON data, do
//
//     final categoriaObra = categoriaObraFromJson(jsonString);

import 'dart:convert';

List<CategoriaObra> categoriaObraFromJson(String str) => List<CategoriaObra>.from(json.decode(str).map((x) => CategoriaObra.fromJson(x)));

String categoriaObraToJson(List<CategoriaObra> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

    factory CategoriaObra.fromJson(Map<String, dynamic> json) => CategoriaObra(
        id: json["id"],
        clasificacionActivos: ClasificacionActivos.fromJson(json["clasificacionActivos"]),
        obraId: json["obraId"],
        idNeon: json["idNeon"],
        longitud: json["longitud"],
        latitud: json["latitud"],
        tipo: json["tipo"],
        urlKmlLinea: json["urlKmlLinea"],
        urlKmlPoligono: json["urlKmlPoligono"],
        direccion: json["direccion"],
        relacionReporteHistorial: List<dynamic>.from(json["relacionReporteHistorial"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clasificacionActivos": clasificacionActivos.toJson(),
        "obraId": obraId,
        "idNeon": idNeon,
        "longitud": longitud,
        "latitud": latitud,
        "tipo": tipo,
        "urlKmlLinea": urlKmlLinea,
        "urlKmlPoligono": urlKmlPoligono,
        "direccion": direccion,
        "relacionReporteHistorial": List<dynamic>.from(relacionReporteHistorial.map((x) => x)),
    };
}

class ClasificacionActivos {
    ClasificacionActivos({
        required this.id,
        required this.categoria,
        required this.descripcion,
        required this.nivelTension,
        required this.vidaUtil,
    });

    int id;
    int categoria;
    String descripcion;
    int nivelTension;
    int vidaUtil;

    factory ClasificacionActivos.fromJson(Map<String, dynamic> json) => ClasificacionActivos(
        id: json["id"],
        categoria: json["categoria"],
        descripcion: json["descripcion"],
        nivelTension: json["nivelTension"],
        vidaUtil: json["vidaUtil"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "categoria": categoria,
        "descripcion": descripcion,
        "nivelTension": nivelTension,
        "vidaUtil": vidaUtil,
    };
}
