part of 'project_detail_bloc.dart';

abstract class ProjectDetailEvent extends Equatable {
  const ProjectDetailEvent();

  @override
  List<Object> get props => [];
}

class EstablecerPeriodoSeleccionado extends ProjectDetailEvent {}

class SyncDetail extends ProjectDetailEvent {}

class ChangePeriod extends ProjectDetailEvent {
  const ChangePeriod(this.periodo);

  final Periodo periodo;

  @override
  List<Object> get props => [periodo];
}

class CancelRequest extends ProjectDetailEvent {}

class UpdateStepToPendingPublish extends ProjectDetailEvent {}

class ClearPeriodoSeleccionado extends ProjectDetailEvent {}
