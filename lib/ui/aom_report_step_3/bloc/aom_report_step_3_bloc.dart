import 'dart:io';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_report_step_3_event.dart';
part 'aom_report_step_3_state.dart';

class AomReportStep3Bloc
    extends Bloc<AomReportStep3Event, AomReportStep3State> {
  AomReportStep3Bloc() : super(const AomReportStep3State()) {
    on<PickFileEvent>(_onPickFileEvent);
    on<RemoveFileEvent>(_onRemoveFileEvent);
  }

  Future<void> _onPickFileEvent(
    PickFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<String, File?> files = {...state.files};
    files[event.fileKey] = event.file;

    emit(state.copyWith(files: () => files));
  }

  Future<void> _onRemoveFileEvent(
    RemoveFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<String, File?> files = {...state.files};
    files.remove(event.key);

    emit(state.copyWith(files: () => files));
  }
}
