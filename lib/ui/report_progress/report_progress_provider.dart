import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:flutter/material.dart';

class ReportarAvanceProvider extends ChangeNotifier {
  ReportarAvanceProvider({
    @required this.project,
    @required this.detail,
    @required ProjectsCacheRepository projectsCacheRepository,
    @required this.cache,
  }) : _projectsCacheRepository = projectsCacheRepository;

  final Project project;
  final DatosAlimentacion detail;
  final ProjectsCacheRepository _projectsCacheRepository;
  ProjectCache cache;

  void changeAndSaveStep(int step) {
    this.cache = this.cache.copyWith(stepNumber: step);

    _projectsCacheRepository.saveProjectCache(
        project.codigoproyecto.toString(), this.cache);

    notifyListeners();
  }
}
