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
    required this.vidaUtilRemanenteConsideradaOff,
    this.vidaUtilRemanenteNoConsideradaText = "",
    required this.vidaUtilEnMeses,
  });

  final List<bool> answers;
  final String vidaUtilRemanenteNoConsideradaText;
  final String vidaUtilRemanenteConsideradaOff;
  final int vidaUtilEnMeses;

  AomReportStep2State copyWith({
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    String? vidaUtilRemanenteConsideradaOff,
  }) {
    return AomReportStep2State(
      answers: answers ?? this.answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText ??
          this.vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff ??
          this.vidaUtilRemanenteConsideradaOff,
      vidaUtilEnMeses: this.vidaUtilEnMeses,
    );
  }

  @override
  List<Object> get props => [
        answers,
        vidaUtilRemanenteNoConsideradaText,
        vidaUtilRemanenteConsideradaOff,
        vidaUtilEnMeses,
      ];

  int get getNewVidaUtil => int.parse(vidaUtilRemanenteConsideradaOff);

  bool isStateValid() {
    if (answers.first == true) return true;

    if (vidaUtilRemanenteNoConsideradaText.trim().isEmpty) return false;

    if (vidaUtilRemanenteConsideradaOff.trim().isEmpty) return false;

    return true;
  }
}
