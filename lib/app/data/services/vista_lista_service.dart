import 'package:appalimentacion/app/data/model/project.dart';
import 'package:appalimentacion/app/data/provider/vista_lista_api.dart';

class VistaListaService {
  final VistaListaApi _vistaListaApi = VistaListaApi();

  Future<List<Project>> getProjects() => _vistaListaApi.getProjects();
}
