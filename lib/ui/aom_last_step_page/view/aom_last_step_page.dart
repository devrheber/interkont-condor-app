import 'package:appalimentacion/ui/aom_last_step_page/cubit/aom_last_step_cubit.dart';
import 'package:appalimentacion/ui/aom_last_step_page/widgets/congrats_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';

class LastStepAOMPage extends StatelessWidget {
  const LastStepAOMPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;

    return BlocProvider(
      create: (context) => AomLastStepCubit(
        aomProjectsRepository: context.read(),
      )..sendData(
          arguments['data'],
          arguments['files'],
        ),
      child: const LastStepAOMView(),
    );
  }
}

class LastStepAOMView extends StatelessWidget {
  const LastStepAOMView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontFamily: 'montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.white,
    );

    return BlocListener<AomLastStepCubit, AomLastStepState>(
      listener: (context, state) {
        if (state is AomLastStepFailure) {
          Navigator.pop(
            context,
            {
              'message': state.errorMessage,
            },
          );
        }
      },
      child: BlocBuilder<AomLastStepCubit, AomLastStepState>(
          builder: (context, state) {
        if (state is AomLastStepLoading) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: StreamBuilder<Map<String, dynamic>>(
                stream: context.read<AomLastStepCubit>().uploadPercentage,
                initialData: const {
                  'description': 'Enviando reporte',
                  'percentaje': 0.0,
                },
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  final description =
                      snapshot.data?['description'] ?? 'Enviando reporte';
                  final percentaje = snapshot.data?['percentaje'] ?? 0.0;
                  return Scaffold(
                    body: Container(
                      color: const Color(0xff2196F3),
                      child: Stack(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 120,
                                  lineWidth: 6,
                                  percent: percentaje.clamp(0, 1),
                                  center: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        "${(percentaje.clamp(0, 1) * 100).round()}",
                                        style: style,
                                      ),
                                      const Text(
                                        "%",
                                        style: style,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                  progressColor: const Color(0xff90CBF9),
                                  animateFromLastPercent: true,
                                ),
                              ),
                              const SizedBox(height: 23),
                              Text(
                                percentaje >= 1
                                    ? 'Obteniendo respuesta'
                                    : '$description \n Estamos registrando la actualización AOM',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        if (state is AomLastStepSuccess) {
          return WillPopScope(
            onWillPop: () async => false,
            child: const CongratsDialog(),
          );
        }

        return const SizedBox.shrink();
      }),
    );
  }
}

class AroContainer extends StatelessWidget {
  const AroContainer({
    Key? key,
    required this.contenido,
    required this.rgb,
  }) : super(key: key);

  final Widget contenido;
  final int rgb;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(rgb, rgb, rgb, 0.1),
        border: const Border(
          top: BorderSide(width: 40.0, color: Colors.transparent),
          left: BorderSide(width: 40.0, color: Colors.transparent),
          right: const BorderSide(width: 40.0, color: Colors.transparent),
          bottom: BorderSide(width: 40.0, color: Colors.transparent),
        ),
      ),
      child: contenido,
    );
  }
}
