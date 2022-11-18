import 'dart:developer';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_category_detail_state.dart';

class AomReportCubit extends Cubit<AomReportState> {
  AomReportCubit() : super(AomReportState());

  void setStep(int step) => emit(state.copyWith(step: step));

  void updateData({
    List<ActivoUpdateRequest>? activos,
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    int? vidaUtilRemanenteConsideradaOff,
    int? vidaUtilEnAnios,
  }) {
    emit(state.copyWith(
      activos: activos,
      answers: answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff,
      vidaUtilNuevaEnMeses: vidaUtilEnAnios,
    ));
    inspect(state);
  }
}
