import 'package:appalimentacion/globales/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final titleColor = Color(0xff384C68);

class SeleccionarAvance extends StatefulWidget {
  SeleccionarAvance({Key key}) : super(key: key);

  @override
  _SeleccionarAvanceState createState() => _SeleccionarAvanceState();
}

class _SeleccionarAvanceState extends State<SeleccionarAvance> {
  String textoSeleccionado = contenidoWebService[0]['proyectos']
          [posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'][0]
      ['descripcionAspectoEvaluar'];

  List<String> valoresSelect = [];
  // int aspectoEvaluarId = contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'][0]['aspectoEvaluarId'];
  List valores = contenidoWebService[0]['proyectos']
      [posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'];
  // contenidoWebService[0]['proyectos'][posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'];

  @override
  void initState() {
    for (int cont = 0; cont < valores.length; cont++) {
      valoresSelect.add(valores[cont]['descripcionAspectoEvaluar']);
    }
    idAspectoEvaluar = contenidoWebService[0]['proyectos']
            [posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'][0]
        ['aspectoEvaluarId'];
    txtBtnDesplegableAvanceCualitativo = contenidoWebService[0]['proyectos']
            [posicionListaProyectosSeleccionado]['datos']['apectosEvaluar'][0]
        ['descripcionAspectoEvaluar'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 43.sp,
        margin: EdgeInsets.only(top: 10.0),
        
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: <Widget>[
            SizedBox(width: 16.57.sp),
            Container(
              child: iconoCorrespondiente(textoSeleccionado),
            ),
            SizedBox(width: 9.47.sp),
            Expanded(
                child: DropdownButtonHideUnderline(
              child: DropdownButton(
                iconSize: 15.74.sp ,
                hint: Text(
                  '$textoSeleccionado',
                  style: TextStyle(
                    fontFamily: "montserrat",
                    fontSize: 11.22.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff384C68),
                  ),
                ),
                items: valoresSelect
                    .map((value) => DropdownMenuItem(
                          child: Row(
                            children: <Widget>[
                              iconoCorrespondiente(value),
                               SizedBox(width: 9.47.sp),
                              Text(
                                value,
                                style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontSize: 11.22.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff384C68),
                                ),
                              ),
                            ],
                          ),
                          value: value,
                        ))
                    .toList(),
                onChanged: (String value) {
                  setState(() {
                    for (int cont = 0; cont < valores.length; cont++) {
                      if (valores[cont]['descripcionAspectoEvaluar'] == value) {
                        idAspectoEvaluar = valores[cont]['aspectoEvaluarId'];
                        break;
                      }
                    }
                    textoSeleccionado = value;
                    txtBtnDesplegableAvanceCualitativo = value;
                  });
                },
              ),
            ))
          ],
        ));
  }

  Widget iconoCorrespondiente(texto) {
    if (texto == 'Administrativo')
      return Image(
        image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-1.png'),
        width: 24.sp,
        height: 24.sp,
      );
    if (texto == 'Financiero')
      return Image(
        image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-2.png'),
        width: 24.sp,
        height: 24.sp,
      );
    if (texto == 'Técnico')
      return Image(
        image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-3.png'),
        width: 24.sp,
        height: 24.sp,
      );
    if (texto == 'Jurídico')
      return Image(
        image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-4.png'),
        width: 24.sp,
        height: 24.sp,
      );
    if (texto == 'Social')
      return Image(
        image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-5.png'),
        width: 24.sp,
        height: 24.sp,
      );
  }
}
