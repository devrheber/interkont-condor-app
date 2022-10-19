import 'package:appalimentacion/domain/models/models.dart';
import 'package:flutter/foundation.dart';

abstract class ProjectsRepository {
  Future<List<Project>> getProjects();

  Future<DatosAlimentacion> getDatosAlimentacion(
      {@required String codigoProyecto});

  Future<List<TipoDoc>> getTipoDoc();

  Future<Map<String, dynamic>> sendData(AlimentacionRequest data,
      {@required void onSendProgress(int count, int total)});
}

abstract class ProjectsRepositoryException implements Exception {}

class SlowConnectionException extends ProjectsRepositoryException {}

class NoInternetException extends ProjectsRepositoryException {}

class ResponseException extends ProjectsRepositoryException {}

class OtherException implements ProjectsRepositoryException {
  const OtherException(this.message);
  final String message;
}
