import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


final titleColor = Color(0xff444444);
class SeleccionarAvance extends StatefulWidget {

  SeleccionarAvance({Key key}) : super(key: key);

  @override
  _SeleccionarAvanceState createState() => _SeleccionarAvanceState();
}

class _SeleccionarAvanceState extends State<SeleccionarAvance> {
  String textoSeleccionado = 'Administrativo';
  List<String> valoresSelect = [
    "Administrativo",
    "Financiero",
    "Técnico",
    "Jurídico",
    "Social"
  ]; 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50.0,
      margin: EdgeInsets.only(top:10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left:5.0, right:5.0),
            child: iconoCorrespondiente(textoSeleccionado),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              
              child: DropdownButton(
                hint: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '$textoSeleccionado',
                    style: AppTheme.parrafo
                  ),
                ),
                items: valoresSelect.map((value) => DropdownMenuItem(
                  child: Row(
                    children: <Widget>[
                      iconoCorrespondiente(value),
                      Text(
                        value,
                        style: AppTheme.parrafo
                      ),
                    ],
                  ),
                  value: value,
                )).toList(),
                onChanged: (String value) {
                  setState(() {
                    textoSeleccionado = value;
                  });
                },
                // value: "textoSeleccionado",
              ),
            )
          )
        ],
      )
    );
  }

  Widget iconoCorrespondiente(texto)
  {

    if(texto == 'Administrativo')
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-1.png'),
      width: 30.0,
    );
    if(texto == 'Financiero')
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-2.png'),
      width: 30.0,
    );
    if(texto == 'Técnico')
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-3.png'),
      width: 30.0,
    );
    if(texto == 'Jurídico')
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-4.png'),
      width: 30.0,
    );
    if(texto == 'Social')
    return Image(
      image: AssetImage('assets/img/Desglose/ReporteAvance/icn-al-5.png'),
      width: 30.0,
    );

  }

}