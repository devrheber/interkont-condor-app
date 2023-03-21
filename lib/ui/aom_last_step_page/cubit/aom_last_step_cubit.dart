import 'dart:io';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rxdart/rxdart.dart';

part 'aom_last_step_state.dart';

class AomLastStepCubit extends Cubit<AomLastStepState> {
  AomLastStepCubit({required AomProjectsRepository aomProjectsRepository})
      : _aomProjectsRepository = aomProjectsRepository,
        super(const AomLastStepInitial());

  final AomProjectsRepository _aomProjectsRepository;
  final uploadPercentage = PublishSubject<Map<String, dynamic>>();

  Future<void> sendData(
      AomActualizacionRequest dataReporte, Map<String, File?> files) async {
    emit(const AomLastStepLoading());

    final newFiles = _getFilesFromState(dataReporte.obraId, files);
    final filesUploaded = await _uploadFiles(newFiles);

    if (filesUploaded.isEmpty) return;

    try {
      final data = dataReporte.copyWith(
        imagenesVideosOr: filesUploaded.values.toList(),
      );

      await _aomProjectsRepository.sendData(
        data: data,
        onSendProgress: (count, total) =>
            _onSendProgress(count, total, description: 'Enviando reporte'),
        onReceiveProgress: _onReceiveProgress,
      );

      emit(const AomLastStepSuccess('Operación exitosa'));
    } on AomProjectsRepositoryException catch (e) {
      try {
        if (e is AomProjectsBackendErrorException) {
          emit(AomLastStepFailure(e.response?.data['message']));
        }

        if (e is AomProjectsOtherEception) {
          emit(
            AomLastStepFailure(e.response?['message']),
          );
        }

        if (e is AomProjectsCancelException) {
          emit(const AomLastStepFailure('Operación cancelada'));
        }
      } catch (_) {
        emit(const AomLastStepFailure('Algo salió mal'));
      }
    }
  }

  Future<Map<String, ImagenesVideosOrRequest>> _uploadFiles(
      List<UploadFileRequest> files) async {
    Map<String, ImagenesVideosOrRequest> filesUploaded = {};

    try {
      for (int i = 0; i < files.length; i++) {
        final fileInfo = await _aomProjectsRepository.uploadFile(
          uploadFileRequest: files[i],
          onReceiveProgress: _onReceiveProgress,
          onSendProgress: (int count, int total) {
            _onSendProgress(count, total,
                description:
                    'Cargando archivos: ${(i + 1)} de ${files.length} ');
          },
        );

        final typeAllowed = ['image', 'video'];

        final uploadFileRequest = ImagenesVideosOrRequest(
            id: fileInfo.id,
            name: files[i].getFileName,
            fileExt: files[i].getFileExtension,
            iddocumento: files[i].iddocumento,
            tipoMovimiento:
                typeAllowed.contains(files[i].nombredocumento) ? 1 : 2);

        filesUploaded[files[i].nombredocumento] = uploadFileRequest;
      }
    } catch (_) {
      emit(const AomLastStepFailure('Ocurrió un error enviando los archivos'));
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

  void _onSendProgress(int count, int total, {required String description}) {
    uploadPercentage.add({
      'description': description,
      'percentaje': count / total,
    });
    print(count / total);
  }

  void _onReceiveProgress(int count, int total) {
    // TODO
  }
}
