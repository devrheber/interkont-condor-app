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
      final filesUploaded = await _uploadFiles(event.data.obraId);
      final data =
          event.data.copyWith(imagenesVideosOr: filesUploaded.values.toList());

      final result = await _aomProjectsRepository.sendData(data: data);

      if (result['message'] != null) {
        emit(state.copyWith(
            status: () => AomReportStep3Status.success,
            responseMessage: () => result['message']));
      }
    } on ProjectsError catch (e) {
      try {
        emit(state.copyWith(
            status: () => AomReportStep3Status.failure,
            responseMessage: () => e.response?.data['message']));
      } catch (_) {
        emit(state.copyWith(
            status: () => AomReportStep3Status.failure,
            responseMessage: () => 'Algo salió mal'));
      }
    }
  }

  Future<void> _onRemoveFileEvent(
    RemoveFileEvent event,
    Emitter<AomReportStep3State> emit,
  ) async {
    Map<String, File?> files = {...state.files};
    files.remove(event.key);

    emit(state.copyWith(files: () => files));
  }

  Future<Map<String, ImagenesVideosOrRequest>> _uploadFiles(
      int projectCode) async {
    final files = _getFilesFromState(projectCode);

    Map<String, ImagenesVideosOrRequest> filesUploaded = {};

    for (final file in files) {
      final fileInfo =
          await _aomProjectsRepository.uploadFile(uploadFileRequest: file);

      final typeAllowed = ['image', 'video'];

      final uploadFileRequest = ImagenesVideosOrRequest(
          id: fileInfo.id,
          name: file.getFileName,
          fileExt: file.getFileExtension,
          iddocumento: projectCode,
          tipoMovimiento: typeAllowed.contains(file.nombredocumento) ? 1 : 2);

      filesUploaded[file.nombredocumento] = uploadFileRequest;
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
