import 'package:appalimentacion/globales/funciones/calcularValorEjecutado.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/buscador.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/carouselAvances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:toast/toast.dart';

final titleColor = Color(0xff444444);

class CardCuerpoPrimerPaso extends StatefulWidget {
  
  CardCuerpoPrimerPaso({Key key}) : super(key: key);
  
  @override
  CardCuerpoPrimerPasoState createState() => CardCuerpoPrimerPasoState();
}

class CardCuerpoPrimerPasoState extends State<CardCuerpoPrimerPaso> {
  // Ingrese cantidad de avance por actividad
  String txtBuscarAvance = '';
  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  String otros;

  @protected
  void initState() {
    super.initState();

    if(keyboardVisibilitySubscriberId == null){
      print('escuchar teclado ');
      keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if(visible == false){
            print('ejecutar');
            print('$visible');
            setState(() {
              otros = 'asd';
            });
          }
        },
      );
    }else{
      _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId);
      keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print(visible);
          if(visible == false){
            print('ejecutar');
            print('$visible');
            setState(() {
              otros = 'asd';
            });
          }
        },
      );
    }
  }


  // @override
  // void dispose() {
  //   print('dispose');
  //   _keyboardVisibility.removeListener(keyboardVisibilitySubscriberId);
  // }



  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/3.3,
            // left: 20.0, 
            // right: 20.0
          ),
          // color: Colors.black,
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  left: 20.0, 
                  right: 20.0
                ),
                padding: EdgeInsets.only(right: 5.0, left:5.0, bottom: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Ingrese el avance',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 17,
                        color: Color(0xFF334660),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      // 'Ingrese cantidad de avance por actividad $otros',
                      'Ingrese cantidad de avance por actividad',
                      style: TextStyle(
                        fontFamily: 'montserrat',
                        fontSize: 13,
                        color: Color(0xFF505050),
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  left: 20.0, 
                  right: 20.0
                ),
                child: buscador(
                  context,
                  (value){
                    setState(() {
                      txtBuscarAvance = value;
                    });
                  }
                ),
              ),
              
              
              SizedBox(
                height: 10.0,
              ),

              CarouselSlider(
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                height: 330.0,
                items: <Widget>[
                  for(int cont=0; cont < contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'].length; cont++)
                  // if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toUpperCase()) != -1 || lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toLowerCase()) != -1  )
                  if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['descripcionActividad'].indexOf(txtBuscarAvance) != -1)
                  cardCarousel(
                    (){
                      // print(cont);
                      if(cont == 0){

                      }
                      // contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorEjecutado']
                    },
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['descripcionActividad'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['unidadMedida'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorUnitario'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadProgramada'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorProgramado'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['porcentajeAvance'],
                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance'],
                    (value){
                      if(double.parse('$value') < 0 ){
                        Toast.show(
                          "Lo sentimos, solo aceptamos numeros positivos", 
                          context, 
                          duration: 3, 
                          gravity:  Toast.BOTTOM
                        );
                      }else{
                        print('positivo');
                        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance'] = value;
                        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada'] = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutadaInicial']}') + double.parse('$value');
                        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado'] = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada']}') * double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorUnitario']}');
                        contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['porcentajeAvance'] = double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorEjecutado']}') / double.parse('${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['valorProgramado']}')*100;
                        calcularValorEjecutado();
                      }
                    }
                  )
                ],
              ),

              // CarouselAvances(
              //   txtBuscar: txtBuscarAvance,
              // )
            ]
          )
        )
      ],
    );
  }
}