import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/quintoPaso/cardContenido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardCuerpoQuintoPaso extends StatelessWidget {
  NumberFormat f = new NumberFormat("#,##0.0", "es_AR");
  NumberFormat f2 = new NumberFormat("#,##0.00", "es_AR");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height/5.6, 
            left: 20.0, 
            right: 20.0
          ),
          // color: Colors.black,
          child: Column(
            children: <Widget>[
              cardContenidoQuintoPaso(
                context, 
                'Antes',
                'Asi va',
                '${f.format((100*(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorejecutado']/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])).round())}',
                '${((100*(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorejecutado']/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])).round())}',
                '${f2.format(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorejecutado'])}',
                'Deberia ir',
                '${f.format(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porcentajeProyectado'])}',
                '${f2.format((contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['porcentajeProyectado']/100)*contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])}',
                true,
                ''
              ),
              
              SizedBox(
                height: 10.0,
              ),

              cardContenidoQuintoPaso(
                context, 
                'Ahora',
                'Asi va en',
                '${f.format((contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['nuevoValorEjecutado']/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])*100)}',
                '${((contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['nuevoValorEjecutado']/contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])*100)}',
                '${contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['nuevoValorEjecutado']}',
                'Deberia ir en',
                '${f.format(contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado'])}',
                '${f2.format((contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['porcentajeValorProyectadoSeleccionado']/100)*contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['valorproyecto'])}',
                false,
                ''
              ),
              
            ]
          )
        )
      ],
    );
  }
}