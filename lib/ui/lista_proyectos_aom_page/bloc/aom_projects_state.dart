part of 'aom_projects_bloc.dart';

enum AomProjectsStatus { initial, loading, success, failure }

class AomProjectsState extends Equatable {
  const AomProjectsState(
      {this.status = AomProjectsStatus.initial, this.projects = const []});

  final AomProjectsStatus status;
  final List<Project> projects;

  AomProjectsState copyWith({
    AomProjectsStatus? status,
    List<Project>? projects,
  }) {
    return AomProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
    );
  }

  @override
  List<Object> get props => [
        status,
        projects,
      ];
}
