import 'dart:convert';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/felicitaciones.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/noInternet.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CargandoFinalizar extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _CargandoFinalizarState();

}

class _CargandoFinalizarState extends State<CargandoFinalizar> with SingleTickerProviderStateMixin {
  
  AnimationController _controller;
  Animation<double> animation;
  Animation<double> animationDos;
  String i = '0';
  String contadorRgb = '0';
  @override
  void initState(){
    super.initState();
    _controller = AnimationController(duration:const Duration(seconds: 10), vsync: this);
    animation =Tween<double>(begin: 0, end: 100).animate(_controller)
    ..addListener((){
      setState((){
        // The state that has changed here is the animation objects value
        i = animation.value.toStringAsFixed(0);
      });
    });
    animationDos =Tween<double>(begin: 1600, end: 0).animate(_controller)
    ..addListener((){
      setState((){
        // The state that has changed here is the animation objects value
        contadorRgb = animationDos.value.toStringAsFixed(0);
      });
    });
    _controller.forward();


    guardarAlimentacion();

    super.initState();
    Future.delayed(
      Duration(seconds: 10),
      () {
        if( contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porPublicar'] == false ){
          Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (context) => Felicitaciones()
            ),
          );
        }
      },
    );
  }

  guardarAlimentacion()
  async{
    print('ENVIANDO LOS DATOS...');
    String url ="$urlGlobal/cobra-ws-condor/guardar-alimentacion";
    List actividades = [];
    List avancesCualitativos = [];
    List factoresAtraso = [];
    List indicadoresAlcance = [];

    for(int cont=0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'].length; cont++){
      double cantidadEjecutada;
      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance'] != null){
        cantidadEjecutada = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance']}');
      }else{
        cantidadEjecutada = 0.0;
      }
      var listaArmada = {
        'actividadId' : int.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['actividadId']}'),
        'cantidadEjecutada' : cantidadEjecutada
      };
      actividades.add(listaArmada);
    }

    for(int cont=0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'].length ; cont++){

      String dificultad;
      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['dificultad'] == null || contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['dificultad'] == ''){
        dificultad = '';
      }else{
        dificultad = '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['dificultad']}';
      }

      String logros;
      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['logro'] == null || contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['logro'] == ''){
        logros = '';
      }else{
        logros = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['logro'];
      }

      var listaArmada = {
        'aspectoEvaluarId'            : contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['avancesCualitativos'][cont]['aspectoEvaluarId'],
        'dificultadesAspectoEvaluar'  : dificultad,
        'logrosAspectoEvaluar'        : logros,
      };
      
      avancesCualitativos.add(listaArmada);
    }

    for(int cont = 0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'].length; cont++){
      factoresAtraso.add({
        'factorAtrasoId' : contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['factoresAtrasoSeleccionados'][cont]['factorAtrasoId']
      });
    }
    
    for(int cont = 0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'].length; cont++){
      double cantidadEjecucion;
      if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'] == null || contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'] == ''){
        cantidadEjecucion = 0.0;
      }else{
        cantidadEjecucion = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance']}');
      }
      var listaArmada = {
        'indicadorAlcanceId'  : contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['indicadoresAlcance'][cont]['indicadorAlcanceId'],
        'cantidadEjecucion' : cantidadEjecucion,
      };
      indicadoresAlcance.add(listaArmada);
    }

    print(indicadoresAlcance);

    var body = {
      "actividades": actividades,
      "aspectosEvaluar": avancesCualitativos,
      "codigoproyecto": contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['codigoproyecto'],
      "descripcion": contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['txtComentario'],
      "factoresAtraso": factoresAtraso,
      "fotoPrincipal": {
        "image": contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['fileFotoPrincipal'],
        "nombre": "fotoPrincipal",
        "tipo": "jpeg"
      },
      "imagenesComplementarias": contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['filesFotosComplementarias'],
      "indicadoresAlcance": indicadoresAlcance,
      "periodoId": contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'],
      "usuario": contenidoWebService[0]['usuario']['nombreUsu']
    };

    String tokenUsu  = contenidoWebService[0]['usuario']['tokenUsu'];

    try{
      var response = await http.post(
        url, 
        body: jsonEncode(body),
        headers: {
          "Content-type": "application/json",
          'Authorization' : tokenUsu
        },
      );

      print('-----------');
      print(response.body);
      print(response.statusCode);
      if(response.statusCode == 200 || response.statusCode == 201 ){
        print('SE PUDO');
        print(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['fileFotoPrincipal']);
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['paso'] = 0;
        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porPublicar'] = false;
      }else{
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => NoInternet()
          ),
        );
      }
    }catch(erro){
      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porPublicar'] = true;
      Navigator.push(
        context, 
        MaterialPageRoute(
          builder: (context) => NoInternet()
        ),
      );
    }    
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  Future<Widget> getRootPage() async =>
  Felicitaciones();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Preloader/bg-preloader.jpg"),
            fit: BoxFit.cover
          ),
        ),
        child: Stack(
            children: <Widget>[
              Center(
                child: new CircularPercentIndicator(
                  radius: 140.0,
                  lineWidth: 2.0,
                  percent: double.parse('$i')/100,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "$i",
                        style: TextStyle( 
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "%",
                        style: TextStyle( 
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                  progressColor: Colors.white,
                  animateFromLastPercent: true,
                )
              ),
              
              Positioned(
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
              )
            ],
          )
      ),
    );
    
  }
  
  Widget aro(Widget contenido, int rgb)
  {
    return Container(
      height: MediaQuery.of(context).size.height/1.8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color.fromRGBO(rgb, rgb, rgb, 0.1),
        border: Border(
          top: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          left: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          right: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
          bottom: BorderSide(
            width: 40.0, 
            color: Colors.transparent
          ),
        ),
        
      ),
      child: contenido
    );
  }
}
