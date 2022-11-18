import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_report_step_2_event.dart';
part 'aom_report_step_2_state.dart';

class AomReportStep2Bloc
    extends Bloc<AomReportStep2Event, AomReportStep2State> {
  AomReportStep2Bloc() : super(AomReportStep2State()) {
    on<UpdateAnwserEvent>(_onUpdateAnwserEvent);
    on<UpdateQuestion1ReasonEvent>(_onUpdateQuestion1ReasonEvent);
    on<UpdateQuestion1MonthsEvent>(_onUpdateQuestion1MonthsEvent);
  }

  Future<void> _onUpdateAnwserEvent(
    UpdateAnwserEvent event,
    Emitter<AomReportStep2State> emit,
  ) async {
    final answers = [...state.answers];
    answers[event.index] = event.answer;

    emit(state.copyWith(answers: answers));
  }

  Future<void> _onUpdateQuestion1ReasonEvent(
    UpdateQuestion1ReasonEvent event,
    Emitter<AomReportStep2State> emit,
  ) async {
    emit(state.copyWith(vidaUtilRemanenteNoConsideradaText: event.reason));
  }

  Future<void> _onUpdateQuestion1MonthsEvent(
    UpdateQuestion1MonthsEvent event,
    Emitter<AomReportStep2State> emit,
  ) async {
    final int? value = int.tryParse(event.months);
    if (value == null) return;

    emit(state.copyWith(vidaUtilRemanenteConsideradaOff: value));
  }
}
