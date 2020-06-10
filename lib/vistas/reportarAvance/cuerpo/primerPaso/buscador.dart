import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';

final titleColor = Color(0xff444444);

Widget buscador(context, accion)
{
  return Row(
    children: <Widget>[
      Expanded(
        flex: 2,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 40.0,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(10)
            ),
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.search
              ),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration.collapsed(hintText: "Buscar por palabra clave..", ),
                  onChanged: accion
                ),
              )
            ],
          )
        ),
      ),
      // Expanded(
      //   flex: 1,
      //   child: GestureDetector(
      //     onTap: (){
            
      //     },
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.only(  
      //           topLeft:     Radius.circular(15.0),
      //           topRight:    Radius.circular(15.0),
      //           bottomLeft:  Radius.circular(15.0),
      //           bottomRight: Radius.circular(15.0),
      //         ),
      //         gradient: LinearGradient(
      //           begin: Alignment.bottomLeft,
      //           end: Alignment.topRight,
      //           colors: <Color>[
      //             AppTheme.dieciochoavo,
      //             AppTheme.tercero
      //           ],
      //         ),
      //       ),
      //       margin: EdgeInsets.only(left:5.0),
      //       padding: EdgeInsets.only(left:20.0, right: 20.0, top: 10.0, bottom: 10.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: <Widget>[
      //           Expanded(
      //             child: Text(
      //               'Buscar',
      //               style: TextStyle(
      //                 color: Colors.white
      //               ),
      //               textAlign: TextAlign.center,
      //             )
      //           )
      //         ],
      //       )
      //     ),
      //   )
      // )
    ],
  );
}