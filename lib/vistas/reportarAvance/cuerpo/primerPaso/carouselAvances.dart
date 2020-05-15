import 'package:appalimentacion/globales/variables.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CarouselAvances extends StatefulWidget {
  final String txtBuscar;
  CarouselAvances({Key key, this.txtBuscar}) : super(key: key);
  
  @override
  CarouselAvancesState createState() => CarouselAvancesState();
}

class CarouselAvancesState extends State<CarouselAvances> {
  List lista = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'];
  List listaDos = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'];

  calcular(cont, value)
  {
    print(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['cantidadEjecutada']);

    setState(() {
      // lista[cont]['cantidadEjecutada'] = double.parse('${listaDos[cont]['cantidadEjecutada']}')+double.parse('${value}');
    });
  }

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
        cardCarousel(
          (){},
          lista[cont]['descripcionActividad'],
          lista[cont]['unidadMedida'],
          lista[cont]['valorUnitario'],
          lista[cont]['cantidadProgramada'],
          lista[cont]['valorProgramado'],
          lista[cont]['cantidadEjecutada'],
          lista[cont]['valorEjecutado'],
          lista[cont]['porcentajeAvance'],
          lista[cont]['txtActividadAvance'],
          (value){
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['actividades'][cont]['txtActividadAvance'] = value;


            // setState(() {
            //   lista[cont]['cantidadEjecutada'] = double.parse('${listaDos[cont]['cantidadEjecutada']}')+double.parse(value);  
            // });
            
          }
        )
      ],
    );
  }
}

  double totalValorEjecutado = 0.0;
  Widget cardCarousel(
    calcularPorcentajeValorEjecutado,
    String descripcionActividad,
    unidadMedida,
    valorUnitario,
    cantidadProgramada,
    valorProgramado,
    double cantidadEjecutada,
    valorEjecutado,
    porcentajeAvance,
    txtActividadAvance,
    accion
  )
  {
    calcularPorcentajeValorEjecutado();
    TextEditingController controllerPrimerPasoTxtAvance = TextEditingController();

    if(txtActividadAvance != null && txtActividadAvance != ''){
      controllerPrimerPasoTxtAvance.text = txtActividadAvance;

    }else{
      
    }

    return Container(
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
            descripcionActividad,
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
                    onChanged: accion,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0, 
                    ),
                    decoration: InputDecoration.collapsed(
                      hintText: "0",
                      hintStyle: TextStyle(
                        fontSize: 20.0, 
                        color: Color(0xffE3E3E3),
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
                unidadMedida,
                false,
                false,
                0
              ),
              celdas(
                'Valor Unitario',
                '\$ $valorUnitario',
                false,
                true,
                2
              ),
              celdas(
                'Cant. Programada',
                '$cantidadProgramada',
                false,
                true,
                1
              ),
              celdas(
                'Valor Programado',
                '\$ $valorProgramado',
                false,
                true,
                2
              ),
              celdas(
                'Cant. Ejecutada',
                '$cantidadEjecutada',
                true,
                true,
                1
              ),
              celdas(
                'Valor Ejecutado',
                '\$ $valorEjecutado',
                true,
                true,
                2
              ),
              celdas(
                'Avance a hoy',
                '$porcentajeAvance %',
                true,
                true,
                1
              ),
            ],
          )
        ],
      )
    );
  }
  
  Widget celdas(
    txtIzquierda, 
    txtDerecha, 
    negrita, 
    bool variableNumerica,
    int numeroDecimales
  )
  {
    FontWeight fontWeight = FontWeight.w200;
    if(negrita == true){
      fontWeight = FontWeight.w600;
    }

    if(variableNumerica == true){
      List derecha = txtDerecha.split(" ");

      if(derecha.length > 1){
        if(derecha[1] == '%'){
          NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
          txtDerecha = f.format(double.parse(derecha[0]))+" "+derecha[1];
          // txtDerecha = '${derecha[0]}'+" "+derecha[1];
          // txtDerecha = double.parse(derecha[0]).toStringAsFixed(numeroDecimales)+" "+derecha[1];
        }else{
          NumberFormat f = new NumberFormat("#,##0.00", "es_AR");
          txtDerecha = derecha[0]+" "+f.format(double.parse(derecha[1]));
        }
        
      }else{
        NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
        txtDerecha = f.format(double.parse(derecha[0]));
        // txtDerecha =double.parse(derecha[0]).toStringAsFixed(numeroDecimales);
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
