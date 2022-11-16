part of 'aom_report_step_3_bloc.dart';

abstract class AomReportStep3Event extends Equatable {
  const AomReportStep3Event();

  @override
  List<Object> get props => [];
}

class PickFileEvent extends AomReportStep3Event {
  const PickFileEvent({
    required this.fileId,
    required this.fileName,
    required this.file,
  });

  final int fileId;
  final String fileName;
  final File file;
}

class UploadFileEvent extends AomReportStep3Event {
  const UploadFileEvent(
    this.fileId,
    this.fileName,
    this.projectCode,
  );

  final int fileId;
  final String fileName;
  final int projectCode;
}

class RemoveFileEvent extends AomReportStep3Event {
  const RemoveFileEvent(this.fileId);
  final int fileId;
}
