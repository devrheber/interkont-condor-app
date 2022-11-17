part of 'aom_report_step_1_bloc.dart';

enum AomCategoryDetailStatus { initial, loading, success, failure }

class AomReportStep1State extends Equatable {
  const AomReportStep1State({
    this.gestionAom = const [],
    this.status = AomCategoryDetailStatus.initial,
    this.estados = const [],
    this.estadosSeleccionados = const {},
  });

  final List<GestionAom> gestionAom;
  final AomCategoryDetailStatus status;
  final List<EstadoDeActivo> estados;
  final Map<int, EstadoDeActivo> estadosSeleccionados;

  AomReportStep1State copyWith({
    List<GestionAom> Function()? gestionAom,
    AomCategoryDetailStatus Function()? status,
    List<EstadoDeActivo> Function()? estados,
    Map<int, EstadoDeActivo> Function()? estadosSeleccionados,
  }) {
    return AomReportStep1State(
      gestionAom: gestionAom != null ? gestionAom() : this.gestionAom,
      status: status != null ? status() : this.status,
      estados: estados != null ? estados() : this.estados,
      estadosSeleccionados: estadosSeleccionados != null
          ? estadosSeleccionados()
          : this.estadosSeleccionados,
    );
  }

  EstadoDeActivo? getEstadoSeleccionado(int activoId, int estadoId) {
    if (estadosSeleccionados.containsKey(activoId)) {
      return estadosSeleccionados[activoId];
    }

    final index = estados.indexWhere((estado) => estado.id == estadoId);

    if (index < 0) return null;

    return estados[index];
  }

  @override
  List<Object> get props => [gestionAom, status, estados, estadosSeleccionados];
}
