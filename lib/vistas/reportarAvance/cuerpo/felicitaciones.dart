import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';

class Felicitaciones extends StatefulWidget {

  Felicitaciones({Key key}) : super(key: key);

  @override
  _FelicitacionesState createState() => _FelicitacionesState();
}

class _FelicitacionesState extends State<Felicitaciones> {
 
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/Desglose/Demas/bg-felicitaciones.jpg"),
            fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 70.0, right: 70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('assets/img/Desglose/Demas/icn-cohete.png'), 
              width: 100.0, 
              height: 130,
            ),
            Text(
              '¡Felicitaciones!',
              style: AppTheme.h1Blanco,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Tu proyecto ha sido actualizado exitosamente',
              style: AppTheme.parrafoBlanco,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (context) => ListaProyectos()
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width-60.0,
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only( 
                      topLeft:     Radius.circular(30.0),
                      topRight:    Radius.circular(30.0),
                      bottomLeft:  Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    gradient: LinearGradient(
                      colors: <Color>[
                        AppTheme.onceavo,
                        AppTheme.onceavo,
                        AppTheme.onceavo,
                      ],
                    ),
                    border: Border(
                      top: BorderSide(width: 1.0, color: AppTheme.onceavo),
                      left: BorderSide(width: 1.0, color: AppTheme.onceavo),
                      right: BorderSide(width: 1.0, color: AppTheme.onceavo),
                      bottom: BorderSide(width: 1.0, color: AppTheme.onceavo),
                    ),
                  ),
                  padding: EdgeInsets.only(left:20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Inicio',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  )
                ),
              )
            )

            
          ],
        ),
      ),
    );
  }
}







