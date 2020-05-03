import 'dart:convert';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/funciones/obtenerDatosProyecto.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appalimentacion/widgets/cargando.dart';
import 'package:appalimentacion/widgets/respuestaHttp.dart';
import 'package:http/http.dart' as http;

final titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/11
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/7.5,
                margin: EdgeInsets.only(top: 40.0,right: 20, left: 20,),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: titleColor.withOpacity(.1),
                      blurRadius: 20,
                      spreadRadius: 10
                    ),
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.only(top:42.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Bienvenido',
                        style: AppTheme.h2,
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        contenidoWebService[0]['usuario']['nombreUsu'],
                        // 'Usuario Admin',
                        style: AppTheme.parrafo,
                      )
                    ],
                  ),
                )
              ),
              Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 95,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/img/Desglose/Home/img-perfil.png'), 
                              fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                      ],
                    )
                  )
                )
              ),
            ],    
          ),
        ),
        
        SizedBox(
          height: 10,
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/3.5,
            left: 20.0, 
            right: 20.0
          ),
          // color: Colors.black,
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Mis Proyectos ', 
                          style: AppTheme.h1
                        ),
                        Text(
                          '(${contenidoWebService[0]['proyectos'].length} proyectos)', 
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.segundo,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      'Selecciona un proyecto', 
                      style: AppTheme.parrafo
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    for(int cont = 0; cont < contenidoWebService[0]['proyectos'].length; cont++)
                      proyecto(
                        context,
                        cont,
                        contenidoWebService[0]['proyectos'][cont]['codigoproyecto'],
                        contenidoWebService[0]['proyectos'][cont]['nombrecategoria'],
                        contenidoWebService[0]['proyectos'][cont]['nombreproyecto'],
                        contenidoWebService[0]['proyectos'][cont]['valorejecutado'],
                        contenidoWebService[0]['proyectos'][cont]['valorproyecto'],
                        false,
                        'icn-linea-1',
                        contenidoWebService[0]['proyectos'][cont]['semaforoproyecto'],
                        contenidoWebService[0]['proyectos'][cont]['colorcategoria'],
                        contenidoWebService[0]['proyectos'][cont]['imagencategoria']
                      ),
                    if(contenidoWebService[0]['proyectos'].length == 0)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  height: 150.0,
                                  margin: EdgeInsets.only(bottom:20.0, top: 20.0, right: 20.0),
                                  child: Image.asset(
                                    'assets/img/Desglose/Demas/img-noimage.png'
                                  ),
                                )
                              ),
                            ],
                          ),
                          Text(
                            'Aún no tienes proyectos',
                            style: AppTheme.comentarioPlomo,
                          )
                        ],
                      )
                    )
                  ],
                )
              ),
            ],
          )
        ), 
      ],
    ); 
  }

  Widget proyecto(
    context,
    posicion,
    idProyecto, 
    titulo, 
    descripcion, 
    valorEjecutado,
    valorProyecto,
    faltaPublicar, 
    nombreIcono, 
    nombreSemaforo,
    colorTitulo,
    imagencategoria
  )
  {
    int porcentaje = ((100*valorEjecutado)/valorProyecto).round();

    String iconoSemaforo = 'semaforo-3';
    if(nombreSemaforo == 'rojo'){
      iconoSemaforo = 'semaforo-3';
    }else if(nombreSemaforo == 'amarillo'){
      iconoSemaforo = 'semaforo-2';
    }else if(nombreSemaforo == 'verde'){
      iconoSemaforo = 'semaforo-1';
    }

    colorTitulo = colorTitulo.split("#");
    colorTitulo = "0XFF"+colorTitulo[1];

    // VALOR EN MILLONES
    var valorProyectoRedondeado = valorProyecto/1000000;
    valorProyectoRedondeado = double.parse((valorProyectoRedondeado).toStringAsFixed(1));
    return GestureDetector(
      onTap: () async{
        _seleccionarProyecto(
          context,
          posicion,
          idProyecto,
          nombreIcono
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.only(top:10.0, bottom: 10.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Image.network(
                    '$imagencategoria'
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(left:10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text(
                                '$titulo',
                                style: TextStyle( 
                                  fontFamily: 'montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                  letterSpacing: 0.4,
                                  height: 0.9,
                                  color: Color(int.parse(colorTitulo))
                                ),
                                // style: AppTheme.tituloParrafo
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.5  ,
                        ),
                        Text(
                          '$descripcion', 
                          style: TextStyle( 
                            fontFamily: "montserrat",
                            fontWeight: FontWeight.w600,
                            fontSize: 9,
                            color: Color(0xFF556a8d)
                          )
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        width: 90.0,
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            right: BorderSide(width: 0.5, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        child: Text(
                                            '\$ $valorProyectoRedondeado'+'M', 
                                            style: AppTheme.comentarioPlomo
                                          ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(width: 0.5, color: Color(0xFFFF000000)),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$porcentaje'+'%', 
                                              style: AppTheme.comentarioPlomo
                                            ),
                                          )
                                        )
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Image.asset(
                                            'assets/img/Desglose/Home/${iconoSemaforo}.png',
                                            height: 15.0,
                                          )
                                        )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: Text(''),
                            // )
                          ],
                        ),
                      ],
                    )
                  )
                ),
              ],
            ),


            if(faltaPublicar == true)
            Container(
              margin: EdgeInsets.only(
                top:5.0,
                bottom: 5.0
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      'assets/img/Desglose/Home/btn-por-publicar.png'
                    )
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  _seleccionarProyecto(context, posicion, idProyecto, nombreIcono)
  async{
    posicionListaProyectosSeleccionado = posicion;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if(contenidoWebService[0]['proyectos'][posicion]['paso'] == null){
      contenidoWebService[0]['proyectos'][posicion]['paso'] = 0;
      prefs.setString('contenidoWebService', jsonEncode(contenidoWebService));
    }else{

    }
    print('PASO ACTUAL:');
    print(contenidoWebService[0]['proyectos'][posicion]['paso']);
    //miomio

    var respuesta = await obtenerDatosProyecto(idProyecto);
    if(respuesta){
      switch (contenidoWebService[0]['proyectos'][posicion]['paso']) {
        case 0:
          cambiarPagina(
            context,
            Proyecto()
          );
          break;
        case 1:
          cambiarPagina(
            context, 
            ReportarAvance()
          );
          break;
        default:
        cambiarPagina(
          context, 
          ReportarAvance()
        );
      }
    }else{

    }
  }
}



