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
  const SendDataEvent(this.data);

  final AomActualizacionRequest data;
}

class RemoveFileEvent extends AomReportStep3Event {
  const RemoveFileEvent(this.key);
  final String key;
}

class ValidateData extends AomReportStep3Event {
  const ValidateData();
}
