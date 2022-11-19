import 'dart:async';

import 'package:appalimentacion/domain/models/upload_file_response.dart';
import 'package:appalimentacion/domain/models/upload_file_request.dart';
import 'package:appalimentacion/domain/models/gestion_aom.dart';
import 'package:appalimentacion/domain/models/estado_de_activo.dart';
import 'package:appalimentacion/domain/models/contratista.dart';
import 'package:appalimentacion/domain/models/clasificacion.dart';
import 'package:appalimentacion/domain/models/categoria_obra.dart';
import 'package:appalimentacion/domain/models/aom_datos_generales.dart';
import 'package:appalimentacion/domain/models/aom_actualizacion_request.dart';
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
  Future<Map<String, dynamic>> sendData(
      {CancelToken? cancelToken,
      required AomActualizacionRequest data,
      required Function(int count, int total) onSendProgress,
      required Function(int count, int total) onReceiveProgress}) {
    // TODO: implement sendData
    throw UnimplementedError();
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

    await Future.delayed(Duration(seconds: 12));

    return UploadFileResponse(id: 1, message: 'file uploaded', status: true);

    throw AomProjectsBackendErrorException({
      'data': {'message': 'Error inesperado'}
    });
  }
}
