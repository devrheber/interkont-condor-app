import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:flutter/material.dart';

class DelayFactorProvider extends ChangeNotifier {
  DelayFactorProvider({
    required ProjectsCacheRepository projectsCacheRepository,
  }) : _projectsCacheRepository = projectsCacheRepository {
    cache = _projectsCacheRepository.getCache()!;
    detail = _projectsCacheRepository.getDetail(projectCode)!;
    delayFactorsRegistered = cache.delayFactors ?? [];
  }

  final ProjectsCacheRepository _projectsCacheRepository;
  late DatosAlimentacion detail;
  late ProjectCache cache;

  bool get isAllowedContinue => delayFactorsRegistered.isNotEmpty;

  int get projectCode => cache.projectCode!;

  TiposFactorAtraso? delayFactorTypeSelected;
  FactoresAtraso? delayFactorSelected;

  List<FactoresAtraso> delayFactorsFiltered = [];

  List<DelayFactor> delayFactorsRegistered = [];

  void selectTypeDelayFactor(TiposFactorAtraso type) {
    delayFactorTypeSelected = type;
    delayFactorsFiltered = filterDelayFactors(type.tipoFactorAtrasoId);
    delayFactorSelected = null;
    notifyListeners();
  }

  List<FactoresAtraso> filterDelayFactors(int typeFactorId) {
    return detail.factoresAtraso
        .where((factor) => factor.tipoFactorAtrasoId == typeFactorId)
        .toList();
  }

  void selectDelayFactor(FactoresAtraso value) {
    delayFactorSelected = value;
    notifyListeners();
  }

  Future<void> add(String description) async {
    if (delayFactorsRegistered.any((factor) =>
        factor.tipoFactorAtrasoId ==
            delayFactorTypeSelected!.tipoFactorAtrasoId &&
        factor.factorAtrasoId == delayFactorSelected!.factorAtrasoId)) {
      return;
    }

    delayFactorsRegistered.add(DelayFactor(
      tipoFactorAtrasoId: delayFactorTypeSelected!.tipoFactorAtrasoId,
      tipoFactor: delayFactorTypeSelected!.tipoFactorAtraso,
      factorAtrasoId: delayFactorSelected!.factorAtrasoId,
      factor: delayFactorSelected!.factorAtraso,
      description: description,
    ));

    delayFactorSelected = null;
    notifyListeners();

    this.cache = cache.copyWith(delayFactors: delayFactorsRegistered);
    await _projectsCacheRepository.saveProjectCache(projectCode, this.cache);
  }

  void remove(int index) {
    delayFactorsRegistered.removeAt(index);
    notifyListeners();
    this.cache = cache.copyWith(delayFactors: delayFactorsRegistered);
    _projectsCacheRepository.saveProjectCache(projectCode, this.cache);
  }

  bool get secondButtonValidation => delayFactorsRegistered.isEmpty;

  
}
