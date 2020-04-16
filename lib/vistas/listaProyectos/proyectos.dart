import 'dart:convert';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:appalimentacion/vistas/reportarAvance/home.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final titleColor = Color(0xff444444);

class ProyectosContenido extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/4,
          margin: EdgeInsets.only( top: MediaQuery.of(context).size.height/5,),
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
                  padding: EdgeInsets.only(top:40.0),
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
                        'Usuario Admin',
                        style: AppTheme.parrafo,
                      )
                    ],
                  ),
                )
              ),
              Container(
                color: Colors.transparent,
                // margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/6)/1.5),
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
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2.5, left: 20.0, right: 20.0),
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
                          style: TextStyle(
                            fontSize: 18,
                            color: AppTheme.darkText,
                            fontWeight: FontWeight.w700,                            
                          ),
                        ),
                        Text(
                          '(10 proyectos)', 
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
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.darkText,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    proyecto(
                      context,
                      1,
                      true,
                      'icn-linea-1',
                      'semaforo-2'
                    ),
                    proyecto(
                      context,
                      2,
                      false,
                      'icn-linea-2',
                      'semaforo-1'
                    ),
                    proyecto(
                      context,
                      3,
                      false,
                      'icn-linea-3',
                      'semaforo-3'
                    ),
                    proyecto(
                      context,
                      4,
                      false,
                      'icn-linea-4',
                      'semaforo-3'
                    ),
                    proyecto(
                      context,
                      5,
                      true,
                      'icn-linea-5',
                      'semaforo-2'
                    ),
                    proyecto(
                      context,
                      6,
                      false,
                      'icn-linea-6',
                      'semaforo-3'
                    ),
                    proyecto(
                      context,
                      7,
                      false,
                      'icn-linea-7',
                      'semaforo-1'
                    ),
                    proyecto(
                      context,
                      8,
                      false,
                      'icn-linea-8',
                      'semaforo-2'
                    ),
                    proyecto(
                      context,
                      9,
                      true,
                      'icn-linea-9',
                      'semaforo-3'
                    ),
                    proyecto(
                      context,
                      10,
                      true,
                      'icn-linea-10',
                      'semaforo-3'
                    ),

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

  List proyectosSeleccionados = [];
  Widget proyecto(context, idProyecto, faltaPublicar, nombreIcono, nombreSemaforo)
  {
    return GestureDetector(
      onTap: () async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var nuevoElemento = {
          'id'    : idProyecto,
          'icono' : '$nombreIcono',
          'paso'  : 0
        };
        
        proyectosSeleccionados = json.decode(prefs.getString('listProyectosSeleccionados'));

        if(proyectosSeleccionados.length > 0){
          for(int cont = 0 ; cont < proyectosSeleccionados.length; cont++){
            if(proyectosSeleccionados[cont]['id'] == idProyecto){
              print('ya existe');
              posicionListaProyectosSeleccionado = cont;
              break;
            }else if(cont+1 == proyectosSeleccionados.length){
              proyectosSeleccionados.add( nuevoElemento );
              print('Agregado');
              posicionListaProyectosSeleccionado = proyectosSeleccionados.length-1;
              break;
            }
          }
        }else{
          proyectosSeleccionados.add( nuevoElemento );
          posicionListaProyectosSeleccionado = 0;
          print('primerElemento');
        }
        
        String stringListasProyectosSeleccionados = json.encode(proyectosSeleccionados);
        await prefs.setString('listProyectosSeleccionados', stringListasProyectosSeleccionados);
        await print(prefs.getString('listProyectosSeleccionados'));
        
        switch (proyectosSeleccionados[posicionListaProyectosSeleccionado]['paso']) {
          case 0:
            cambiarPagina(
              context, 
              Proyecto(
                nombreIcono: nombreIcono,
              )
            );
            break;
          case 1:
            cambiarPagina(
              context, 
              ReportarAvance()
            );    
            break;
          default:
        }

        
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
                  child: Image.asset(
                    'assets/img/Desglose/Home/${nombreIcono}.png'
                  )
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
                                'DCA SC', 
                                style: AppTheme.tituloParrafo
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.5  ,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    'Abrego Vehiculo Compactador', 
                                    style: AppTheme.parrafo
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '\$ 1.234', 
                                              style: AppTheme.comentarioPlomo
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              '77%', 
                                              style: AppTheme.comentarioPlomo
                                            ),
                                          )
                                        )
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.only(left:10.0),
                                          child: Image.asset(
                                            'assets/img/Desglose/Home/${nombreSemaforo}.png'
                                          )
                                        )
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(''),
                            )
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

}



