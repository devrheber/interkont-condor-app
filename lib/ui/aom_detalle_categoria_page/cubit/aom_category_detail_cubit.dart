import 'dart:developer';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_category_detail_state.dart';

class AomReportCubit extends Cubit<AomReportState> {
  AomReportCubit({
    required int projectCode,
    required int clasificationId,
    required int vidaUtilActualEnMeses,
  }) : super(AomReportState(
          projectCode: projectCode,
          clasificationId: clasificationId,
          vidaUtilActualEnMeses: vidaUtilActualEnMeses,
        ));

  void setStep(int step) => emit(state.copyWith(step: step));

  void updateData({
    List<ActivoUpdateRequest>? activos,
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    int? vidaUtilRemanenteConsideradaOff,
    int? vidaUtilEnMeses,
    Map<String, ImagenesVideosOrRequest>? filesUploaded,
  }) {
    emit(state.copyWith(
      activos: activos,
      answers: answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff,
      vidaUtilNuevaEnMeses: vidaUtilEnMeses,
      filesUploaded: filesUploaded,
    ));
  }
}
