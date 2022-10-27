import 'package:appalimentacion/domain/models/clasificacion.dart';
import 'package:dio/dio.dart';

abstract class AomProjectsRepository {
  Future<List<Clasificacion>> getClasifications({CancelToken? cancelToken});
}

abstract class AomProjectsRepositoryException implements Exception {}

class AomProjectsBackendErrorException extends AomProjectsRepositoryException {}

class AomProjectsSlowConnectionException
    extends AomProjectsRepositoryException {}

class AomProjectsForbiddenException extends AomProjectsRepositoryException {}

class AomProjectsOtherEception extends AomProjectsRepositoryException {}

class AomProjectsCancelException extends AomProjectsRepositoryException {}
