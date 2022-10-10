class RangeIndicator {
  const RangeIndicator({
    this.descripcionIndicadorAlcance,
    this.unidadMedida,
    this.cantidadProgramada,
    this.cantidadEjecutada,
    this.porcentajeAvance,
    this.cantidadEjecutadaInicial,
  });

  final dynamic descripcionIndicadorAlcance;
  final dynamic unidadMedida;
  final dynamic cantidadProgramada;
  final dynamic cantidadEjecutada;
  final dynamic porcentajeAvance;
  final dynamic cantidadEjecutadaInicial;

  RangeIndicator copyWith({
    dynamic descripcionIndicadorAlcance,
    dynamic unidadMedida,
    dynamic cantidadProgramada,
    dynamic cantidadEjecutada,
    dynamic porcentajeAvance,
    dynamic cantidadEjecutadaInicial,
  }) {
    return RangeIndicator(
      descripcionIndicadorAlcance:
          descripcionIndicadorAlcance ?? this.descripcionIndicadorAlcance,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      cantidadProgramada: cantidadProgramada ?? this.cantidadProgramada,
      cantidadEjecutada: cantidadEjecutada ?? this.cantidadEjecutada,
      porcentajeAvance: porcentajeAvance ?? this.porcentajeAvance,
      cantidadEjecutadaInicial:
          cantidadEjecutadaInicial ?? this.cantidadEjecutadaInicial,
    );
  }
}
