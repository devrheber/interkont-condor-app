part of 'aom_report_step_2_bloc.dart';

class AomReportStep2State extends Equatable {
  const AomReportStep2State({
    this.answers = const [
      true,
      false,
      false,
      false,
      false,
      false,
      false,
    ],
    this.vidaUtilRemanenteConsideradaOff = 0,
    this.vidaUtilRemanenteNoConsideradaText = "",
  });

  final List<bool> answers;
  final String vidaUtilRemanenteNoConsideradaText;
  final int vidaUtilRemanenteConsideradaOff;

  AomReportStep2State copyWith({
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    int? vidaUtilRemanenteConsideradaOff,
  }) {
    return AomReportStep2State(
      answers: answers ?? this.answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText ??
          this.vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff ??
          this.vidaUtilRemanenteConsideradaOff,
    );
  }

  @override
  List<Object> get props => [
        answers,
        vidaUtilRemanenteNoConsideradaText,
        vidaUtilRemanenteConsideradaOff,
      ];
}
