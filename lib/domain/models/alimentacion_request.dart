// To parse this JSON data, do
//
//     final alimentacionRequest = alimentacionRequestFromJson(jsonString);

import 'dart:convert';

AlimentacionRequest alimentacionRequestFromJson(String str) => AlimentacionRequest.fromJson(json.decode(str));

String alimentacionRequestToJson(AlimentacionRequest data) => json.encode(data.toJson());

class AlimentacionRequest {
    AlimentacionRequest({
        this.actividades,
        this.aspectosEvaluar,
        this.codigoproyecto,
        this.descripcion,
        this.documentosObligatorios,
        this.documentosOpcionales,
        this.factoresAtraso,
        this.fechaGeneracionRendimientos,
        this.fechaReintegroRendimientos,
        this.fotoPrincipal,
        this.imagenesComplementarias,
        this.indicadoresAlcance,
        this.periodoId,
        this.usuario,
        this.valorRendimientosGenerados,
        this.valorRendimientosMesActual,
        this.valorRendimientosMesVencido,
    });

    List<ActividadRequest> actividades;
    List<AspectoEvaluarRequest> aspectosEvaluar;
    int codigoproyecto;
    String descripcion;
    List<DocumentoRequest> documentosObligatorios;
    List<DocumentoRequest> documentosOpcionales;
    List<FactoresAtrasoRequest> factoresAtraso;
    DateTime fechaGeneracionRendimientos;
    DateTime fechaReintegroRendimientos;
    FotoPrincipalRequest fotoPrincipal;
    List<FotoPrincipalRequest> imagenesComplementarias;
    List<IndicadoresAlcanceRequest> indicadoresAlcance;
    int periodoId;
    String usuario;
    double valorRendimientosGenerados;
    double valorRendimientosMesActual;
    double valorRendimientosMesVencido;

    factory AlimentacionRequest.fromJson(Map<String, dynamic> json) => AlimentacionRequest(
        actividades: List<ActividadRequest>.from(json["actividades"].map((x) => ActividadRequest.fromJson(x))),
        aspectosEvaluar: List<AspectoEvaluarRequest>.from(json["aspectosEvaluar"].map((x) => AspectoEvaluarRequest.fromJson(x))),
        codigoproyecto: json["codigoproyecto"],
        descripcion: json["descripcion"],
        documentosObligatorios: List<DocumentoRequest>.from(json["documentosObligatorios"].map((x) => DocumentoRequest.fromJson(x))),
        documentosOpcionales: List<DocumentoRequest>.from(json["documentosOpcionales"].map((x) => DocumentoRequest.fromJson(x))),
        factoresAtraso: List<FactoresAtrasoRequest>.from(json["factoresAtraso"].map((x) => FactoresAtrasoRequest.fromJson(x))),
        fechaGeneracionRendimientos: DateTime.parse(json["fechaGeneracionRendimientos"]),
        fechaReintegroRendimientos: DateTime.parse(json["fechaReintegroRendimientos"]),
        fotoPrincipal: FotoPrincipalRequest.fromJson(json["fotoPrincipal"]),
        imagenesComplementarias: List<FotoPrincipalRequest>.from(json["imagenesComplementarias"].map((x) => FotoPrincipalRequest.fromJson(x))),
        indicadoresAlcance: List<IndicadoresAlcanceRequest>.from(json["indicadoresAlcance"].map((x) => IndicadoresAlcanceRequest.fromJson(x))),
        periodoId: json["periodoId"],
        usuario: json["usuario"],
        valorRendimientosGenerados: json["valorRendimientosGenerados"],
        valorRendimientosMesActual: json["valorRendimientosMesActual"],
        valorRendimientosMesVencido: json["valorRendimientosMesVencido"],
    );

    Map<String, dynamic> toJson() => {
        "actividades": List<dynamic>.from(actividades.map((x) => x.toJson())),
        "aspectosEvaluar": List<dynamic>.from(aspectosEvaluar.map((x) => x.toJson())),
        "codigoproyecto": codigoproyecto,
        "descripcion": descripcion,
        "documentosObligatorios": List<dynamic>.from(documentosObligatorios.map((x) => x.toJson())),
        "documentosOpcionales": List<dynamic>.from(documentosOpcionales.map((x) => x.toJson())),
        "factoresAtraso": List<dynamic>.from(factoresAtraso.map((x) => x.toJson())),
        "fechaGeneracionRendimientos": fechaGeneracionRendimientos.toIso8601String(),
        "fechaReintegroRendimientos": fechaReintegroRendimientos.toIso8601String(),
        "fotoPrincipal": fotoPrincipal.toJson(),
        "imagenesComplementarias": List<dynamic>.from(imagenesComplementarias.map((x) => x.toJson())),
        "indicadoresAlcance": List<dynamic>.from(indicadoresAlcance.map((x) => x.toJson())),
        "periodoId": periodoId,
        "usuario": usuario,
        "valorRendimientosGenerados": valorRendimientosGenerados,
        "valorRendimientosMesActual": valorRendimientosMesActual,
        "valorRendimientosMesVencido": valorRendimientosMesVencido,
    };
}

class ActividadRequest {
    ActividadRequest({
        this.actividadId,
        this.cantidadEjecutada,
    });

    int actividadId;
    double cantidadEjecutada;

    factory ActividadRequest.fromJson(Map<String, dynamic> json) => ActividadRequest(
        actividadId: json["actividadId"],
        cantidadEjecutada: json["cantidadEjecutada"],
    );

    Map<String, dynamic> toJson() => {
        "actividadId": actividadId,
        "cantidadEjecutada": cantidadEjecutada,
    };
}

class AspectoEvaluarRequest {
    AspectoEvaluarRequest({
        this.aspectoEvaluarId,
        this.dificultadesAspectoEvaluar,
        this.logrosAspectoEvaluar,
    });

    int aspectoEvaluarId;
    String dificultadesAspectoEvaluar;
    String logrosAspectoEvaluar;

    factory AspectoEvaluarRequest.fromJson(Map<String, dynamic> json) => AspectoEvaluarRequest(
        aspectoEvaluarId: json["aspectoEvaluarId"],
        dificultadesAspectoEvaluar: json["dificultadesAspectoEvaluar"],
        logrosAspectoEvaluar: json["logrosAspectoEvaluar"],
    );

    Map<String, dynamic> toJson() => {
        "aspectoEvaluarId": aspectoEvaluarId,
        "dificultadesAspectoEvaluar": dificultadesAspectoEvaluar,
        "logrosAspectoEvaluar": logrosAspectoEvaluar,
    };
}

class DocumentoRequest {
    DocumentoRequest({
        this.documento,
        this.extension,
        this.nombre,
        this.tipoId,
    });

    String documento;
    String extension;
    String nombre;
    int tipoId;

    factory DocumentoRequest.fromJson(Map<String, dynamic> json) => DocumentoRequest(
        documento: json["documento"],
        extension: json["extension"],
        nombre: json["nombre"],
        tipoId: json["tipoId"],
    );

    Map<String, dynamic> toJson() => {
        "documento": documento,
        "extension": extension,
        "nombre": nombre,
        "tipoId": tipoId,
    };
}

class FactoresAtrasoRequest {
    FactoresAtrasoRequest({
        this.descripcion,
        this.factorAtrasoId,
    });

    String descripcion;
    int factorAtrasoId;

    factory FactoresAtrasoRequest.fromJson(Map<String, dynamic> json) => FactoresAtrasoRequest(
        descripcion: json["descripcion"],
        factorAtrasoId: json["factorAtrasoId"],
    );

    Map<String, dynamic> toJson() => {
        "descripcion": descripcion,
        "factorAtrasoId": factorAtrasoId,
    };
}

class FotoPrincipalRequest {
    FotoPrincipalRequest({
        this.image,
        this.nombre,
        this.tipo,
    });

    String image;
    String nombre;
    String tipo;

    factory FotoPrincipalRequest.fromJson(Map<String, dynamic> json) => FotoPrincipalRequest(
        image: json["image"],
        nombre: json["nombre"],
        tipo: json["tipo"],
    );

    Map<String, dynamic> toJson() => {
        "image": image,
        "nombre": nombre,
        "tipo": tipo,
    };
}

class IndicadoresAlcanceRequest {
    IndicadoresAlcanceRequest({
        this.cantidadEjecucion,
        this.indicadorAlcanceId,
    });

    int cantidadEjecucion;
    int indicadorAlcanceId;

    factory IndicadoresAlcanceRequest.fromJson(Map<String, dynamic> json) => IndicadoresAlcanceRequest(
        cantidadEjecucion: json["cantidadEjecucion"],
        indicadorAlcanceId: json["indicadorAlcanceId"],
    );

    Map<String, dynamic> toJson() => {
        "cantidadEjecucion": cantidadEjecucion,
        "indicadorAlcanceId": indicadorAlcanceId,
    };
}
