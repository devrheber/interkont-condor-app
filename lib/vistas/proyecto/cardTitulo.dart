import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/transicion.dart';
import 'package:appalimentacion/vistas/listaProyectos/home.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

class CardTitulo extends StatefulWidget {
  final String nombreIcono;
  CardTitulo({Key key, this.nombreIcono}) : super(key: key);
  
  @override
  CardTituloState createState() => CardTituloState();
}

class CardTituloState extends State<CardTitulo> {
// class CardTitulo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/15
          ),
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height/4.5,
                padding: EdgeInsets.only(top: 1.0, bottom: 10.0),
                margin: EdgeInsets.only(top: 40.0,right: 20, left: 20),
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
                  padding: EdgeInsets.only(
                    top:20.0
                  ),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                          left:70.0, 
                          right: 70.0
                        ),
                        child: Text(
                          'TESALIA CENTRO DE DESARROLLO HIDRICO',
                          textAlign: TextAlign.center,
                          style: AppTheme.tituloParrafo
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left:30.0, 
                          right: 30.0
                        ),
                        child: Center(
                          child: Text(
                            'Estudios diseños y contruccion de centros de integracion ciudadana cic. grupo 1 - region pacifico de Colombia',
                            textAlign: TextAlign.center,
                            style: AppTheme.parrafo
                          ),
                        )
                      )
                    ],
                  )
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
                          height: 75,
                          width: 80,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/img/Desglose/Home/${widget.nombreIcono}.png'
                              ), 
                              fit: BoxFit.fill
                            ),
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: Colors.white, 
                              width: 5
                            )
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

        Container(
          width: MediaQuery.of(context).size.width,
          height: 30.0,
          margin: EdgeInsets.only( 
            top: MediaQuery.of(context).size.height/15
          ),
          padding: EdgeInsets.only(right: 20, left: 20),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ), 
                onPressed: (){
                  cambiarPagina(
                    context, 
                    ListaProyectos()
                  );
                }
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width/2.2
                )
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 100.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/img/Desglose/Demas/btn-descargar.png'
                        ), 
                        fit: BoxFit.fill
                      ),
                      // border: Border(
                      //   top: BorderSide(width: 0.5, color: Colors.white),
                      //   left: BorderSide(width: 0.5, color: Colors.white),
                      //   right: BorderSide(width: 0.5, color: Colors.white),
                      //   bottom: BorderSide(width: 0.5, color: Colors.white),
                      // ),
                      borderRadius: BorderRadius.all( 
                        Radius.circular(50.0),
                      ),
                    ),
                  )
                ],
              )
              
            ],
          )
        )
      ],
    );
  }
}