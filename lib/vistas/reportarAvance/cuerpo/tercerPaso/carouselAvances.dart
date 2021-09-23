import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/tercerPaso/card_carousel_avances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget carouselAlcance(context) {
  return CarouselSlider(
    enableInfiniteScroll: false,
    enlargeCenterPage: true,
    height: 260.0,
    items: <Widget>[
      for (int cont = 0;
          cont <
              contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                      ['datos']['indicadoresAlcance']
                  .length;
          cont++)
        cardCarousel3(
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                ['indicadoresAlcance'][cont]['descripcionIndicadorAlcance'],
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['indicadoresAlcance'][cont]['unidadMedida'],
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['indicadoresAlcance'][cont]['cantidadProgramada'],
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['indicadoresAlcance'][cont]['cantidadEjecutada'],
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]
                ['datos']['indicadoresAlcance'][cont]['porcentajeAvance'],
            contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']
                ['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'], (value) {
          contenidoWebService[0]['proyectos']
                      [posicionListaProyectosSeleccionado]['datos']
                  ['indicadoresAlcance'][cont]['txtEjecucionIndicadorAlcance'] =
              value;
        })
    ],
  );
}


