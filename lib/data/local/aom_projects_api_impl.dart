import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';

class AomProjectsApiImpl implements AomProjectsApi {
  List<Contratista> _contratistas = [];
  List<EstadoDeActivo> _estados = [];

  Timer? timer;

  @override
  List<Contratista> getContratistas() {
    return _contratistas;
  }

  @override
  void saveContratistas(List<Contratista> list) {
    _contratistas = list;
    timer?.cancel();
    timer = Timer(const Duration(minutes: 5), () => _contratistas = []);
  }

  @override
  Contratista? getContratistaById(int? id) {
    final int index =
        _contratistas.indexWhere((contratista) => contratista.id == id);

    if (index < 0) return null;

    return _contratistas[index];
  }

  @override
  List<EstadoDeActivo> getEstadosDeActivos() {
    return _estados;
  }

  @override
  void saveEstadosDeActivos(List<EstadoDeActivo> list) {
    _estados = list;
    timer?.cancel();
    timer = Timer(const Duration(minutes: 5), () => _contratistas = []);
  }

  @override
  EstadoDeActivo? getEstadoById(int? id) {
    final index = _estados.indexWhere((estado) => estado.id == id);

    if (index < 0) return null;

    return _estados[index];
  }
}
