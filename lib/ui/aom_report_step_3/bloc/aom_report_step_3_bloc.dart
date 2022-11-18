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
    on<SendDataEvent>(_onSendData);
    on<RemoveFileEvent>(_onRemoveFileEvent);
    on<ValidateData>(_onValidateData);
  }

  final AomProjectsRepository _aomProjectsRepository;

  Future<void> _onPickFileEvent(
    PickFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<String, File?> files = {...state.files};
    files[event.fileKey] = event.file;

    emit(state.copyWith(files: () => files));
  }

  Future<void> _onSendData(
    SendDataEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    emit(state.copyWith(status: () => AomReportStep3Status.loading));

    try {
      final filesUploaded = await _uploadFiles(event.projectCode);

      // TODO Send Data

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
    Map<String, File?> files = {...state.files};
    files.remove(event.fileId);

    emit(state.copyWith(files: () => files));
  }

  Future<void> _onValidateData(
    ValidateData event,
    Emitter<AomReportStep3State> emit,
  ) async {
    const int __requiredFileKey__ = 1;
    emit(state.copyWith(validateStatus: () => ValidationStatus.validating));
    await Future.delayed(const Duration(milliseconds: 200));
    if (state.files.containsKey(__requiredFileKey__)) {
      emit(state.copyWith(validateStatus: () => ValidationStatus.success));
      return;
    }

    emit(state.copyWith(validateStatus: () => ValidationStatus.failure));
  }

  Future<Map<String, UploadFileResponse>> _uploadFiles(int projectCode) async {
    final files = _getFilesFromState(projectCode);
    Map<String, UploadFileResponse> filesUploaded = {};

    for (final file in files) {
      final fileInfo =
          await _aomProjectsRepository.uploadFile(uploadFileRequest: file);

      filesUploaded[file.nombredocumento] = fileInfo;
    }
    return filesUploaded;
  }

  List<UploadFileRequest> _getFilesFromState(int projectCode) {
    List<UploadFileRequest> files = [];
    
    for (final file in state.files.entries) {
      files.add(UploadFileRequest(
        clasificaciondoc: 5,
        file: file.value!,
        iddocumento: projectCode,
        idtipodocumento: 5,
        nombredocumento: file.key,
        usuarioid: 4,
      ));
    }

    return files;
  }
}
