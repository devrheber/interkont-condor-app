part of 'aom_category_detail_cubit.dart';

class AomReportState extends Equatable {
  const AomReportState({
    this.step = 1,
    this.activos,
    // this.data,
    this.answers,
    this.vidaUtilRemanenteNoConsideradaText,
    this.vidaUtilRemanenteConsideradaOff,
    this.vidaUtilActualEnMeses,
    this.vidaUtilNuevaEnMeses,
  });

  final int step;
  final List<ActivoUpdateRequest>? activos;
  // final AomActualizacionRequest? data;
  final List<bool>? answers;
  final String? vidaUtilRemanenteNoConsideradaText;
  final int? vidaUtilRemanenteConsideradaOff;
  final int? vidaUtilActualEnMeses;
  final int? vidaUtilNuevaEnMeses;

  AomReportState copyWith({
    int? step,
    List<ActivoUpdateRequest>? activos,
    // AomActualizacionRequest? data,
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    int? vidaUtilRemanenteConsideradaOff,
    final int? vidaUtilNuevaEnMeses,
  }) {
    return AomReportState(
      step: step ?? this.step,
      activos: activos ?? this.activos,
      // data: data ?? this.data,
      answers: answers ?? this.answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText ??
          this.vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff ??
          this.vidaUtilRemanenteConsideradaOff,
      vidaUtilNuevaEnMeses: vidaUtilNuevaEnMeses ?? this.vidaUtilNuevaEnMeses,
    );
  }

  @override
  List<Object?> get props => [
        step, activos,
        // data
        answers, vidaUtilRemanenteNoConsideradaText,
        vidaUtilRemanenteConsideradaOff,
        vidaUtilActualEnMeses,
      ];
}
