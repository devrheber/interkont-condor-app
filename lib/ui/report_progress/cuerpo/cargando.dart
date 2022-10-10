import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/percent_indicator.dart';
import 'package:toast/toast.dart';

import '../../../globales/funciones/actualizarProyectos.dart';
import '../../../globales/funciones/cambiarPasoProyecto.dart';
import '../../../globales/funciones/obtenerDatosProyecto.dart';
import '../../../globales/funciones/obtenerListaProyectos.dart';
import '../../../globales/variables.dart';
import 'felicitaciones.dart';
import 'noInternet.dart';

class CargandoFinalizar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CargandoFinalizarState();
}

class _CargandoFinalizarState extends State<CargandoFinalizar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  String i = '0';
  String contadorRgb = '0';
  bool correcto = false;
  bool pasaron10Segundos = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 10), vsync: this);
    animation = Tween<double>(begin: 0, end: 100).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation objects value
          i = animation.value.toStringAsFixed(0);
        });
      });
    _controller.forward();

    guardarAlimentacion();

    super.initState();
    Future.delayed(
      Duration(seconds: 10),
      () {
        setState(() {
          pasaron10Segundos = true;
        });
        if (correcto == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Felicitaciones()),
          );
        } else {
          Toast.show("Espere un momento en linea porfavor", context,
              duration: 5, gravity: Toast.BOTTOM);
        }
      },
    );
  }

  guardarAlimentacion() async {
    print('ENVIANDO LOS DATOS...');
    String url = "$urlGlobalApiCondor/guardar-alimentacion";
    List actividades = [];
    List avancesCualitativos = [];
    List factoresAtraso = [];
    List indicadoresAlcance = [];

    if (contenidoWebService[0]['proyectos'][posListaProySelec]
            ['datos']['actividades'] !=
        null) {
      for (int cont = 0;
          cont <
              contenidoWebService[0]['proyectos']
                          [posListaProySelec]['datos']
                      ['actividades']
                  .length;
          cont++) {
        double cantidadEjecutada;
        if (contenidoWebService[0]['proyectos']
                    [posListaProySelec]['datos']['actividades']
                [cont]['txtActividadAvance'] !=
            null) {
          cantidadEjecutada = double.parse(
              '${contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][cont]['txtActividadAvance']}');
        } else {
          cantidadEjecutada = 0.0;
        }
        var listaArmada = {
          'actividadId': int.parse(
              '${contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['actividades'][cont]['actividadId']}'),
          'cantidadEjecutada': cantidadEjecutada
        };
        actividades.add(listaArmada);
      }
    }

    if (contenidoWebService[0]['proyectos'][posListaProySelec]
            ['datos']['avancesCualitativos'] !=
        null) {
      for (int cont = 0;
          cont <
              contenidoWebService[0]['proyectos']
                          [posListaProySelec]['datos']
                      ['avancesCualitativos']
                  .length;
          cont++) {
        String dificultad;
        if (contenidoWebService[0]['proyectos']
                        [posListaProySelec]['datos']
                    ['avancesCualitativos'][cont]['dificultad'] ==
                null ||
            contenidoWebService[0]['proyectos']
                        [posListaProySelec]['datos']
                    ['avancesCualitativos'][cont]['dificultad'] ==
                '') {
          dificultad = '';
        } else {
          dificultad =
              '${contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['avancesCualitativos'][cont]['dificultad']}';
        }

        String logros;
        if (contenidoWebService[0]['proyectos']
                        [posListaProySelec]['datos']
                    ['avancesCualitativos'][cont]['logro'] ==
                null ||
            contenidoWebService[0]['proyectos']
                        [posListaProySelec]['datos']
                    ['avancesCualitativos'][cont]['logro'] ==
                '') {
          logros = '';
        } else {
          logros = contenidoWebService[0]['proyectos']
                  [posListaProySelec]['datos']
              ['avancesCualitativos'][cont]['logro'];
        }

        var listaArmada = {
          'aspectoEvaluarId': contenidoWebService[0]['proyectos']
                  [posListaProySelec]['datos']
              ['avancesCualitativos'][cont]['aspectoEvaluarId'],
          'dificultadesAspectoEvaluar': dificultad,
          'logrosAspectoEvaluar': logros,
        };

        avancesCualitativos.add(listaArmada);
      }
    }

    if (contenidoWebService[0]['proyectos'][posListaProySelec]
            ['datos']['factoresAtrasoSeleccionados'] !=
        null) {
      for (int cont = 0;
          cont <
              contenidoWebService[0]['proyectos']
                          [posListaProySelec]['datos']
                      ['factoresAtrasoSeleccionados']
                  .length;
          cont++) {
        factoresAtraso.add({
          'factorAtrasoId': contenidoWebService[0]['proyectos']
                  [posListaProySelec]['datos']
              ['factoresAtrasoSeleccionados'][cont]['factorAtrasoId']
        });
      }
    }

    if (contenidoWebService[0]['proyectos'][posListaProySelec]
            ['datos']['indicadoresAlcance'] !=
        null) {
      for (int cont = 0;
          cont <
              contenidoWebService[0]['proyectos']
                          [posListaProySelec]['datos']
                      ['indicadoresAlcance']
                  .length;
          cont++) {
        double cantidadEjecucion;
        if (contenidoWebService[0]['proyectos']
                            [posListaProySelec]['datos']
                        ['indicadoresAlcance'][cont]
                    ['txtEjecucionIndicadorAlcance'] ==
                null ||
            contenidoWebService[0]['proyectos']
                            [posListaProySelec]['datos']
                        ['indicadoresAlcance'][cont]
                    ['txtEjecucionIndicadorAlcance'] ==
                '') {
          cantidadEjecucion = 0.0;
        } else {
          cantidadEjecucion = double.parse(
              '${contenidoWebService[0]['proyectos'][posListaProySelec]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance']}');
        }
        var listaArmada = {
          'indicadorAlcanceId': contenidoWebService[0]['proyectos']
                  [posListaProySelec]['datos']
              ['indicadoresAlcance'][cont]['indicadorAlcanceId'],
          'cantidadEjecucion': cantidadEjecucion,
        };
        indicadoresAlcance.add(listaArmada);
      }
    }

    print(indicadoresAlcance);

    var body = {
      "actividades": actividades,
      "aspectosEvaluar": avancesCualitativos,
      "codigoproyecto": contenidoWebService[0]['proyectos']
          [posListaProySelec]['codigoproyecto'],
      "descripcion": contenidoWebService[0]['proyectos']
          [posListaProySelec]['datos']['txtComentario'],
      "factoresAtraso": factoresAtraso,
      "fotoPrincipal": {
        "image": contenidoWebService[0]['proyectos']
            [posListaProySelec]['datos']['fileFotoPrincipal'],
        "nombre": "fotoPrincipal",
        "tipo": "jpeg"
      },
      "imagenesComplementarias": contenidoWebService[0]['proyectos']
              [posListaProySelec]['datos']
          ['filesFotosComplementarias'],
      "indicadoresAlcance": indicadoresAlcance,
      "periodoId": contenidoWebService[0]['proyectos']
              [posListaProySelec]['datos']
          ['periodoIdSeleccionado'],
      "usuario": contenidoWebService[0]['usuario']['nombreUsu']
    };

    String tokenUsu = contenidoWebService[0]['usuario']['tokenUsu'];

    try {
      var uri = Uri.parse(url);
      var response = await http.post(
        uri,
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          'Authorization': tokenUsu
        },
      );

      print('============ LOG ERROR =============');
      print(url);

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          correcto = true;
        });
        cambiarPasoProyecto(0);
        print('SE PUDO');
        print(contenidoWebService[0]['proyectos']
            [posListaProySelec]['datos']['fileFotoPrincipal']);
        contenidoWebService[0]['proyectos'][posListaProySelec]
            ['paso'] = 0;
        contenidoWebService[0]['proyectos'][posListaProySelec]
            ['porPublicar'] = false;
        await obtenerListaProyectos();
        await actualizarProyectos();
        await obtenerDatosProyecto(
            contenidoWebService[0]['proyectos']
                [posListaProySelec]['codigoproyecto'],
            false);
        if (pasaron10Segundos == true) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Felicitaciones()),
          );
        }
      } else {
        contenidoWebService[0]['proyectos'][posListaProySelec]
            ['porPublicar'] = true;
        contenidoWebService[0]['proyectos'][posListaProySelec]
            ['paso'] = 5;
        cambiarPasoProyecto(5);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NoInternet()),
        );
      }
    } catch (erro) {
      print(contenidoWebService[0]['proyectos']
          [posListaProySelec]['paso']);
      print(contenidoWebService[0]['proyectos']
          [posListaProySelec]['paso']);
      contenidoWebService[0]['proyectos'][posListaProySelec]
          ['porPublicar'] = true;
      contenidoWebService[0]['proyectos'][posListaProySelec]
          ['paso'] = 5;
      cambiarPasoProyecto(5);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NoInternet()),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<Widget> getRootPage() async => Felicitaciones();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         color:Color(0xff2196F3),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: CircularPercentIndicator(
                    radius: 120.sp,
                    lineWidth: 6.sp,
                    percent: double.parse('$i') / 100,
                    center: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "$i",
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "%",
                          style: TextStyle(
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    progressColor: Color(0xff90CBF9),
                    animateFromLastPercent: true,
                  )),
                  SizedBox(height: 23.sp),
                  Text(
                    "Estamos cargando tu proyecto",
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w800,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

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
          )),
    );
  }

  Widget aro(Widget contenido, int rgb) {
    return Container(
        height: MediaQuery.of(context).size.height / 1.8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.fromRGBO(rgb, rgb, rgb, 0.1),
          border: Border(
            top: BorderSide(width: 40.0, color: Colors.transparent),
            left: BorderSide(width: 40.0, color: Colors.transparent),
            right: BorderSide(width: 40.0, color: Colors.transparent),
            bottom: BorderSide(width: 40.0, color: Colors.transparent),
          ),
        ),
        child: contenido);
  }
}
