import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';

import 'package:appalimentacion/domain/models/aom_datos_generales.dart';

import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:dio/src/cancel_token.dart';

class AomRepositoryImplLocal extends AomProjectsRepository {
  @override
  Future<List<CategoriaObra>> categoriasByObraId(int obraId,
      {CancelToken? cancelToken}) async {
    return [
      CategoriaObra(
          id: 1,
          clasificacionActivos: const ClasificacionActivos(
              id: 1,
              categoria: 1,
              descripcion: 'Prueba',
              nivelTension: 1,
              vidaUtil: 420),
          obraId: 1,
          estadoClasificacion: 3,
          relacionReporteHistorial: []),
    ];
  }

  @override
  Future<List<Clasificacion>> getClasifications({CancelToken? cancelToken}) {
    // TODO: implement getClasifications
    throw UnimplementedError();
  }

  @override
  Future<List<Contratista>> getContratistas({CancelToken? cancelToken}) async {
    return [
      const Contratista(id: 12088, contratista: "Contratista de Prueba"),
    ];
  }

  @override
  Future<AomDatosGenerales> getDatosGenerales(int projectCode,
      {CancelToken? cancelToken}) async {
    return AomDatosGenerales(
        obraId: 1,
        operadorId: 12088,
        id: 0,
        relacionContratos: [
          RelacionContrato(
            id: 0,
            obraOriginal: 1,
            contrato: Contrato(
                id: 1,
                numeroContrato: '1',
                tipoContrato: 100,
                valorDisponible: 100),
            numvalorrelacion: 10,
          ),
        ]);
  }

  @override
  Future<List<EstadoDeActivo>> getEstados({CancelToken? cancelToken}) async {
    return [
      EstadoDeActivo(id: 1, strNombreEstado: 'Prueba', tipoEstado: 1),
    ];
  }

  @override
  Future<List<GestionAom>> getGestionAom(int obraId,
      {CancelToken? cancelToken}) async {
    return [
      GestionAom(
          id: 1,
          categoriaId: 2,
          descripcionId: 1,
          descripcionCategoria: "",
          valorDepreciacion: 1000,
          estadoSupervisorId: 1,
          estadoNombreSupervisor: "Prueba",
          cantidad: 1,
          estadoAomId: 1,
          estadoNombreAom: "",
          obraId: obraId,
          vidaUtil: 420,
          nivelTension: 1,
          descripcionDetalle: "",
          unidadId: 1,
          strNombreUnidad: "",
          valorInicial: 10000,
          anosRestantes: 420,
          tipoMapaActivo: 1,
          clasificacionRelacionObraActivos: 1,
          operatividad: false),
    ];
  }

  @override
  Future<void> sendData(
      {CancelToken? cancelToken,
      required AomActualizacionRequest data,
      required Function(int count, int total) onSendProgress,
      required Function(int count, int total) onReceiveProgress}) async {
    throw UnimplementedError();
    await Future.delayed(const Duration(seconds: 3));
    //   return AomActualizacionRequestResponse(
    //       id: 20,
    //       createdAt: DateTime.parse("2022-11-19T13:45:15"),
    //       createdBy: "interkont@2",
    //       estadoRevisionTecnica: 1,
    //       repuesta1: false,
    //       repuesta2: false,
    //       repuesta3: false,
    //       repuesta4: false,
    //       repuesta5: false,
    //       repuesta6: false,
    //       repuesta7: false,
    //       strObservacionNoVidaUtil: "observacion de prueba",
    //       vidaUtilConsiderada: "420",
    //       obraId: 2979,
    //       clasificacionId: 117,
    //       documentosRelacionados: [],
    //       activosRelacionesClasificacion: [],
    //       observacionesRevisionTecnica: null);
  }

  @override
  Future<UploadFileResponse> uploadFile(
      {CancelToken? cancelToken,
      required UploadFileRequest uploadFileRequest,
      required Function(int count, int total) onSendProgress,
      required Function(int count, int total) onReceiveProgress}) async {
    int initialValue = 0;
    Timer timer;

    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      onSendProgress((initialValue++), 10);

      if (initialValue == 10) timer.cancel();
    });

    await Future.delayed(Duration(seconds: 5));

    return UploadFileResponse(id: 1, message: 'file uploaded', status: true);

    throw AomProjectsBackendErrorException({
      'data': {'message': 'Error inesperado'}
    });
  }
}
