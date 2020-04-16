import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/proyecto/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardCuerpo extends StatefulWidget {
  
  CardCuerpo({Key key}) : super(key: key);
  
  @override
  CardCuerpoState createState() => CardCuerpoState();
}

class CardCuerpoState extends State<CardCuerpo> {
// class CardCuerpo extends StatelessWidget {
  
  SharedPreferences prefs;
  void activarVariablesPreferences()
  async{
    prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = prefs;
    });
  }
  @override
  void initState(){
    activarVariablesPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
      
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/2 , left: 20.0, right: 20.0),
          // color: Colors.black,
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[                    
                    resumen(context),

                    Container(
                      padding: EdgeInsets.only(top:10.0, right: 20.0, left:20.0, bottom: 15.0),
                      child: Text(
                        'Seleccione el periodo a reportar',
                        style: AppTheme.parrafo
                      ),
                    ),

                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border(
                          top: BorderSide(width: 1.0, color: AppTheme.cuarto),
                          left: BorderSide(width: 1.0, color: AppTheme.cuarto),
                          right: BorderSide(width: 1.0, color: AppTheme.cuarto),
                          bottom: BorderSide(width: 1.0, color: AppTheme.cuarto),
                        ),
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Icon(
                              FontAwesomeIcons.clock
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              'del 14 feb hasta el 15 mar 19',
                              style: AppTheme.parrafo
                            )
                          ),
                          Expanded(
                            flex: 1,
                            child: Icon(
                              FontAwesomeIcons.arrowDown
                            ),
                          ),
                        ],
                      )
                    ),

                    //miomio
                    prefs.getString('estadoInformeProyecto')== 'informeNoAprobado'
                    ?
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                        color: AppTheme.rojoBackground,
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 20.0,
                            margin: EdgeInsets.only(
                              bottom: 5.0
                            ),
                            child: Image.asset(
                              'assets/img/Desglose/Demas/icn-alert.png',
                            ),
                          ),
                          Text(
                            'No puedes avanzar hasta que el Supervisor apruebe tu último informe de avance',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            
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
        cambiarPagina(
          context, 
          Proyecto()
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        padding: EdgeInsets.only(top:10.0, bottom: 20.0, left: 30.0, right: 30.0),
        child: Column(
          children: <Widget>[
            celdas(
              'Presupuesto',
              '\$ 1.245.041.248',
              false
            ),
            celdas(
              'Asi va',
              '63%',
              false
            ),
            celdas(
              'Asi deberia ir',
              '67%',
              false
            ),
            celdas(
              'Contratista',
              'Arqueada SAS',
              false
            ),
            celdas(
              'Semaforo',
              '',
              true
            ),

          ],
        )
      )
    );
  }

  Widget celdas(txtPrimero, txtSegundo, semaforo)
  {
    return Container(
      padding: EdgeInsets.only(bottom:10.0, top: 15.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black),
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
                    'assets/img/Desglose/Home/semaforo-3.png',
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