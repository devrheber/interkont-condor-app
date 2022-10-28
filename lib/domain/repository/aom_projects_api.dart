import 'package:appalimentacion/domain/models/models.dart';

abstract class AomProjectsApi {
  const AomProjectsApi();

  List<Contratista> getContratistas();

  void saveContratistas(List<Contratista> list);

  Contratista? getContratistaById(int? id);
}
