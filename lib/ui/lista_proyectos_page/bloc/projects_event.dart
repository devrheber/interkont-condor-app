part of 'projects_bloc.dart';

abstract class ProjectsEvent extends Equatable {
  const ProjectsEvent();

  @override
  List<Object> get props => [];
}

class ProjectsStream extends ProjectsEvent {}

class ProjectsDetailsStream extends ProjectsEvent {}

class ProjectsCacheStream extends ProjectsEvent {}

class FetchRemoteProjects extends ProjectsEvent {}

class FetchDocumentsTypes extends ProjectsEvent {}

class SetCurrentProjectCode extends ProjectsEvent {
  final int codigoProyecto;

  const SetCurrentProjectCode(this.codigoProyecto);
}
