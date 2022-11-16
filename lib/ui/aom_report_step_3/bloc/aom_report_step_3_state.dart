part of 'aom_report_step_3_bloc.dart';

enum AomReportStep3Status { initial, loading, success, failure }

class AomReportStep3State extends Equatable {
  const AomReportStep3State({
    this.status = AomReportStep3Status.initial,
    this.files = const {},
    this.filesUploaded = const {},
    this.errorMessage = '',
  });

  final AomReportStep3Status status;
  final Map<int, File?> files;
  final Map<int, UploadFileResponse> filesUploaded;
  final String errorMessage;

  AomReportStep3State copyWith({
    AomReportStep3Status Function()? status,
    Map<int, File?> Function()? files,
    Map<int, UploadFileResponse> Function()? filesUploaded,
    String Function()? errorMessage,
  }) {
    return AomReportStep3State(
      status: status != null ? status() : this.status,
      files: files != null ? files() : this.files,
      filesUploaded:
          filesUploaded != null ? filesUploaded() : this.filesUploaded,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, files, filesUploaded, errorMessage];
}
