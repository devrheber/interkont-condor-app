import 'dart:convert';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/felicitaciones.dart';
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
        Navigator.push(
          context, 
          MaterialPageRoute(
            builder: (context) => Felicitaciones()
          ),);
      },
    );
  }

  guardarAlimentacion()
  async{
    String url ="$urlGlobal/cobra-ws-condor/guardar-alimentacion";
    
    var body = {
      "actividades": [
        {
          "actividadId": 0,
          "cantidadEjecutada": 0
        }
      ],
      "aspectosEvaluar": [
        {
          "aspectoEvaluarId": 0,
          "dificultadesAspectoEvaluar": "string",
          "logrosAspectoEvaluar": "string"
        }
      ],
      "codigoproyecto": 0,
      "descripcion": "string",
      "factoresAtraso": [
        {
          "factorAtrasoId": 0
        }
      ],
      "fotoPrincipal": {
        "image": "string",
        "nombre": "string",
        "tipo": "string"
      },
      "imagenesComplementarias": [
        {
          "image": "string",
          "nombre": "string",
          "tipo": "string"
        }
      ],
      "indicadoresAlcance": [
        {
          "cantidadEjecucion": 0,
          "indicadorAlcanceId": 0
        }
      ],
      "periodoId": 0,
      "usuario": "string"
    };

    String tokenUsu  = contenidoWebService[0]['usuario']['tokenUsu'];

    var response = await http.post(
      url, 
      body: jsonEncode(body),
      headers: {
        "Content-type": "application/json",
        'Authorization' : tokenUsu
      },
    );

    var respuesta = await respuestaHttp(response.statusCode);
    print('-----------');
    print(response.body);
    if(respuesta == true ){
      
    
    }else{
      
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
