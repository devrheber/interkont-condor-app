import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:flutter/material.dart';

class DelayFactorProvider extends ChangeNotifier {
  DelayFactorProvider(
      {@required ProjectsCacheRepository projectsCacheRepository,
      @required this.cache,
      @required this.detail})
      : _projectsCacheRepository = projectsCacheRepository;

  final ProjectsCacheRepository _projectsCacheRepository;
  final DatosAlimentacion detail;
  final ProjectCache cache;

  bool get isAllowedContinue => delayFactorsRegistered.isNotEmpty;

  TiposFactorAtraso delayFactorTypeSelected;
  FactoresAtraso delayFactorSelected;

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

  void add(String description) {
    if (delayFactorsRegistered.any((factor) =>
        factor.tipoFactorAtrasoId ==
            delayFactorTypeSelected.tipoFactorAtrasoId &&
        factor.factorAtrasoId == delayFactorSelected.factorAtrasoId)) {
      return;
    }

    delayFactorsRegistered.add(DelayFactor(
      tipoFactorAtrasoId: delayFactorTypeSelected.tipoFactorAtrasoId,
      tipoFactor: delayFactorTypeSelected.tipoFactorAtraso,
      factorAtrasoId: delayFactorSelected.factorAtrasoId,
      factor: delayFactorSelected.factorAtraso,
      description: description,
    ));

    delayFactorSelected = null;
    notifyListeners();
  }

  void remove(int index) {
    delayFactorsRegistered.removeAt(index);
    notifyListeners();
  }
}
