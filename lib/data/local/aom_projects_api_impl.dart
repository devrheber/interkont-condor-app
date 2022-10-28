import 'package:appalimentacion/domain/models/contratista.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';

class AomProjectsApiImpl implements AomProjectsApi {
  List<Contratista> contratistas = [];

  @override
  List<Contratista> getContratistas() {
    return contratistas;
  }

  @override
  void saveContratistas(List<Contratista> list) {
    contratistas = list;
  }

  @override
  Contratista? getContratistaById(int? id) {
    final int index =
        contratistas.indexWhere((contratista) => contratista.id == id);

    if (index < 0) return null;

    return contratistas[index];
  }
}
