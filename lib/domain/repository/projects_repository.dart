import '../models/models.dart';

abstract class ProjectsRepository {
  Future<List<Project>> getAlimentacionProjects();

  Future<List<Project>> getAomProjects();

  Future<DatosAlimentacion> getDatosAlimentacion(
      {required String codigoProyecto});

  Future<List<TipoDoc>> getTipoDoc();

  Future<Map<String, dynamic>> sendData(
    AlimentacionRequest data, {
    required void onSendProgress(int count, int total),
    required void onReceiveProgress(int count, int total),
  });
}

abstract class ProjectsRepositoryException implements Exception {}

class SlowConnectionException extends ProjectsRepositoryException {}

class NoInternetException extends ProjectsRepositoryException {}

class ResponseException extends ProjectsRepositoryException {}

class OtherException implements ProjectsRepositoryException {
  const OtherException(this.message);
  final String message;
}
