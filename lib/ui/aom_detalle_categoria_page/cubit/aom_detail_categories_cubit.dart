import 'dart:developer';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_detail_categories_state.dart';

class AomDetailCategoriesCubit extends Cubit<AomDetailCategoriesState> {
  AomDetailCategoriesCubit({
    required AomProjectsRepository aomProjectsRepository,
    required AomProjectsApi aomProjectsApi,
  })  : _aomProjectsRepository = aomProjectsRepository,
        _aomProjectsApi = aomProjectsApi,
        super(AomDetailCategoriesInitial());

  final AomProjectsRepository _aomProjectsRepository;
  final AomProjectsApi _aomProjectsApi;

  Future<void> _getGestionObra(int projectCode) async {
    emit(state.copyWith(status: () => AomDetailCategoriesStatus.loading));
    try {
      final list = await _aomProjectsRepository.getGestionAom(projectCode);
      emit(state.copyWith(
        gestionAom: () =>
            list.where((activo) => activo.descripcionId == 2).toList(),
        status: () => AomDetailCategoriesStatus.success,
      ));
    } on AomProjectsRepositoryException catch (_) {
      // TODO
      emit(state.copyWith(
        status: () => AomDetailCategoriesStatus.failure,
      ));
    }
  }

  Future<void> _getEstados() async {
    List<EstadoDeActivo> estados = _aomProjectsApi.getEstadosDeActivos();

    if (estados.isNotEmpty) {
      emit(state.copyWith(estados: () => estados));
      return;
    }

    estados = await _aomProjectsRepository.getEstados();
    _aomProjectsApi.saveEstadosDeActivos(estados);
    emit(state.copyWith(estados: () => estados));
  }

  Future<void> loadData(int projectCode) async {
    emit(state.copyWith(status: () => AomDetailCategoriesStatus.loading));
    try {
      await _getGestionObra(projectCode);
      await _getEstados();
    } on AomProjectsRepositoryException catch (error) {
      inspect(error);
      emit(
        state.copyWith(
          status: () => AomDetailCategoriesStatus.failure,
        ),
      );
    }
  }

  void updateEstadoDeActivo(int activoId, EstadoDeActivo? estado) {
    if (estado == null) return;
    Map<int, EstadoDeActivo> estados = {...state.estadosSeleccionados};
    estados[activoId] = estado;
    Future.delayed(const Duration(milliseconds: 200)).then((_) {
      emit(
        state.copyWith(estadosSeleccionados: () => estados),
      );
    });
  }
}
