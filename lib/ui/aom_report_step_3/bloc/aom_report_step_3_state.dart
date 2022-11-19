part of 'aom_report_step_3_bloc.dart';

enum AomReportStep3Status { initial, loading, success, failure }

class AomReportStep3State extends Equatable {
  const AomReportStep3State({
    this.status = AomReportStep3Status.initial,
    this.files = const {},
    this.responseMessage = '',
  });

  final AomReportStep3Status status;
  final Map<String, File?> files;
  final String responseMessage;

  AomReportStep3State copyWith({
    AomReportStep3Status Function()? status,
    Map<String, File?> Function()? files,
    Map<String, ImagenesVideosOrRequest> Function()? filesUploaded,
    String Function()? responseMessage,
  }) {
    return AomReportStep3State(
      status: status != null ? status() : this.status,
      files: files != null ? files() : this.files,
      responseMessage: responseMessage != null ? responseMessage() : this.responseMessage,
    );
  }

  @override
  List<Object> get props => [
        status,
        files,
        responseMessage,
      ];
}
