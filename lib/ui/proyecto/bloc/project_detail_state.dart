part of 'project_detail_bloc.dart';

enum ProjectDetailStatus {
  initial,
  loading,
  success,
  failure,
}

class ProjectDetailState extends Equatable {
  const ProjectDetailState({
    this.status = ProjectDetailStatus.initial,
    required this.project,
    required this.detail,
    required this.cache,
    this.periodoSeleccionado,
    this.message = '',
  });

  final ProjectDetailStatus status;
  final Project project;
  final DatosAlimentacion detail;
  final ProjectCache cache;
  final Periodo? periodoSeleccionado;
  final String message;

  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    Project? project,
    DatosAlimentacion? detail,
    ProjectCache? cache,
    Periodo? Function()? periodoSeleccionado,
    String? message,
  }) =>
      ProjectDetailState(
        status: status ?? this.status,
        project: project ?? this.project,
        detail: detail ?? this.detail,
        cache: cache ?? this.cache,
        periodoSeleccionado: periodoSeleccionado != null
            ? periodoSeleccionado()
            : this.periodoSeleccionado,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [
        status,
        project,
        detail,
        cache,
        periodoSeleccionado,
        message,
        
      ];
}

extension ProjectDetailStateX on ProjectDetailState {
  bool get isInitial => status == ProjectDetailStatus.initial;
  bool get isLoading => status == ProjectDetailStatus.loading;
  bool get isSuccess => status == ProjectDetailStatus.success;
  bool get isFailure => status == ProjectDetailStatus.failure;

  int get projectCode => project.codigoproyecto;
}