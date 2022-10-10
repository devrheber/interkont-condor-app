import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/tercerPaso/local_widgets/rendimiento_card.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

import '../../../widgets/title_subtitle.dart';
import '../../../../globales/variables.dart';
import 'card_carousel_avances.dart';

final titleColor = Color(0xff444444);

class CardCuerpoTercerPaso extends StatefulWidget {
  CardCuerpoTercerPaso({Key key}) : super(key: key);

  @override
  CardCuerpoTercerPasoState createState() => CardCuerpoTercerPasoState();
}

class CardCuerpoTercerPasoState extends State<CardCuerpoTercerPaso> {
  String txtBuscarAlcance = '';
  TextEditingController fechaReintegroController = TextEditingController();
  TextEditingController valorGeneradoController = TextEditingController();
  TextEditingController valorMesActualController = TextEditingController();
  TextEditingController valorMesVencidoController = TextEditingController();
  @protected
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var indAlcance = contenidoWebService[0]['proyectos']
        [posListaProySelec]['datos']['indicadoresAlcance'];
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20.0, right: 20.0),
                      padding:
                          EdgeInsets.only(right: 5.0, left: 5.0, bottom: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextTitle(text: 'Indicador de alcance'),
                          SizedBox(height: 2.sp),
                          TextSubtitle(
                              text:
                                  'Ingrese indicadores de alcance en el periodo'),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.sp),
                    Visibility(
                      visible: indAlcance.isNotEmpty,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          enlargeCenterPage: true,
                          height: 350.h,
                        ),
                        items: <Widget>[
                          ...indAlcance.map(
                            (alcance) {
                              return cardCarousel3(
                                alcance['descripcionIndicadorAlcance'],
                                alcance['unidadMedida'],
                                alcance['cantidadProgramada'],
                                alcance['cantidadEjecutada'],
                                alcance['porcentajeAvance'],
                                alcance['txtEjecucionIndicadorAlcance'],
                                (value) {
                                  if (double.parse('$value') < 0) {
                                    Toast.show(
                                        "Lo sentimos, solo aceptamos numeros positivos",
                                        context,
                                        duration: 3,
                                        gravity: Toast.BOTTOM);
                                  }
                                  alcance['txtEjecucionIndicadorAlcance'] =
                                      value;
                                  var cantidadEjecutadaInicial =
                                      alcance['cantidadEjecutadaInicial'];
                                  alcance['cantidadEjecutada'] = double.parse(
                                          '$cantidadEjecutadaInicial') +
                                      double.parse('$value');
                                  var cantidadEjecutada =
                                      alcance['cantidadEjecutada'];
                                  var cantidadProgramada =
                                      alcance['cantidadProgramada'];
                                  alcance['porcentajeAvance'] =
                                      double.parse('$cantidadEjecutada') /
                                          double.parse('$cantidadProgramada') *
                                          100;
                                },
                              );
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                    RendimientoCard(

                        //* quitar el simbolo de la moneda y punto decimal
                        //* if (!isDate) {
                        //*   var valueWithoutSymbol = value.replaceAll('\COP', '');
                        //*   var valueWithoutSymbolAndDecimal =
                        //*       valueWithoutSymbol.replaceAll('.', '');
                        //*   var valueWithoutSymbolAndDecimalAndComma =
                        //*       valueWithoutSymbolAndDecimal.replaceAll(',', '.');
                        //*   print(valueWithoutSymbolAndDecimalAndComma);
                        //* }
                        //***************************************************/
                        fechaReintegroController: fechaReintegroController,
                        valorGeneradoController: valorGeneradoController,
                        valorMesActualController: valorMesActualController,
                        valorMesVencidoController: valorMesVencidoController,
                        onFechaReintegroTap: () async {
                          await showDatePicker(
                            context: context,
                            locale: const Locale('es', 'CO'),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  colorScheme:
                                      const ColorScheme.light().copyWith(
                                    primary: ColorTheme.primaryTint,
                                  ),
                                ),
                                child: child,
                              );
                            },
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          ).then((date) {
                            if (date == null) return;
                            String fecha = date.toString().split(' ')[0];
                            List<String> fechaSplit = fecha.split('-');
                            String fechaFormateada =
                                '${fechaSplit[2]}/${fechaSplit[1]}/${fechaSplit[0]}';
                            fechaReintegroController.text = fechaFormateada;
                          });
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
