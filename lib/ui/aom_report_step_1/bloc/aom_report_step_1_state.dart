part of 'aom_report_step_1_bloc.dart';

enum AomCategoryDetailStatus { initial, loading, success, failure }

class AomReportStep1State extends Equatable {
  const AomReportStep1State({
    this.gestionAom = const [],
    this.status = AomCategoryDetailStatus.initial,
    this.estados = const [],
    this.activos = const [],
  });

  final List<GestionAom> gestionAom;
  final AomCategoryDetailStatus status;
  final List<EstadoDeActivo> estados;
  final List<ActivoUpdateRequest> activos;

  AomReportStep1State copyWith({
    List<GestionAom> Function()? gestionAom,
    AomCategoryDetailStatus Function()? status,
    List<EstadoDeActivo> Function()? estados,
    final List<ActivoUpdateRequest> Function()? activos,
  }) {
    return AomReportStep1State(
      gestionAom: gestionAom != null ? gestionAom() : this.gestionAom,
      status: status != null ? status() : this.status,
      estados: estados != null ? estados() : this.estados,
      activos: activos != null ? activos() : this.activos,
    );
  }

  @override
  List<Object> get props => [gestionAom, status, estados, activos];
}
