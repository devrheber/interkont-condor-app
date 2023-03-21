import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_projects_event.dart';
part 'aom_projects_state.dart';

class AomProjectsBloc extends Bloc<AomProjectsEvent, AomProjectsState> {
  AomProjectsBloc({
    required ProjectsRepository projectsRepository,
  })  : _projectsRepository = projectsRepository,
        super(const AomProjectsState()) {
    on<AomProjectsGetProjects>(_onGetProjects);
  }

  final ProjectsRepository _projectsRepository;

  Future<void> _onGetProjects(
    AomProjectsEvent event,
    Emitter<AomProjectsState> emit,
  ) async {
    emit(state.copyWith(status: () => AomProjectsStatus.loading));

    try {
      // TODO Allow cancel
      final projects = await _projectsRepository.getAomProjects();
      emit(
        state.copyWith(
            status: () => AomProjectsStatus.success, projects: () => projects),
      );
    } catch (e) {
      emit(state.copyWith(
        status: () => AomProjectsStatus.failure,
        projects: () => [],
      ));
    }
  }

  @override
  Future<void> close() {
    // TODO: implement close
    // TODO: Cancel request 
    return super.close();
  }
}
