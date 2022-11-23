import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';

import 'package:appalimentacion/domain/models/aom_datos_generales.dart';

import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:dio/src/cancel_token.dart';

class AomRepositoryImplLocal extends AomProjectsRepository {
  @override
  Future<List<CategoriaObra>> categoriasByObraId(int obraId,
      {CancelToken? cancelToken}) {
    // TODO: implement categoriasByObraId
    throw UnimplementedError();
  }

  @override
  Future<List<Clasificacion>> getClasifications({CancelToken? cancelToken}) {
    // TODO: implement getClasifications
    throw UnimplementedError();
  }

  @override
  Future<List<Contratista>> getContratistas({CancelToken? cancelToken}) {
    // TODO: implement getContratistas
    throw UnimplementedError();
  }

  @override
  Future<AomDatosGenerales> getDatosGenerales(int projectCode,
      {CancelToken? cancelToken}) {
    // TODO: implement getDatosGenerales
    throw UnimplementedError();
  }

  @override
  Future<List<EstadoDeActivo>> getEstados({CancelToken? cancelToken}) {
    // TODO: implement getEstados
    throw UnimplementedError();
  }

  @override
  Future<List<GestionAom>> getGestionAom(int obraId,
      {CancelToken? cancelToken}) {
    // TODO: implement getGestionAom
    throw UnimplementedError();
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
