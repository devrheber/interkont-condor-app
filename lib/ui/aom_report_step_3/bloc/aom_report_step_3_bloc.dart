import 'dart:io';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:appalimentacion/domain/repository/http_adapter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_report_step_3_event.dart';
part 'aom_report_step_3_state.dart';

class AomReportStep3Bloc
    extends Bloc<AomReportStep3Event, AomReportStep3State> {
  AomReportStep3Bloc({required AomProjectsRepository aomProjectsRepository})
      : _aomProjectsRepository = aomProjectsRepository,
        super(AomReportStep3State()) {
    on<PickFileEvent>(_onPickFileEvent);
    on<UploadFileEvent>(_onUploadFileEvent);
    on<RemoveFileEvent>(_onRemoveFileEvent);
  }

  final AomProjectsRepository _aomProjectsRepository;

  Future<void> _onPickFileEvent(
    PickFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<int, File?> files = {...state.files};
    files[event.fileId] = event.file;

    emit(state.copyWith(files: () => files));
  }

  Future<void> _onUploadFileEvent(
    UploadFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    emit(state.copyWith(status: () => AomReportStep3Status.loading));

    UploadFileRequest uploadFileRequest = UploadFileRequest(
      clasificaciondoc: 5,
      file: state.files[event.fileId]!,
      iddocumento: event.projectCode,
      idtipodocumento: 5,
      nombredocumento: event.fileName,
      usuarioid: 4,
    );

    try {
      final fileInfo = await _aomProjectsRepository.uploadFile(
          uploadFileRequest: uploadFileRequest);

      Map<int, UploadFileResponse> filesUploaded = {...state.filesUploaded};
      filesUploaded[event.fileId] = fileInfo;

      emit(state.copyWith(
          status: () => AomReportStep3Status.success,
          filesUploaded: () => filesUploaded));
    } on ProjectsError catch (e) {
      emit(state.copyWith(
          status: () => AomReportStep3Status.failure,
          errorMessage: e.response?.data['message']));
    }
  }

  Future<void> _onRemoveFileEvent(
    RemoveFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<int, File?> files = {...state.files};
    files.remove(event.fileId);

    emit(state.copyWith(files: () => files));
  }
}
