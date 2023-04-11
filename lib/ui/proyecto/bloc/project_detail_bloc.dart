import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'project_detail_event.dart';
part 'project_detail_state.dart';

class ProjectDetailBloc extends Bloc<ProjectDetailEvent, ProjectDetailState> {
  ProjectDetailBloc({
    required ProjectsRepository projectRepository,
    required ProjectsCacheRepository projectsCacheRepository,
    required Project project,
    required DatosAlimentacion? detail,
    required ProjectCache? cache,
  })  : _projectRepository = projectRepository,
        _projectsCacheRepository = projectsCacheRepository,
        super(ProjectDetailState(
          project: project,
          detail: detail,
          cache: cache ?? ProjectCache(projectCode: project.codigoproyecto),
          // TODO
          // cache = cache.copyWith(projectCode: project.codigoproyecto);
        )) {
    on<EstablecerPeriodoSeleccionado>(_onEstablecerPeriodoSeleccionado);
    on<SyncDetail>(_onSyncDetail);
    on<ChangePeriod>(_onChangePeriod);
    on<CancelRequest>(_onCancelRequest);
    on<UpdateStepToPendingPublish>(_onUpdateStepToPendingPublish);
    on<ClearPeriodoSeleccionado>(_onClearPeriodoSeleccionado);
  }

  final ProjectsRepository _projectRepository;
  final ProjectsCacheRepository _projectsCacheRepository;

  void _onEstablecerPeriodoSeleccionado(event, emit) {
    if (state.detail == null) return;

    final int index = state.detail!.periodos.indexWhere(
        (periodo) => periodo.periodoId == state.cache.periodoIdSeleccionado);

    if (index < 0) return;

    emit(state.copyWith(
      periodoSeleccionado: () => state.detail!.periodos[index],
    ));
  }

  Future<void> _onSyncDetail(
    SyncDetail event,
    Emitter<ProjectDetailState> emit,
  ) async {
    final projectCode = state.project.codigoproyecto;
    emit(state.copyWith(
        status: ProjectDetailStatus.loading,
        message: 'Sincronizando proyecto...'));
    try {
      ///
      // TODO We should fetch one project
      final projects = await _projectRepository.getAlimentacionProjects();
      final index = projects.indexWhere(
          (project) => project.codigoproyecto == state.project.codigoproyecto);

      ///

      final detail = await _projectRepository.getDatosAlimentacion(
        codigoProyecto: '$projectCode',
      );

      final dateSync = DateTime.now();

      final cache = state.cache.copyWith(lastSyncDate: dateSync);

      await _projectsCacheRepository.saveProjectCache(projectCode, cache);
      await _projectsCacheRepository.saveDetail(detail);
      await _projectsCacheRepository.saveProjects(projects);

      emit(state.copyWith(
          status: ProjectDetailStatus.success,
          detail: detail,
          cache: cache,
          project: index >= 0 ? projects[index] : state.project,
          message: 'Proyecto sincronizado correctamente!'));

      _updateSelectedPeriod(event, emit);
    } on OtherException catch (e) {
      emit(state.copyWith(
          status: ProjectDetailStatus.failure, message: e.message));
    } catch (_) {
      emit(state.copyWith(
          status: ProjectDetailStatus.failure,
          message: 'Lo sentimos, No se pudo sincronizar el proyecto'));
    }
  }

  void _updateSelectedPeriod(event, emit) {
    if (state.detail == null) return;
    final int index = state.detail!.periodos.indexWhere(
        (period) => period.periodoId == state.periodoSeleccionado?.periodoId);

    if (index < 0) {
      emit(state.copyWith(periodoSeleccionado: () => null));
      return;
    }

    emit(state.copyWith(
        periodoSeleccionado: () => state.detail!.periodos[index]));
  }

  Future<void> _onChangePeriod(ChangePeriod event, emit) async {
    if (state.detail == null) return;

    final int index = state.detail!.periodos
        .indexWhere((period) => period.periodoId == event.periodo.periodoId);

    if (index < 0) {
      emit(state.copyWith(periodoSeleccionado: () => null));
      return;
    }

    final cache = state.cache.copyWith(
      periodoIdSeleccionado: event.periodo.periodoId,
      porcentajeValorProyectadoSeleccionado: event.periodo.porcentajeProyectado,
    );

    _projectsCacheRepository.saveProjectCache(state.projectCode, cache);

    await Future.delayed(const Duration(milliseconds: 200));
    emit(state.copyWith(
      cache: cache,
      periodoSeleccionado: () => state.detail!.periodos[index],
    ));
  }

  void _onCancelRequest(CancelRequest event, emit) {
    _projectRepository.cancel();
  }

  void _onUpdateStepToPendingPublish(event, emit) {
    if (state.cache.stepNumber != 4) return;
    final cache = state.cache.copyWith(stepNumber: 4);
    _projectsCacheRepository.saveCache(cache);
  }

  void _onClearPeriodoSeleccionado(event, emit) {
    emit(state.copyWith(periodoSeleccionado: () => null));
  }
}
