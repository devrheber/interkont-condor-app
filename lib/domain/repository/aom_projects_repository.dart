import 'package:appalimentacion/domain/models/aom_datos_generales.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:dio/dio.dart';

abstract class AomProjectsRepository {
  Future<List<Clasificacion>> getClasifications({CancelToken? cancelToken});

  Future<AomDatosGenerales> getDatosGenerales(int projectCode,
      {CancelToken? cancelToken});

  Future<List<Contratista>> getContratistas({CancelToken? cancelToken});

  Future<List<CategoriaObra>> categoriasByObraId(int obraId,
      {CancelToken? cancelToken});

  Future<List<GestionAom>> getGestionAom(int obraId,
      {CancelToken? cancelToken});

  Future<List<EstadoDeActivo>> getEstados({CancelToken? cancelToken});

  Future<UploadFileResponse> uploadFile(
      {CancelToken? cancelToken, required UploadFileRequest uploadFileRequest});
}

// TODO Estas clases debererín funcionar para Projectos Aom y de Alimentación
abstract class AomProjectsRepositoryException implements Exception {}

class AomProjectsBackendErrorException extends AomProjectsRepositoryException {
  AomProjectsBackendErrorException([this.response]);
  final dynamic response;
}

class AomProjectsSlowConnectionException
    extends AomProjectsRepositoryException {}

class AomProjectsForbiddenException extends AomProjectsRepositoryException {}

class AomProjectsOtherEception extends AomProjectsRepositoryException {}

class AomProjectsCancelException extends AomProjectsRepositoryException {}
