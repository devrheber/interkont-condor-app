part of 'aom_category_detail_cubit.dart';

class AomReportState extends Equatable {
  const AomReportState({
    this.step = 1,
    required this.clasificationId,
    required this.projectCode,
    this.activos,
    this.answers,
    this.vidaUtilRemanenteNoConsideradaText,
    this.vidaUtilRemanenteConsideradaOff,
    required this.vidaUtilActualEnMeses,
    this.filesUploaded = const {},
    this.isKeyboardOpen = false,
  });

  final int step;
  final int clasificationId;
  final int projectCode;
  final List<ActivoUpdateRequest>? activos;
  final List<bool>? answers;
  final String? vidaUtilRemanenteNoConsideradaText;
  final int? vidaUtilRemanenteConsideradaOff;
  final int vidaUtilActualEnMeses;

  final bool isKeyboardOpen;

  final Map<String, ImagenesVideosOrRequest> filesUploaded;

  AomReportState copyWith({
    int? step,
    List<ActivoUpdateRequest>? activos,
    List<bool>? answers,
    String? vidaUtilRemanenteNoConsideradaText,
    int? vidaUtilRemanenteConsideradaOff,
    int? vidaUtilNuevaEnMeses,
    Map<String, ImagenesVideosOrRequest>? filesUploaded,
    bool? isKeyboardOpen,
  }) {
    return AomReportState(
      vidaUtilActualEnMeses: vidaUtilActualEnMeses,
      step: step ?? this.step,
      clasificationId: clasificationId,
      projectCode: projectCode,
      activos: activos ?? this.activos,
      answers: answers ?? this.answers,
      vidaUtilRemanenteNoConsideradaText: vidaUtilRemanenteNoConsideradaText ??
          this.vidaUtilRemanenteNoConsideradaText,
      vidaUtilRemanenteConsideradaOff: vidaUtilRemanenteConsideradaOff ??
          this.vidaUtilRemanenteConsideradaOff,
      filesUploaded: filesUploaded ?? this.filesUploaded,
      isKeyboardOpen: isKeyboardOpen ?? this.isKeyboardOpen,
    );
  }

  @override
  List<Object?> get props => [
        step,
        activos,
        answers,
        vidaUtilRemanenteNoConsideradaText,
        vidaUtilRemanenteConsideradaOff,
        vidaUtilActualEnMeses,
        filesUploaded,
        isKeyboardOpen,
      ];

  AomActualizacionRequest getDataToSend() {
    return AomActualizacionRequest(
      activosUpdate: activos!,
      respuesta1: answers![0],
      respuesta2: answers![1],
      respuesta3: answers![2],
      respuesta4: answers![3],
      respuesta5: answers![4],
      respuesta6: answers![5],
      respuesta7: answers![6],
      userId: 4,
      vidaUtilRemanenteConsideradaOff: !answers![0]
          ? vidaUtilRemanenteConsideradaOff!
          // : vidaUtilActualEnMeses,
          : null,
      vidaUtilRemanenteNoConsideradaText:
          !answers![0] ? vidaUtilRemanenteNoConsideradaText! : '',
      obraId: projectCode,
      clasificacionId: clasificationId,
      imagenesVideosOr: filesUploaded.values.toList(),
    );
  }
}
