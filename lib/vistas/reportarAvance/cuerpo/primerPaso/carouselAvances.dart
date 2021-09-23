import 'package:appalimentacion/globales/variables.dart';
import 'package:appalimentacion/vistas/reportarAvance/cuerpo/primerPaso/card_carousel_avances.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselAvances extends StatefulWidget {
  final String txtBuscar;
  CarouselAvances({Key key, this.txtBuscar}) : super(key: key);

  @override
  CarouselAvancesState createState() => CarouselAvancesState();
}

class CarouselAvancesState extends State<CarouselAvances> {
  List lista = contenidoWebService[0]['proyectos']
      [posicionListaProyectosSeleccionado]['datos']['actividades'];
  List listaDos = contenidoWebService[0]['proyectos']
      [posicionListaProyectosSeleccionado]['datos']['actividades'];

  calcular(cont, value) {
    print(contenidoWebService[0]['proyectos']
            [posicionListaProyectosSeleccionado]['datos']['actividades'][cont]
        ['cantidadEjecutada']);

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
        for (int cont = 0; cont < lista.length; cont++)
          // if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toUpperCase()) != -1 || lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toLowerCase()) != -1  )
          if (lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar) !=
              -1)
            cardCarousel1(
                () {},
                lista[cont]['descripcionActividad'],
                lista[cont]['unidadMedida'],
                lista[cont]['valorUnitario'],
                lista[cont]['cantidadProgramada'],
                lista[cont]['valorProgramado'],
                lista[cont]['cantidadEjecutada'],
                lista[cont]['valorEjecutado'],
                lista[cont]['porcentajeAvance'],
                lista[cont]['txtActividadAvance'], (value) {
              contenidoWebService[0]['proyectos']
                      [posicionListaProyectosSeleccionado]['datos']
                  ['actividades'][cont]['txtActividadAvance'] = value;

              // setState(() {
              //   lista[cont]['cantidadEjecutada'] = double.parse('${listaDos[cont]['cantidadEjecutada']}')+double.parse(value);
              // });
            })
      ],
    );
  }
}

double totalValorEjecutado = 0.0;
