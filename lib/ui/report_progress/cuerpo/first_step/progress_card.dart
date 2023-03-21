import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

import '../../../../domain/models/models.dart';
import '../../../../theme/color_theme.dart';

class ProgressCard extends StatefulWidget {
  const ProgressCard({
    Key? key,
    required this.valueSaved,
    required this.activity,
    required this.onChanged,
  }) : super(key: key);

  final String valueSaved;
  final Actividad activity;
  final Function(String) onChanged;

  String get getValue => (double.tryParse(valueSaved) ?? 0).toStringAsFixed(2);

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.valueSaved == '0' ? '' : widget.valueSaved);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    void calcutate(String stringValue) {
      // print(stringValue);
      // return;

      if (stringValue.contains(',')) {
        Toast.show('Para la parte decimal debe usar el caracter "." (punto)',
            duration: 6, gravity: Toast.bottom);
        controller.text = controller.text.replaceAll(',', '');
        final val = TextSelection.collapsed(offset: controller.text.length);
        controller.selection = val;
      }

      String value = stringValue == '' ? '0' : stringValue;
      value = value.replaceAll(',', '');

      final ejecutadoActual = widget.activity.getCurrentProgressDouble;

      if ((ejecutadoActual + double.parse(value)) > 100) {
        controller.text = '';
        final val = TextSelection.collapsed(offset: controller.text.length);
        controller.selection = val;

        Toast.show('Ejecución Actual está al 100%',
            duration: 5, gravity: Toast.bottom);
        widget.onChanged('0');
        return;
      }

      if (double.parse('$value') < 0) {
        Toast.show("Lo sentimos, solo aceptamos numeros positivos",
            duration: 3, gravity: Toast.bottom);
        widget.onChanged('0');
        return;
      }
      if (double.parse('$value') > 100) {
        Toast.show(
            "El valor ejecutado de la actividad no puede superar el 100%",
            duration: 3,
            gravity: Toast.bottom);
        widget.onChanged('0');
        return;
      }

      widget.onChanged(value);
    }

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: const Color(0xff666666).withOpacity(0.26),
              blurRadius: 14,
              spreadRadius: 0.4,
              offset: const Offset(4, 10)),
        ],
        borderRadius: BorderRadius.circular(16.13),
        gradient: ColorTheme.cardGradient,
      ),
      padding: const EdgeInsets.only(
        left: 38.46,
        right: 37.42,
        top: 30.64,
        bottom: 38.95,
      ),
      margin: const EdgeInsets.only(bottom: 38),
      child: Column(
        children: <Widget>[
          Text(widget.activity.descripcionActividad,
              style: const TextStyle(
                fontSize: 12.1796,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'montserrat',
              ),
              textAlign: TextAlign.center),
          const SizedBox(height: 16.93),
          const Text(
            'Ingresa el % de avance para el presente reporte',
            style: TextStyle(
              fontSize: 12.18,
              color: Colors.white,
              fontFamily: "montserrat",
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 9.68),
          Container(
            height: 41.13,
            width: 177.4,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12.0957),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 12.1,
                  spreadRadius: 0,
                  offset: const Offset(2.42, 3.12),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                      textInputAction: TextInputAction.send,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      inputFormatters: <FilteringTextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^((100)|(\d{1,2})((\.?)+((\d{1,2})?)))'),
                        ),
                      ],
                      controller: controller,
                      onChanged: calcutate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: "0.0",
                        hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xffE3E3E3),
                            fontFamily: 'montserrat',
                            fontWeight: FontWeight.bold),
                      )),
                )
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: <Widget>[
              _Celdas(
                label: 'Ejecutado Actual',
                value: widget.activity.ejecutadoActual,
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Avance del presente reporte',
                value: '${widget.getValue} %',
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Avance a hoy',
                value: widget.activity
                    .avanceAHoy(double.tryParse(widget.valueSaved) ?? 0.0),
                isNumericVariable: false,
              ),
              _Celdas(
                label: 'Faltante por ejecutar',
                value: widget.activity.faltantePorEjecutar(
                    double.tryParse(widget.valueSaved) ?? 0.0),
                isNumericVariable: false,
              ),
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}

class _Celdas extends StatelessWidget {
  const _Celdas({
    Key? key,
    required this.label,
    required this.value,
    this.bold = false,
    this.isNumericVariable = true,
  }) : super(key: key);
  final String label;
  final String value;
  final bool bold;
  final bool isNumericVariable;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = bold ? FontWeight.w700 : FontWeight.w300;
    String newValue = value;
    if (isNumericVariable) {
      NumberFormat nFormatOneDecimal = NumberFormat("#,##0.0", "en_US");
      NumberFormat nFormatTwoDecimal = NumberFormat("#,##0.00", "en_US");

      List<String> valueSplitted = value.split(" ");

      if (valueSplitted.length > 1) {
        //SI AL FINAL TIENE EL SIMBOLO %
        if (valueSplitted[1] == '%') {
          newValue = nFormatOneDecimal.format(double.parse(valueSplitted[0])) +
              " " +
              valueSplitted[1];
        } else {
          newValue = valueSplitted[0] +
              " " +
              nFormatTwoDecimal.format(double.parse(valueSplitted[1]));
        }
      } else {
        newValue = nFormatOneDecimal.format(double.parse(valueSplitted[0]));
      }
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 3.9, top: 5.3),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.2, color: Colors.white),
          top: BorderSide(width: 0.2, color: Colors.white),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: fontWeight,
                fontSize: 12.18,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Text(
              newValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'montserrat',
                fontWeight: fontWeight,
                fontSize: 12.18,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
