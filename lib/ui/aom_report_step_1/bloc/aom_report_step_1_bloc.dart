import 'dart:developer';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_report_step_1_event.dart';
part 'aom_report_step_1_state.dart';

class AomReportStep1Bloc
    extends Bloc<AomReportStep1Event, AomReportStep1State> {
  AomReportStep1Bloc({
    required AomProjectsRepository aomProjectsRepository,
    required AomProjectsApi aomProjectsApi,
  })  : _aomProjectsRepository = aomProjectsRepository,
        _aomProjectsApi = aomProjectsApi,
        super(AomReportStep1State()) {
    on<LoadDataEvent>(_onLoadData);
    on<UpdateActivoEvent>(_onUpdateActivoEvent);
  }

  final AomProjectsRepository _aomProjectsRepository;
  final AomProjectsApi _aomProjectsApi;

  Future<void> _onLoadData(
    LoadDataEvent event,
    Emitter<AomReportStep1State> emit,
  ) async {
    emit(state.copyWith(status: () => AomCategoryDetailStatus.loading));
    try {
      final activos =
          await _getGestionObra(event.projectCode, event.categoryId);
      final estados = await _getEstados();

      emit(state.copyWith(
        gestionAom: () => activos,
        estados: () => estados,
        status: () => AomCategoryDetailStatus.success,
      ));
    } on AomProjectsRepositoryException catch (error) {
      inspect(error);
      emit(
        state.copyWith(
          status: () => AomCategoryDetailStatus.failure,
        ),
      );
    }
  }

  Future<void> _onUpdateActivoEvent(
    UpdateActivoEvent event,
    Emitter<AomReportStep1State> emit,
  ) async {
    final int index =
        state.activos.indexWhere((activo) => activo.id == event.activo.id);

    final activos = [...state.activos];
    if (index < 0) {
      activos.add(event.activo);
      emit(state.copyWith(activos: () => activos));
    } else {
      activos[index] = event.activo;
      emit(state.copyWith(activos: () => activos));
    }
  }

  Future<List<GestionAom>> _getGestionObra(
      int projectCode, int categoryId) async {
    try {
      final list = await _aomProjectsRepository.getGestionAom(projectCode);

      return list
          .where((activo) => activo.descripcionId == categoryId)
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<EstadoDeActivo>> _getEstados() async {
    try {
      List<EstadoDeActivo> estados = _aomProjectsApi.getEstadosDeActivos();

      if (estados.isNotEmpty) return estados;

      estados = await _aomProjectsRepository.getEstados();
      _aomProjectsApi.saveEstadosDeActivos(estados);
      return estados;
    } catch (_) {
      rethrow;
    }
  }
}
