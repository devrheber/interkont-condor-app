part of 'aom_detail_categories_cubit.dart';

enum AomDetailCategoriesStatus { initial, loading, success, failure }

class AomDetailCategoriesState extends Equatable {
  const AomDetailCategoriesState({
    this.gestionAom = const [],
    this.status = AomDetailCategoriesStatus.initial,
    this.estados = const [],
    this.estadosSeleccionados = const {},
  });

  final List<GestionAom> gestionAom;
  final AomDetailCategoriesStatus status;
  final List<EstadoDeActivo> estados;
  final Map<int, EstadoDeActivo> estadosSeleccionados;

  AomDetailCategoriesState copyWith({
    List<GestionAom> Function()? gestionAom,
    AomDetailCategoriesStatus Function()? status,
    List<EstadoDeActivo> Function()? estados,
    Map<int, EstadoDeActivo> Function()? estadosSeleccionados,
  }) {
    return AomDetailCategoriesState(
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

class AomDetailCategoriesInitial extends AomDetailCategoriesState {}
