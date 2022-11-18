part of 'aom_report_step_3_bloc.dart';

enum AomReportStep3Status { initial, loading, success, failure }

enum ValidationStatus { initial, validating, success, failure }

class AomReportStep3State extends Equatable {
  const AomReportStep3State({
    this.status = AomReportStep3Status.initial,
    this.files = const {},
    this.filesUploaded = const {},
    this.errorMessage = '',
    this.validateStatus = ValidationStatus.initial,
  });

  final AomReportStep3Status status;
  final Map<String, File?> files;
  final Map<String, UploadFileResponse> filesUploaded;
  final String errorMessage;
  final ValidationStatus validateStatus;

  AomReportStep3State copyWith({
    AomReportStep3Status Function()? status,
    Map<String, File?> Function()? files,
    Map<String, UploadFileResponse> Function()? filesUploaded,
    String Function()? errorMessage,
    ValidationStatus Function()? validateStatus,
  }) {
    return AomReportStep3State(
      status: status != null ? status() : this.status,
      files: files != null ? files() : this.files,
      filesUploaded:
          filesUploaded != null ? filesUploaded() : this.filesUploaded,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      validateStatus:
          validateStatus != null ? validateStatus() : this.validateStatus,
    );
  }

  @override
  List<Object> get props => [
        status,
        files,
        filesUploaded,
        errorMessage,
        validateStatus,
      ];
}
