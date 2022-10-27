part of 'aom_projects_bloc.dart';

abstract class AomProjectsEvent extends Equatable {
  const AomProjectsEvent();

  @override
  List<Object> get props => [];
}

class AomProjectsGetProjects extends AomProjectsEvent {}
