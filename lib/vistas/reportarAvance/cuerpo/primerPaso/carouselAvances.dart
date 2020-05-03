import 'package:appalimentacion/globales/variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import 'package:flutter/material.dart';

class CarouselAvances extends StatefulWidget {
  final String txtBuscar;
  CarouselAvances({Key key, this.txtBuscar}) : super(key: key);
  
  @override
  CarouselAvancesState createState() => CarouselAvancesState();
}

class CarouselAvancesState extends State<CarouselAvances> {
  List lista = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'];
  TextEditingController controllerPrimerPasoTxtAvance = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      enableInfiniteScroll: false,
      enlargeCenterPage: true,
      height: 330.0,
      items: <Widget>[
        for(int cont=0; cont < lista.length; cont++)
        // if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toUpperCase()) != -1 || lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toLowerCase()) != -1  )
        if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar) != -1)
        Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xff444444),
                blurRadius: 5,
                spreadRadius: 0.1
              ),
            ],
            borderRadius: BorderRadius.only( 
              topLeft:     Radius.circular(15.0),
              topRight:    Radius.circular(15.0),
              bottomLeft:  Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Color(0xff0c81ab),
                Color(0xff2eac78)
              ],
            ),
          ),
          padding: EdgeInsets.only(left:20.0, right: 20.0, top: 35.0, bottom: 15.0),
          margin: EdgeInsets.only(
            right: 10.0,
            bottom: 10.0
          ),
          child: ListView(
            children: <Widget>[
              Text(
                lista[cont]['descripcionActividad'], 
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                'Ingresa el avance', 
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center
              ),
              Container(
                margin: EdgeInsets.only(
                  left:25.0, 
                  right: 25.0, 
                  top: 5.0, 
                  bottom: 15.0
                ),
                height: 50.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF48b3a1),
                  borderRadius: BorderRadius.only( 
                    topLeft:     Radius.circular(15.0),
                    topRight:    Radius.circular(15.0),
                    bottomLeft:  Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: controllerPrimerPasoTxtAvance,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0, 
                        ),
                        decoration: InputDecoration.collapsed(
                          hintText: "1.24",
                          hintStyle: TextStyle(
                            fontSize: 20.0, 
                            color: Colors.white,
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold
                          ), 
                        )
                      ),
                    )
                  ],
                )
              ),
              Column(
                children: <Widget>[
                  celdas(
                    'Unidad de medida',
                    lista[cont]['unidadMedida'],
                    false,
                    false
                  ),
                  celdas(
                    'Valor Unitario',
                    '\$ ${lista[cont]['valorUnitario']}',
                    false,
                    true
                  ),
                  celdas(
                    'Cantidad Programada',
                    '${lista[cont]['cantidadProgramada']}',
                    false,
                    false
                  ),
                  celdas(
                    'Valor Programado',
                    '\$ ${lista[cont]['valorProgramado']}',
                    false,
                    true
                  ),
                  celdas(
                    'Cantidad Ejecutada',
                    '${lista[cont]['cantidadEjecutada']}',
                    true,
                    true
                  ),
                  celdas(
                    'Valor Ejecutado',
                    '\$ ${lista[cont]['valorEjecutado']}',
                    true,
                    true
                  ),
                  celdas(
                    'Avance a hoy',
                    '${lista[cont]['porcentajeAvance']} %',
                    true,
                    true
                  ),
                ],
              )
            ],
          )
        )
      ],
    );
  }
}

Widget celdas(txtIzquierda, txtDerecha, negrita, bool variableNumerica)
{
  FontWeight fontWeight = FontWeight.w200;
  if(negrita == true){
    fontWeight = FontWeight.w600;
  }

  if(variableNumerica == true){
    List derecha = txtDerecha.split(" ");
    if(derecha.length > 1){
      if(derecha[1] == '%'){
        txtDerecha = double.parse(derecha[0]).toStringAsFixed(3)+" "+derecha[1];
      }else{
        txtDerecha = derecha[0]+" "+double.parse(derecha[1]).toStringAsFixed(3);
      }
      
    }else{
      txtDerecha =double.parse(derecha[0]).toStringAsFixed(3);
    }
    
  }
  

  return Container(
    padding: EdgeInsets.only(
      bottom:4.0, 
      top: 4.0
    ),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          width: 0.2, 
          color: Colors.white
        ),
        top: BorderSide(
          width: 0.2, 
          color: Colors.white
        ),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            '$txtIzquierda',
            style: TextStyle( 
              fontFamily: 'montserrat',
              fontWeight: fontWeight,
              fontSize: 10,
              color: Colors.white
            )
          ),
        ),
        Expanded(
          child: Text(
            '$txtDerecha',
            style: TextStyle( 
              fontFamily: 'montserrat',
              fontWeight: fontWeight,
              fontSize: 11,
              color: Colors.white
            ),
            textAlign: TextAlign.right,
          ), 
        )
        
      ],
    )
  );
}