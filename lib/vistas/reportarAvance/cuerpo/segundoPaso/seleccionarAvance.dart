import 'package:appalimentacion/globales/colores.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


final titleColor = Color(0xff444444);

Widget seleccionarAvance(context)
{
  String textoSeleccionado = 'asd';
  List<String> _dropdownValues = [
    "Administrativo",
    "Agricultura",
    "Contabilidad",
    "Negocio",
    "Otros"
  ]; 
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
          child: Icon(
            FontAwesomeIcons.solidFolderOpen,
            size: 20,
          ),
        ),
        Expanded(
          child: DropdownButtonHideUnderline(
            
            child: DropdownButton(
              hint: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Administrativo',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppTheme.darkText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              items: _dropdownValues
                      .map((value) => DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          ))
                      .toList(),
              onChanged: (String value) {
                // textoSeleccionado = value;
              },
              // value: "textoSeleccionado",
            ),
          )
        )
      ],
    )
  );
}