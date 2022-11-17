part of 'aom_report_step_1_bloc.dart';

abstract class AomReportStep1Event extends Equatable {
  const AomReportStep1Event();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends AomReportStep1Event {
  const LoadDataEvent(this.projectCode, this.categoryId);

  final int projectCode;
  final int categoryId;
}

class UpdateEstadoDeActivoEvent extends AomReportStep1Event {
  const UpdateEstadoDeActivoEvent(
    this.activoId,
    this.estado,
  );
  final int activoId;
  final EstadoDeActivo? estado;
}
