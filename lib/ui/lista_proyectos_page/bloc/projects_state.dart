part of 'projects_bloc.dart';

enum ProjectsStatus { initial, loading, success, failure }

class ProjectsState extends Equatable {
  const ProjectsState({
    this.status = ProjectsStatus.initial,
    this.details = const {},
    this.projects = const [],
    this.cache = const {},
    this.message = '',
  });

  final ProjectsStatus status;
  final Map<String, DatosAlimentacion> details;
  final Map<String, ProjectCache> cache;
  final List<Project> projects;
  final String message;

  factory ProjectsState.initial() => const ProjectsState();

  ProjectsState copyWith({
    ProjectsStatus? status,
    Map<String, DatosAlimentacion>? details,
    List<Project>? projects,
    Map<String, ProjectCache>? cache,
    String? message,
  }) {
    return ProjectsState(
      status: status ?? this.status,
      details: details ?? this.details,
      projects: projects ?? this.projects,
      cache: cache ?? this.cache,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [
        status,
        details,
        projects,
        cache,
        message,
      ];
}

extension ProjectsStateX on ProjectsState {
  bool get isInitial => status == ProjectsStatus.initial;
  bool get isLoading => status == ProjectsStatus.loading;
  bool get isSuccess => status == ProjectsStatus.success;
  bool get isFailure => status == ProjectsStatus.failure;
}
