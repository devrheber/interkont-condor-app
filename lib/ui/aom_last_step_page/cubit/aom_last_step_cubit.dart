import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_last_step_state.dart';

class AomLastStepCubit extends Cubit<AomLastStepState> {
  AomLastStepCubit({required AomProjectsRepository aomProjectsRepository})
      : _aomProjectsRepository = aomProjectsRepository,
        super(AomLastStepInitial());

  final AomProjectsRepository _aomProjectsRepository;

  Future<void> sendData(
      AomActualizacionRequest dataReporte, Map<String, File?> files) async {
    emit(AomLastStepLoading(0));

    try {
      final newFiles = _getFilesFromState(dataReporte.obraId, files);
      final filesUploaded = await _uploadFiles(newFiles);

      final data =
          dataReporte.copyWith(imagenesVideosOr: filesUploaded.values.toList());

      final result = await _aomProjectsRepository.sendData(data: data);

      if (result['message'] != null) {
        emit(AomLastStepSuccess(result['message']));
      }
    } on AomProjectsRepositoryException catch (e) {
      try {
        if (e is AomProjectsBackendErrorException) {
          emit(AomLastStepFailure(e.response?.data['message']));
        }
      } catch (_) {
        emit(AomLastStepFailure('Algo salió mal'));
      }
    }
  }

  Future<Map<String, ImagenesVideosOrRequest>> _uploadFiles(
      List<UploadFileRequest> files) async {
    Map<String, ImagenesVideosOrRequest> filesUploaded = {};

    for (final file in files) {
      final fileInfo =
          await _aomProjectsRepository.uploadFile(uploadFileRequest: file);

      final typeAllowed = ['image', 'video'];

      final uploadFileRequest = ImagenesVideosOrRequest(
          id: fileInfo.id,
          name: file.getFileName,
          fileExt: file.getFileExtension,
          iddocumento: file.iddocumento,
          tipoMovimiento: typeAllowed.contains(file.nombredocumento) ? 1 : 2);

      filesUploaded[file.nombredocumento] = uploadFileRequest;
    }
    return filesUploaded;
  }

  List<UploadFileRequest> _getFilesFromState(
      int projectCode, Map<String, File?> files) {
    List<UploadFileRequest> newFiles = [];

    for (final file in files.entries) {
      newFiles.add(UploadFileRequest(
        clasificaciondoc: 5,
        file: file.value!,
        iddocumento: projectCode,
        idtipodocumento: 6,
        nombredocumento: file.key,
        usuarioid: 4,
        type: file.key,
      ));
    }

    return newFiles;
  }
}
