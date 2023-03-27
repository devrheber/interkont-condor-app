import 'package:appalimentacion/domain/models/tipo_doc_model.dart';
import 'package:appalimentacion/domain/models/project.dart';
import 'package:appalimentacion/domain/models/datos_alimentacion.dart';
import 'package:appalimentacion/domain/models/alimentacion_request.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:dio/dio.dart';

class ProjectsImplLocal implements ProjectsRepository {
  @override
  Future<DatosAlimentacion> getDatosAlimentacion({
    required String codigoProyecto,
    CancelToken? cancelToken,
  }) async {
    await Future.delayed(const Duration(seconds: 2));
    return DatosAlimentacion(
        limitePorcentajeAtraso: 5,
        limitePorcentajeAtrasoAmarillo: 10,
        periodos: const [
          Periodo(
              periodoId: 21,
              fechaIniPeriodo: '2022-07-23',
              fechaFinPeriodo: '2022-07-24',
              porcentajeProyectado: 50),
          Periodo(
              periodoId: 22,
              fechaIniPeriodo: '2022-08-24',
              fechaFinPeriodo: '2022-08-26',
              porcentajeProyectado: 70),
        ],
        actividades: const [
          Actividad(
            actividadId: 31,
            descripcionActividad: 'Actividad Local de Prueba',
            unidadMedida: 'M',
            valorUnitario: 10,
            cantidadProgramada: 10,
            cantidadEjecutada: 0,
            valorProgramado: 100,
            valorEjecutado: 0,
            porcentajeAvance: 0,
          ),
        ],
        indicadoresAlcance: [
          IndicadoresDeAlcance(
              indicadorAlcanceId: 41,
              descripcionIndicadorAlcance: 'Indicador Local de Prueba',
              unidadMedida: 'UND',
              cantidadProgramada: 100,
              cantidadEjecutada: 10,
              porcentajeAvance: 10,
              cantidadEjecutadaInicial: 10,
              porcentajeAvanceInicial: 10),
        ],
        apectosEvaluar: const [
          AspectoEvaluar(
              aspectoEvaluarId: 51, descripcionAspectoEvaluar: 'Financiero'),
        ],
        tiposFactorAtraso: const [
          TiposFactorAtraso(
              tipoFactorAtrasoId: 61, tipoFactorAtraso: 'Corrupción')
        ],
        factoresAtraso: const [
          FactoresAtraso(
              factorAtrasoId: 71,
              factorAtraso: 'Factor Atraso de Prueba',
              tipoFactorAtrasoId: 61)
        ]);
  }

  @override
  Future<List<Project>> getAlimentacionProjects() async {
    await Future.delayed(const Duration(seconds: 2));
    return [
      Project(
        codigoproyecto: 001,
        nombreproyecto: 'Proyecto Local de Prueba',
        valorproyecto: 50000,
        valorejecutado: 0,
        porcentajeProyectado: 1,
        semaforoproyecto: 'rojo',
        codigocategoria: 1,
        imagencategoria:
            'https://www.ftc.gov/sites/all/themes/ftc/images-cybersecurity-pages/homepage-quiz-basics.png',
        colorcategoria: '#FFFFFF',
        nombrecategoria: 'Categoría de prueba',
        objeto: 'Descripción de Prueba.',
        pendienteAprobacion: false,
        estadoobra: 9,
      ),
      Project(
        codigoproyecto: 2,
        nombreproyecto: 'Proyecto Local de Prueba 2',
        valorproyecto: 100000,
        valorejecutado: 40000,
        porcentajeProyectado: 1,
        semaforoproyecto: 'verde',
        codigocategoria: 1,
        imagencategoria:
            'https://fastly.picsum.photos/id/237/536/354.jpg?hmac=i0yVXW1ORpyCZpQ-CknuyV-jbtU7_x9EBQVhvT5aRr0',
        colorcategoria: '#FFFFFF',
        nombrecategoria: 'Categoría de prueba',
        objeto: 'Descripción de Prueba.',
        pendienteAprobacion: true,
        estadoobra: 9,
      )
    ];
  }

  @override
  Future<List<TipoDoc>> getTipoDoc() async {
    return [
      TipoDoc(
          id: 105,
          nombre: 'R Doc de Prueba',
          obligatorio: false,
          intparametipdoc: 1),
      TipoDoc(
          id: 105,
          nombre: 'Z Doc de Prueba',
          obligatorio: false,
          intparametipdoc: 1),
      TipoDoc(
          id: 102,
          nombre: 'B Doc de Prueba',
          obligatorio: true,
          intparametipdoc: 1),
      TipoDoc(
          id: 101,
          nombre: 'M Doc de Prueba',
          obligatorio: false,
          intparametipdoc: 1),
      TipoDoc(
          id: 103,
          nombre: 'A Doc de Prueba',
          obligatorio: true,
          intparametipdoc: 1),
      TipoDoc(
          id: 104,
          nombre: 'T Doc de Prueba',
          obligatorio: false,
          intparametipdoc: 1),
    ];
  }

  @override
  Future<Map<String, dynamic>> sendData(AlimentacionRequest data,
      {required void Function(int count, int total) onSendProgress,
      required void Function(int count, int total) onReceiveProgress}) {
    // TODO: implement sendData
    throw UnimplementedError();
  }

  @override
  Future<List<Project>> getAomProjects() {
    // TODO: implement getAomProjects
    throw UnimplementedError();
  }

  @override
  void cancel() {
    // TODO: implement cancel
  }
}
