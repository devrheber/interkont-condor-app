import 'dart:developer';

import 'package:appalimentacion/domain/models/aom_datos_generales.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_api.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clasification_state.dart';

class AomDetailCubit extends Cubit<AomDetailState> {
  AomDetailCubit({
    required AomProjectsRepository aomProjectsRepository,
    required AomProjectsApi aomProjectsApi,
  })  : _aomProjectsRepository = aomProjectsRepository,
        _aomProjectsApi = aomProjectsApi,
        super(const AomDetailState());

  final AomProjectsRepository _aomProjectsRepository;
  final AomProjectsApi _aomProjectsApi;

  Future<void> _getGeneralData(int projectCode) async {
    final generalData =
        await _aomProjectsRepository.getDatosGenerales(projectCode);
    emit(state.copyWith(
      generalData: () => generalData,
      status: () => AomDetailStatus.success,
    ));
  }

  Future<void> _getCategoriasByObraId(int obraId) async {
    final list = await _aomProjectsRepository.categoriasByObraId(obraId);
    list.sort(
      (a, b) => a.clasificacionActivos.descripcion
          .compareTo(b.clasificacionActivos.descripcion),
    );

    emit(state.copyWith(clasifications: () => list));
  }

  Future<void> _getContratistas() async {
    final contratista =
        _aomProjectsApi.getContratistaById(state.generalData!.operadorId);

    if (contratista != null) {
      emit(state.copyWith(contratista: () => contratista));
      return;
    }

    final list = await _aomProjectsRepository.getContratistas();

    _aomProjectsApi.saveContratistas(list);
    _aomProjectsApi.getContratistaById(state.generalData!.operadorId);

    emit(
      state.copyWith(
          contratista: () => _aomProjectsApi
              .getContratistaById(state.generalData!.operadorId)),
    );
  }

  Future<void> loadData(int projectCode) async {
    emit(state.copyWith(status: () => AomDetailStatus.loading));
    try {
      await _getGeneralData(projectCode);
      await _getContratistas();
      await _getCategoriasByObraId(projectCode);
      emit(state.copyWith(status: () => AomDetailStatus.success));
    } on AomProjectsRepositoryException catch (error) {
      try {
        emit(
          state.copyWith(
            status: () => AomDetailStatus.failure,
            errorResponse: () => (error is AomProjectsBackendErrorException)
                ? error.response
                : null,
          ),
        );
      } catch (e) {
        emit(
          state.copyWith(
              status: () => AomDetailStatus.failure,
              errorResponse: () => {'message': 'Algo salió mal'}),
        );
      }
    }
  }
}
