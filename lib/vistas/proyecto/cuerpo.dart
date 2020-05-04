import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/widgets/seleccionaPeriodo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardCuerpo extends StatefulWidget {
  
  CardCuerpo({Key key}) : super(key: key);
  
  @override
  CardCuerpoState createState() => CardCuerpoState();
}

class CardCuerpoState extends State<CardCuerpo> {
  
  SharedPreferences prefs;
  void activarVariablesPreferences()
  async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefs;
    });
  }

  double valorejecutado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorejecutado'];
  double valorproyecto = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'];
  int porcentajeAsiVa = 0;

  @override
  void initState(){
    activarVariablesPreferences();
    setState(() {
      porcentajeAsiVa = ((100*valorejecutado)/valorproyecto).round();
    });
    if(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'] != null){
      setState(() {
        periodoIdSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'];  
      });
    }
  }

  // Seleccione el periodo a reportar
  int posicionPeriodoReportado = 0;
  int periodoIdSeleccionado = 0;

  cambiarPosicionPeriodoReportado(nuevaPosicion)
  {
    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodoIdSeleccionado'] = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodos'][nuevaPosicion]['periodoId'];
    setState(() {
      posicionPeriodoReportado = nuevaPosicion;
      periodoIdSeleccionado = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodos'][nuevaPosicion]['periodoId'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/2.75,
            left: 20.0, 
            right: 20.0
          ),
          child: Column(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[                    
                    resumen(context),

                    Container(
                      padding: EdgeInsets.only(
                        right: 20.0, 
                        left:20.0, 
                        bottom: 5.0
                      ),
                      child: Text(
                        'Seleccione el periodo a reportar',
                        style: AppTheme.parrafo
                      ),
                    ),

                    seleccionaPeriodo(
                      context,
                      posicionPeriodoReportado,
                      periodoIdSeleccionado,
                      contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['periodos'],
                      (posicion){cambiarPosicionPeriodoReportado(posicion);}
                    ),

                    contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['pendienteAprobacion'] == true
                    ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.only(
                      //   bottom: 10.0
                      // ),
                      decoration: BoxDecoration(
                        color: AppTheme.rojoBackground,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        ),
                      ),
                      padding: EdgeInsets.only(
                        top: 5.0,
                        bottom: 10.0,
                        left: 20.0,
                        right: 20.0
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 15.0,
                            margin: EdgeInsets.only(
                              bottom: 5.0
                            ),
                            child: Image.asset(
                              'assets/img/Desglose/Demas/icn-alert.png',
                            ),
                          ),
                          Text(
                            'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                            style: AppTheme.parrafoRojo,
                            textAlign: TextAlign.center
                          )
                        ],
                      )
                    )
                    :Text('')
                  ],
                )
              ),
            ],
          )
        ),
      ],
    );
  }

  Widget resumen(context)
  {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(
          bottom: 10.0
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.only(top:10.0, bottom: 20.0, left: 30.0, right: 30.0),
        child: Column(
          children: <Widget>[
            celdas(
              'Presupuesto',
              '\$ ${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto']}',
              false
            ),
            celdas(
              'Asi va',
              '$porcentajeAsiVa%',
              false
            ),
            celdas(
              'Asi deberia ir',
              '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porcentajeProyectado'].round()}%',
              false
            ),
            celdas(
              'Contratista',
              '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['contratista']}',
              false
            ),
            celdas(
              'Semaforo',
              '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['semaforoproyecto']}',
              true
            ),

          ],
        )
      )
    );
  }

  Widget celdas(txtPrimero, txtSegundo, semaforo)
  {
    // SI LA VARIABLE "SEMAFORO" ESTA EN TRUE SIGNIFICA QUE ES LA ULTIMA CELDA, 
    // POR LO TANTO NO TIENE BORDE EN BOTTOM Y SU PADDING EN BOTTOM ES MENOR
    String iconoSemaforo = 'semaforo-3';
    if(semaforo == true){
      if(txtSegundo == 'rojo'){
        iconoSemaforo = 'semaforo-3';
      }else if(txtSegundo == 'amarillo'){
        iconoSemaforo = 'semaforo-2';
      }else if(txtSegundo == 'verde'){
        iconoSemaforo = 'semaforo-1';
      }
    }
    return Container(
      padding: 
      semaforo == true
      ?EdgeInsets.only(
        top: 10.0
      )
      :EdgeInsets.only(
        bottom:10.0, 
        top: 10.0
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: 
          semaforo != true
          ?BorderSide(
            width: 0.3, 
            color: Colors.black
          )
          :BorderSide(
            width: 0.0,
            color: Colors.white
          )
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              '$txtPrimero',
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.darkText,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: 
            semaforo == true
            ?Container(
              height: 20.0,
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'assets/img/Desglose/Home/'+iconoSemaforo+'.png',
                  ),
                ],
              )
            )
            :Text(
              '$txtSegundo',
              style: AppTheme.parrafo
            )
          )
          
        ],
      )
    );
  }

}