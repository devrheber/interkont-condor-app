// To parse this JSON data, do
//
//     final vistaLista = vistaListaFromJson(jsonString);

import 'dart:convert';

import 'package:appalimentacion/app/data/model/datos_alimentacion_model.dart';

List<VistaLista> vistaListaFromJson(String str) =>
    List<VistaLista>.from(json.decode(str).map((x) => VistaLista.fromJson(x)));

String vistaListaToJson(List<VistaLista> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VistaLista {
  final String avanceproyecto;
  final int codigocategoria;
  final int codigoproyecto;
  final String colorcategoria;
  final String contratista;
  final String distaciaproyecto;
  final String estadoproyecto;
  final String imagencategoria;
  final String imagenproyecto;
  final int latitudproyecto;
  final String localidadproyecto;
  final int longitudproyecto;
  final String nombrecategoria;
  final String nombreproyecto;
  final String objeto;
  final bool pendienteAprobacion;
  final num porcentajeProyectado;
  final String semaforoproyecto;
  final num valorejecutado;
  final num valorproyecto;
  final DatosAlimentacion datos;
  final bool porPublicar;
  VistaLista({
    this.avanceproyecto,
    this.codigocategoria,
    this.codigoproyecto,
    this.colorcategoria,
    this.contratista,
    this.distaciaproyecto,
    this.estadoproyecto,
    this.imagencategoria,
    this.imagenproyecto,
    this.latitudproyecto,
    this.localidadproyecto,
    this.longitudproyecto,
    this.nombrecategoria,
    this.nombreproyecto,
    this.objeto,
    this.pendienteAprobacion,
    this.porcentajeProyectado,
    this.semaforoproyecto,
    this.valorejecutado,
    this.valorproyecto,
    this.datos,
    this.porPublicar,
  });

  factory VistaLista.fromJson(Map<String, dynamic> json) => VistaLista(
        avanceproyecto: json["avanceproyecto"],
        codigocategoria: json["codigocategoria"],
        codigoproyecto: json["codigoproyecto"],
        colorcategoria: json["colorcategoria"],
        contratista: json["contratista"] ?? '--',
        distaciaproyecto: json["distaciaproyecto"],
        estadoproyecto: json["estadoproyecto"],
        imagencategoria: json["imagencategoria"],
        imagenproyecto: json["imagenproyecto"],
        latitudproyecto: json["latitudproyecto"],
        localidadproyecto: json["localidadproyecto"],
        longitudproyecto: json["longitudproyecto"],
        nombrecategoria: json["nombrecategoria"],
        nombreproyecto: json["nombreproyecto"],
        objeto: json["objeto"],
        pendienteAprobacion: json["pendienteAprobacion"],
        porcentajeProyectado: json["porcentajeProyectado"],
        semaforoproyecto: json["semaforoproyecto"],
        valorejecutado: json["valorejecutado"],
        valorproyecto: json["valorproyecto"],
        datos: json["datos"],
        porPublicar: json["porPublicar"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "avanceproyecto": avanceproyecto,
        "codigocategoria": codigocategoria,
        "codigoproyecto": codigoproyecto,
        "colorcategoria": colorcategoria,
        "contratista": contratista,
        "distaciaproyecto": distaciaproyecto,
        "estadoproyecto": estadoproyecto,
        "imagencategoria": imagencategoria,
        "imagenproyecto": imagenproyecto,
        "latitudproyecto": latitudproyecto,
        "localidadproyecto": localidadproyecto,
        "longitudproyecto": longitudproyecto,
        "nombrecategoria": nombrecategoria,
        "nombreproyecto": nombreproyecto,
        "objeto": objeto,
        "pendienteAprobacion": pendienteAprobacion,
        "porcentajeProyectado": porcentajeProyectado,
        "semaforoproyecto": semaforoproyecto,
        "valorejecutado": valorejecutado,
        "valorproyecto": valorproyecto,
        "datos": datosAlimentacionToJson(datos),
        "porPublicar": porPublicar,
      };
}
