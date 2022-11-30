part of 'aomdetail_cubit.dart';

enum AomDetailStatus { initial, loading, success, failure }

class AomDetailState extends Equatable {
  const AomDetailState({
    this.status = AomDetailStatus.initial,
    this.generalData,
    this.contratista = Contratista.empty,
    this.clasifications = const [],
    this.errorResponse,
  });

  final AomDetailStatus status;
  final AomDatosGenerales? generalData;
  final Contratista contratista;
  final List<CategoriaObra> clasifications;
  final Map<String, dynamic>? errorResponse;

  AomDetailState copyWith({
    AomDetailStatus Function()? status,
    AomDatosGenerales Function()? generalData,
    Contratista? Function()? contratista,
    List<CategoriaObra> Function()? clasifications,
    Map<String, dynamic> Function()? errorResponse,
  }) {
    return AomDetailState(
      status: status != null ? status() : this.status,
      generalData: generalData != null ? generalData() : this.generalData,
      contratista: contratista != null ? contratista()! : this.contratista,
      clasifications:
          clasifications != null ? clasifications() : this.clasifications,
      errorResponse:
          errorResponse != null ? errorResponse() : this.errorResponse,
    );
  }

  @override
  List<Object> get props => [status, clasifications, contratista];

  bool get isValidateClasificacionActivos => clasifications.any((clasification) =>
      clasification.clasificacionActivos == ClasificacionActivos.empty);
}
