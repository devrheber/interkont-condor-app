// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// import '../../../../globales/variables.dart';
// import 'card_carousel_avances.dart';

// class CarouselAvances extends StatefulWidget {
//   final String txtBuscar;
//   CarouselAvances({Key key, this.txtBuscar}) : super(key: key);

//   @override
//   CarouselAvancesState createState() => CarouselAvancesState();
// }

// class CarouselAvancesState extends State<CarouselAvances> {
//   List lista = contenidoWebService[0]['proyectos']
//       [posListaProySelec]['datos']['actividades'];
//   List listaDos = contenidoWebService[0]['proyectos']
//       [posListaProySelec]['datos']['actividades'];

//   calcular(cont, value) {
//     print(contenidoWebService[0]['proyectos']
//             [posListaProySelec]['datos']['actividades'][cont]
//         ['cantidadEjecutada']);

//     setState(() {
//       // lista[cont]['cantidadEjecutada'] = double.parse('${listaDos[cont]['cantidadEjecutada']}')+double.parse('${value}');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CarouselSlider(
//       options: CarouselOptions(
//         enableInfiniteScroll: false,
//         enlargeCenterPage: true,
//         height: 330.0,
//       ),
//       items: <Widget>[
//         for (int cont = 0; cont < lista.length; cont++)
//           // if(lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toUpperCase()) != -1 || lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar.toLowerCase()) != -1  )
//           if (lista[cont]['descripcionActividad'].indexOf(widget.txtBuscar) !=
//               -1)
//             CardCarouselAvances(
//               calcularPorcentajeValorEjecutado: () {},
//               descripcionActividad: lista[cont]['descripcionActividad'],
//               unidadMedida: lista[cont]['unidadMedida'],
//               valorUnitario: lista[cont]['valorUnitario'],
//               cantidadProgramada: lista[cont]['cantidadProgramada'],
//               valorProgramado: lista[cont]['valorProgramado'],
//               cantidadEjecutada: lista[cont]['cantidadEjecutada'],
//               valorEjecutado: lista[cont]['valorEjecutado'],
//               porcentajeAvance: lista[cont]['porcentajeAvance'],
//               txtActividadAvance: lista[cont]['txtActividadAvance'],
//               accion: (value) {
//                 contenidoWebService[0]['proyectos']
//                         [posListaProySelec]['datos']
//                     ['actividades'][cont]['txtActividadAvance'] = value;
//               },
//             ),
//       ],
//     );
//   }
// }

// double totalValorEjecutado = 0.0;
