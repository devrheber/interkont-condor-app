import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'felicitaciones.dart';
import 'last_step_provider.dart';
import 'noInternet.dart';

class LastStep extends StatefulWidget {
  const LastStep._({Key? key}) : super(key: key);

  static Widget init({Key? key}) {
    return ChangeNotifierProvider(
      create: (context) => LastStepProvider(
        projectsRepository: context.read(),
        filesPersistentCacheRepository: context.read(),
        projectsCacheRepository: context.read(),
      ),
      child: LastStep._(key: key),
    );
  }

  @override
  State<StatefulWidget> createState() => LastStepState();
}

class LastStepState extends State<LastStep> {
  late LastStepProvider lastStepProvider;

  @override
  void initState() {
    super.initState();
    lastStepProvider = context.read<LastStepProvider>();

    ToastContext().init(context);

    lastStepProvider.guardarAlimentacion();

    lastStepProvider.sendData().then((Map<String, dynamic> value) {
      if ((value['state'] as SendDataState) == SendDataState.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Felicitaciones(
                    projectCode: lastStepProvider.projectCode,
                  )),
        );
      } else if ((value['state'] as SendDataState) ==
          SendDataState.noInternet) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NoInternet()),
        );
        lastStepProvider.saveDataPendingToPublish();
      } else if (value['state'] == SendDataState.backendError) {
        Navigator.pop(context);
        Toast.show(value['message'], duration: 6);
      } else {
        Navigator.pop(context);
        Toast.show(value['message'], duration: 6);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(
      fontFamily: 'montserrat',
      fontWeight: FontWeight.bold,
      fontSize: 30,
      color: Colors.white,
    );

    return Scaffold(
      body: Container(
        color: const Color(0xff2196F3),
        child: Stack(
          children: <Widget>[
            StreamBuilder<double>(
                stream: lastStepProvider.uploadPercentage,
                initialData: 0.0,
                builder: (context, AsyncSnapshot<double> snapshot) {
                  double percentage = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularPercentIndicator(
                          radius: 120,
                          lineWidth: 6,
                          percent: percentage.clamp(0, 1),
                          center: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "${(percentage.clamp(0, 1) * 100).round()}",
                                style: style,
                              ),
                              Text(
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
                        percentage == 1
                            ? 'Obteniendo respuesta'
                            : 'Estamos cargando tu proyecto',
                        style: const TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  );
                }),

            /*Positioned(
                width: MediaQuery.of(context).size.width/2,
                height: 100.0,
                top: MediaQuery.of(context).size.height-150.0,
                // top: 20.0,
                right: MediaQuery.of(context).size.width/4.1,
                child: Container(
                  child: Image(
                    image: AssetImage(
                      'assets/img/Desglose/Login/logo-footer.png',
                    )
                  )
                )
              )*/
          ],
        ),
      ),
    );
  }

  Widget aro(Widget contenido, int rgb) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(rgb, rgb, rgb, 0.1),
        border: const Border(
          top: BorderSide(width: 40.0, color: Colors.transparent),
          left: BorderSide(width: 40.0, color: Colors.transparent),
          right: BorderSide(width: 40.0, color: Colors.transparent),
          bottom: BorderSide(width: 40.0, color: Colors.transparent),
        ),
      ),
      child: contenido,
    );
  }
}
