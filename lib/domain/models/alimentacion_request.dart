// To parse this JSON data, do
//
//     final alimentacionRequest = alimentacionRequestFromJson(jsonString);

import 'dart:convert';

AlimentacionRequest alimentacionRequestFromJson(String str) =>
    AlimentacionRequest.fromJson(json.decode(str));

String alimentacionRequestToJson(AlimentacionRequest data) =>
    json.encode(data.toJson());

class AlimentacionRequest {
  AlimentacionRequest({
    this.actividades,
    this.aspectosEvaluar,
    required this.codigoproyecto,
    required this.descripcion,
    required this.documentosObligatorios,
    this.documentosOpcionales,
    this.factoresAtraso,
    this.fechaGeneracionRendimientos,
    this.fechaReintegroRendimientos,
    this.fotoPrincipal,
    this.imagenesComplementarias,
    this.indicadoresAlcance,
    required this.periodoId,
    required this.usuario,
    this.valorRendimientosGenerados,
    this.valorReintegroRendimientos,
    this.valorSaldoFinalExtracto,
  });

  final List<ActividadRequest>? actividades;
  final List<AspectoEvaluarRequest>? aspectosEvaluar;
  final int codigoproyecto;
  final String descripcion;
  final List<DocumentoRequest> documentosObligatorios;
  final List<DocumentoRequest>? documentosOpcionales;
  final List<FactoresAtrasoRequest>? factoresAtraso;
  final String? fechaGeneracionRendimientos;
  final String? fechaReintegroRendimientos;
  final FotoPrincipalRequest? fotoPrincipal;
  final List<FotoPrincipalRequest>? imagenesComplementarias;
  final List<IndicadoresAlcanceRequest>? indicadoresAlcance;
  final int periodoId;
  final String usuario;
  final double? valorRendimientosGenerados;
  final double? valorReintegroRendimientos;
  final double? valorSaldoFinalExtracto;

  factory AlimentacionRequest.fromJson(Map<String, dynamic> json) =>
      AlimentacionRequest(
        actividades: List<ActividadRequest>.from(
            json["actividades"].map((x) => ActividadRequest.fromJson(x))),
        aspectosEvaluar: List<AspectoEvaluarRequest>.from(
            json["aspectosEvaluar"]
                .map((x) => AspectoEvaluarRequest.fromJson(x))),
        codigoproyecto: json["codigoproyecto"],
        descripcion: json["descripcion"],
        documentosObligatorios: List<DocumentoRequest>.from(
            json["documentosObligatorios"]
                .map((x) => DocumentoRequest.fromJson(x))),
        documentosOpcionales: List<DocumentoRequest>.from(
            json["documentosOpcionales"]
                .map((x) => DocumentoRequest.fromJson(x))),
        factoresAtraso: List<FactoresAtrasoRequest>.from(json["factoresAtraso"]
            .map((x) => FactoresAtrasoRequest.fromJson(x))),
        fechaGeneracionRendimientos: json["fechaGeneracionRendimientos"],
        fechaReintegroRendimientos: json["fechaReintegroRendimientos"],
        fotoPrincipal: FotoPrincipalRequest.fromJson(json["fotoPrincipal"]),
        imagenesComplementarias: List<FotoPrincipalRequest>.from(
            json["imagenesComplementarias"]
                .map((x) => FotoPrincipalRequest.fromJson(x))),
        indicadoresAlcance: List<IndicadoresAlcanceRequest>.from(
            json["indicadoresAlcance"]
                .map((x) => IndicadoresAlcanceRequest.fromJson(x))),
        periodoId: json["periodoId"],
        usuario: json["usuario"],
        valorRendimientosGenerados: json["valorRendimientosGenerados"],
        valorReintegroRendimientos: json["valorReintegroRendimientos"],
        valorSaldoFinalExtracto: json["valorSaldoFinalExtracto"],
      );

  Map<String, dynamic> toJson() => {
        "actividades": actividades == null
            ? null
            : List<dynamic>.from(actividades!.map((x) => x.toJson())),
        "aspectosEvaluar": aspectosEvaluar == null
            ? null
            : List<dynamic>.from(aspectosEvaluar!.map((x) => x.toJson())),
        "codigoproyecto": codigoproyecto,
        "descripcion": descripcion,
        "documentosObligatorios":
            List<dynamic>.from(documentosObligatorios.map((x) => x.toJson())),
        "documentosOpcionales": documentosOpcionales == null
            ? null
            : List<dynamic>.from(documentosOpcionales!.map((x) => x.toJson())),
        "factoresAtraso": factoresAtraso == null
            ? null
            : List<dynamic>.from(factoresAtraso!.map((x) => x.toJson())),
        "fechaGeneracionRendimientos": fechaGeneracionRendimientos,
        "fechaReintegroRendimientos": fechaReintegroRendimientos,
        "fotoPrincipal": fotoPrincipal?.toJson(),
        "imagenesComplementarias": imagenesComplementarias == null
            ? null
            : List<dynamic>.from(
                imagenesComplementarias!.map((x) => x.toJson())),
        "indicadoresAlcance": indicadoresAlcance == null
            ? null
            : List<dynamic>.from(indicadoresAlcance!.map((x) => x.toJson())),
        "periodoId": periodoId,
        "usuario": usuario,
        "valorRendimientosGenerados": valorRendimientosGenerados,
        "valorReintegroRendimientos": valorReintegroRendimientos,
        "valorSaldoFinalExtracto": valorSaldoFinalExtracto,
      };
}

class ActividadRequest {
  ActividadRequest({
    required this.actividadId,
    required this.cantidadEjecutada,
  });

  final int actividadId;
  final double cantidadEjecutada;

  factory ActividadRequest.fromJson(Map<String, dynamic> json) =>
      ActividadRequest(
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
    required this.aspectoEvaluarId,
    required this.dificultadesAspectoEvaluar,
    required this.logrosAspectoEvaluar,
  });

  final int aspectoEvaluarId;
  final String dificultadesAspectoEvaluar;
  final String logrosAspectoEvaluar;

  factory AspectoEvaluarRequest.fromJson(Map<String, dynamic> json) =>
      AspectoEvaluarRequest(
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
    required this.documento,
    required this.extension,
    required this.nombre,
    required this.tipoId,
  });

  String documento;
  String extension;
  String nombre;
  int tipoId;

  factory DocumentoRequest.fromJson(Map<String, dynamic> json) =>
      DocumentoRequest(
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
    required this.descripcion,
    required this.factorAtrasoId,
  });

  final String descripcion;
  final int factorAtrasoId;

  factory FactoresAtrasoRequest.fromJson(Map<String, dynamic> json) =>
      FactoresAtrasoRequest(
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
    required this.image,
    required this.nombre,
    required this.tipo,
  });

  final String image;
  final String nombre;
  final String tipo;

  factory FotoPrincipalRequest.fromJson(Map<String, dynamic> json) =>
      FotoPrincipalRequest(
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
    required this.cantidadEjecucion,
    required this.indicadorAlcanceId,
  });

  final int cantidadEjecucion;
  final int indicadorAlcanceId;

  factory IndicadoresAlcanceRequest.fromJson(Map<String, dynamic> json) =>
      IndicadoresAlcanceRequest(
        cantidadEjecucion: json["cantidadEjecucion"],
        indicadorAlcanceId: json["indicadorAlcanceId"],
      );

  Map<String, dynamic> toJson() => {
        "cantidadEjecucion": cantidadEjecucion,
        "indicadorAlcanceId": indicadorAlcanceId,
      };
}
