part of 'aom_projects_bloc.dart';

enum AomProjectsStatus { initial, loading, success, failure }

class AomProjectsState extends Equatable {
  const AomProjectsState(
      {this.status = AomProjectsStatus.initial, this.projects = const []});

  final AomProjectsStatus status;
  final List<Project> projects;

  AomProjectsState copyWith({
    AomProjectsStatus Function()? status,
    List<Project> Function()? projects,
  }) {
    return AomProjectsState(
      status: status != null ? status() : this.status,
      projects: projects != null ? projects() : this.projects,
    );
  }

  @override
  List<Object> get props => [
        status,
        projects,
      ];
}
