import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/models.dart';
import '../../../../theme/color_theme.dart';
import 'package:toast/toast.dart';

class RangeIndicatorCard extends StatefulWidget {
  const RangeIndicatorCard({
    Key? key,
    required this.valueSaved,
    required this.item,
    required this.inputValue,
    required this.onChanged,
  }) : super(key: key);

  final String valueSaved;
  final IndicadoresDeAlcance item;
  final String inputValue;
  final void Function(int, String) onChanged;

  @override
  State<RangeIndicatorCard> createState() => _RangeIndicatorCardState();
}

class _RangeIndicatorCardState extends State<RangeIndicatorCard> {
  late TextEditingController controller;

  late final double quantityExecuted;
  late final double scheduledQuantity;

  double? _newquantityExecuted;

  double get newQuantityExecuted =>
      _newquantityExecuted ?? widget.item.cantidadEjecutada;

  set newQuantityExecuted(double value) {
    _newquantityExecuted = widget.item.cantidadEjecutada + value;
    newPercentageOfCompletion = newPercentageOfCompletion;
  }

  double? _newPercentageOfCompletion;

  double get newPercentageOfCompletion =>
      (_newPercentageOfCompletion ?? widget.item.porcentajeAvance);

  set newPercentageOfCompletion(double value) {
    if (newQuantityExecuted == 0) {
      _newPercentageOfCompletion = 0;
      return;
    }
    if (widget.item.cantidadProgramada == 0) {
      _newPercentageOfCompletion = 0;
      return;
    }
    if (newQuantityExecuted == 0 && widget.item.cantidadProgramada == 0) {
      _newPercentageOfCompletion = 0;
      return;
    }
    _newPercentageOfCompletion =
        (newQuantityExecuted / widget.item.cantidadProgramada) * 100;
  }

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
        text: widget.valueSaved == '0' ? '' : widget.valueSaved);

    quantityExecuted = widget.item.cantidadEjecutada;
    scheduledQuantity = widget.item.cantidadProgramada;
    newQuantityExecuted = double.parse(widget.valueSaved);

    calculate(widget.valueSaved);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat f = new NumberFormat("#,##0.00", "en_US");

    ToastContext().init(context);

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
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          Text(widget.item.descripcionIndicadorAlcance,
              style: const TextStyle(
                fontSize: 12.18,
                color: Colors.white,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center),
          const SizedBox(height: 16.84),
          const Text(
            'Ingresa la ejecucion',
            style: TextStyle(
              fontSize: 12.18,
              color: Colors.white,
              fontFamily: 'montserrat',
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
                          decimal: true, signed: true),
                      controller: controller,
                      onChanged: calculate,
                      inputFormatters: <FilteringTextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d{1,9})((\.?)+((\d{1,2})?))'),
                        )
                      ],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      decoration: const InputDecoration.collapsed(
                        hintText: "0",
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
          const SizedBox(height: 50.88),
          Column(
            children: <Widget>[
              Celdas(
                txtIzquierda: 'Unidad de medida',
                txtDerecha: widget.item.unidadMedida,
                negrita: false,
              ),
              Celdas(
                txtIzquierda: 'Unidad de medida',
                txtDerecha: widget.item.unidadMedida,
                negrita: true,
              ),
              Celdas(
                  txtIzquierda: 'Cantidad programada',
                  txtDerecha: f.format(
                      double.parse('${widget.item.cantidadProgramada}')),
                  negrita: true),
              Celdas(
                  txtIzquierda: 'Cantidad ejecutada',
                  txtDerecha: f.format(newQuantityExecuted),
                  negrita: true),
              Celdas(
                  txtIzquierda: 'Porcentaje de avance',
                  txtDerecha: PercentajeFormat.percentaje(
                      newPercentageOfCompletion,
                      precision: 2),
                  negrita: true),
            ],
          )
        ],
      ),
    );
  }

  void calculate(String valueString) {
    if (valueString.contains('-')) {
      Toast.show("Lo sentimos, solo puede ingresar números enteros",
          duration: 5, gravity: Toast.bottom);

      controller.text = controller.text.replaceAll(',', '');
      controller.text = controller.text.replaceAll('.', '');
      final val = TextSelection.collapsed(offset: controller.text.length);
      controller.selection = val;

      return;
    }

    if (valueString.contains('-')) {
      Toast.show("Lo sentimos, solo aceptamos numeros positivos",
          duration: 5, gravity: Toast.bottom);

      controller.text = controller.text.replaceAll('-', '');
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );

      return;
    }

    String value = valueString;
    value = valueString.trim() == '' ? '0' : valueString.trim();

    widget.onChanged(widget.item.indicadorAlcanceId, value.toString());
    newQuantityExecuted = double.parse(value);
  }
}

class Celdas extends StatelessWidget {
  const Celdas({
    Key? key,
    required this.txtIzquierda,
    required this.txtDerecha,
    required this.negrita,
  }) : super(key: key);

  final String txtIzquierda;
  final String txtDerecha;
  final bool negrita;

  @override
  Widget build(BuildContext context) {
    FontWeight fontWeight = FontWeight.w200;
    if (negrita == true) {
      fontWeight = FontWeight.w600;
    }
    return Container(
      padding:
          const EdgeInsets.only(bottom: 5.0, top: 5.0, left: 5.0, right: 5.0),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.3, color: Colors.white),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text(txtIzquierda,
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: fontWeight,
                    fontSize: 10,
                    color: Colors.white)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              txtDerecha,
              style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: fontWeight,
                  fontSize: 10,
                  color: Colors.white),
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
