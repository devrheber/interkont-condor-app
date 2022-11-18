part of 'aom_report_step_3_bloc.dart';

abstract class AomReportStep3Event extends Equatable {
  const AomReportStep3Event();

  @override
  List<Object> get props => [];
}

class PickFileEvent extends AomReportStep3Event {
  const PickFileEvent({
    required this.fileKey,
    required this.fileName,
    required this.file,
  });

  final String fileKey;
  final String fileName;
  final File file;
}

class SendDataEvent extends AomReportStep3Event {
  const SendDataEvent(
    this.fileKey,
    this.projectCode,
  );

  final int fileKey;
  final int projectCode;
}

class RemoveFileEvent extends AomReportStep3Event {
  const RemoveFileEvent(this.fileId);
  final int fileId;
}

class ValidateData extends AomReportStep3Event {
  const ValidateData();
}
