import 'package:appalimentacion/domain/models/models.dart';
import 'package:flutter/foundation.dart';

abstract class ProjectsRepository {
  Future<List<Project>> getProjects();

  Future<DatosAlimentacion> getDatosAlimentacion(
      {@required String codigoProyecto});

  Future<List<TipoDoc>> getTipoDoc();
}
