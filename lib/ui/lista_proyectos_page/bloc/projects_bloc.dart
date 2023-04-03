import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/cache_repository.dart';
import 'package:appalimentacion/domain/repository/files_persistent_cache_repository.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'projects_event.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({
    required ProjectsRepository projectRepository,
    required ProjectsCacheRepository projectsCacheRepository,
    required FilesPersistentCacheRepository filesPersistentCacheRepository,
  })  : _projectRepository = projectRepository,
        _projectsCacheRepository = projectsCacheRepository,
        _filesPersistentCacheRepository = filesPersistentCacheRepository,
        super(ProjectsState.initial()) {
    on<ProjectsStream>(_onProjectsStream);
    on<ProjectsDetailsStream>(_onProjectsDetailsStream);
    on<ProjectsCacheStream>(_onProjectsCacheStream);
    on<FetchRemoteProjects>(_onFetchRemoteProjects);
    on<FetchDocumentsTypes>(_onFetchDocumentsTypes);
    on<SetCurrentProjectCode>(_onSetCurrentProjectCode);
  }

  final ProjectsRepository _projectRepository;
  final ProjectsCacheRepository _projectsCacheRepository;
  final FilesPersistentCacheRepository _filesPersistentCacheRepository;

  Future<void> _onProjectsStream(
      ProjectsStream event, Emitter<ProjectsState> emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    await emit.forEach<List<Project>>(
      _projectsCacheRepository.getProjects(),
      onData: (projects) => state.copyWith(
        status: ProjectsStatus.success,
        projects: projects,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectsStatus.failure,
      ),
    );
  }

  Future<void> _onProjectsCacheStream(event, emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    await emit.forEach<Map<String, ProjectCache>>(
      _projectsCacheRepository.getProjectsCache(),
      onData: (projectsCache) => state.copyWith(
        status: ProjectsStatus.success,
        cache: projectsCache,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectsStatus.failure,
      ),
    );
  }

  Future<void> _onProjectsDetailsStream(event, emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    await emit.forEach<Map<String, DatosAlimentacion>>(
      _projectsCacheRepository.getDetails(),
      onData: (details) => state.copyWith(
        status: ProjectsStatus.success,
        details: details,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectsStatus.failure,
      ),
    );
  }

  Future<void> _onFetchRemoteProjects(event, emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    try {
      final projects = await _projectRepository.getAlimentacionProjects();

      await _projectsCacheRepository.saveProjects(projects);
      emit(state.copyWith(status: ProjectsStatus.success));
    } on OtherException catch (e) {
      emit(state.copyWith(
        status: ProjectsStatus.failure,
        message: e.message,
      ));
      emit(state.copyWith(message: ''));
    }
  }

  Future<void> _onFetchDocumentsTypes(event, emit) async {
    emit(state.copyWith(status: ProjectsStatus.loading));

    try {
      final types = await _projectRepository.getTipoDoc();

      if (types.isEmpty) return;

      _projectsCacheRepository.saveDocumentTypes(types);

      emit(state.copyWith(status: ProjectsStatus.success));
    } catch (e) {
      emit(state.copyWith(status: ProjectsStatus.failure));
    }
  }

  void _onSetCurrentProjectCode(SetCurrentProjectCode event, emit) {
    _projectsCacheRepository.setCurrentProjectCode(event.codigoProyecto);
    _filesPersistentCacheRepository.setCurrentProjectCode(event.codigoProyecto);
  }

  Future<void> _saveSyncDate(int projectCode) async {
    final syncDate = DateTime.now();
    ProjectCache? cache = state.cache['$projectCode'];

    cache = cache?.copyWith(lastSyncDate: syncDate) ??
        ProjectCache(projectCode: projectCode, lastSyncDate: syncDate);

    _projectsCacheRepository.saveProjectCache(projectCode, cache);
  }
}
