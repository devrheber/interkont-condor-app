import 'package:appalimentacion/domain/models/tipo_doc_model.dart';
import 'package:appalimentacion/domain/models/project.dart';
import 'package:appalimentacion/domain/models/datos_alimentacion.dart';
import 'package:appalimentacion/domain/models/alimentacion_request.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';

class ProjectsImplLocal implements ProjectsRepository {
  @override
  Future<DatosAlimentacion> getDatosAlimentacion(
      {required String codigoProyecto}) async {
    return DatosAlimentacion(
        limitePorcentajeAtraso: 5,
        limitePorcentajeAtrasoAmarillo: 10,
        periodos: [
          Periodo(
              periodoId: 21,
              fechaIniPeriodo: '22-07-2022',
              fechaFinPeriodo: '25-07-2022',
              porcentajeProyectado: 50),
          Periodo(
              periodoId: 22,
              fechaIniPeriodo: '01-08-2022',
              fechaFinPeriodo: '10-08-2022',
              porcentajeProyectado: 70),
        ],
        actividades: [
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
              cantidadEjecutadaInicial: 0,
              valorEjecutadoInicial: 0,
              porcentajeAvanceInicial: 0),
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
        apectosEvaluar: [
          AspectoEvaluar(
              aspectoEvaluarId: 51, descripcionAspectoEvaluar: 'Financiero'),
        ],
        tiposFactorAtraso: [
          TiposFactorAtraso(
              tipoFactorAtrasoId: 61, tipoFactorAtraso: 'Corrupción')
        ],
        factoresAtraso: [
          FactoresAtraso(
              factorAtrasoId: 71,
              factorAtraso: 'Factor Atraso de Prueba',
              tipoFactorAtrasoId: 61)
        ]);
  }

  @override
  Future<List<Project>> getProjects() async {
    return [
      Project(
          codigoproyecto: 001,
          nombreproyecto: 'Proyecto Local de Prueba',
          valorproyecto: 50000,
          valorejecutado: 0,
          porcentajeProyectado: 1,
          semaforoproyecto: 'rojo',
          codigocategoria: 1,
          imagencategoria: 'https://www.ftc.gov/sites/all/themes/ftc/images-cybersecurity-pages/homepage-quiz-basics.png',
          colorcategoria: '#FFFFFF',
          nombrecategoria: 'Categoría de prueba',
          objeto: 'Descripción de Prueba.',
          pendienteAprobacion: false)
    ];
  }

  @override
  Future<List<TipoDoc>> getTipoDoc() async {
    return [
      TipoDoc(
          id: 1,
          nombre: 'B Doc de Prueba',
          obligatorio: true,
          intparametipdoc: 1),
      TipoDoc(
          id: 2,
          nombre: 'A Doc de Prueba',
          obligatorio: true,
          intparametipdoc: 1),
      TipoDoc(
          id: 3,
          nombre: 'T Doc de Prueba',
          obligatorio: true,
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
}
