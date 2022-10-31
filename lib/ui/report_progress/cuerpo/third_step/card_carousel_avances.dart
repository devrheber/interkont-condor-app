import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
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
    NumberFormat f = new NumberFormat("#,##0.0", "en_US");

    ToastContext().init(context);

    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff666666).withOpacity(0.26),
              blurRadius: 14.sp,
              spreadRadius: 0.4.sp,
              offset: Offset(4.sp, 10.sp)),
        ],
        borderRadius: BorderRadius.circular(16.13.sp),
        gradient: ColorTheme.cardGradient,
      ),
      padding: EdgeInsets.only(
        left: 38.46.sp,
        right: 37.42.sp,
        top: 30.64.sp,
        bottom: 38.95.sp,
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Text(widget.item.descripcionIndicadorAlcance,
              style: TextStyle(
                fontSize: 12.18.sp,
                color: Colors.white,
                fontFamily: 'montserrat',
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center),
          SizedBox(height: 16.84.sp),
          Text(
            'Ingresa la ejecucion',
            style: TextStyle(
              fontSize: 12.18.sp,
              color: Colors.white,
              fontFamily: 'montserrat',
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 9.68.sp),
          Container(
            height: 41.13.sp,
            width: 177.4.sp,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              borderRadius: BorderRadius.circular(12.0957.sp),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 12.1.sp,
                  spreadRadius: 0,
                  offset: Offset(2.42.sp, 3.12.sp),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextField(
                      textInputAction: TextInputAction.send,
                      keyboardType: TextInputType.numberWithOptions(
                          decimal: true, signed: true),
                      controller: controller,
                      onChanged: calculate,
                      inputFormatters: <FilteringTextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)(\.?)(\,?)(\-?)'),
                        )
                      ],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration.collapsed(
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
          SizedBox(height: 50.88.sp),
          Column(
            children: <Widget>[
              celdas('Unidad de medida', widget.item.unidadMedida, false),
              celdas(
                  'Cantidad programada',
                  f.format(double.parse('${widget.item.cantidadProgramada}')),
                  false),
              celdas('Cantidad ejecutada', f.format(newQuantityExecuted), true),
              celdas(
                  'Porcentaje de avance',
                  PercentajeFormat.percentaje(newPercentageOfCompletion,
                      precision: 1),
                  true),
            ],
          )
        ],
      ),
    );
  }

  Widget celdas(txtIzquierda, txtDerecha, negrita) {
    FontWeight fontWeight = FontWeight.w200;
    if (negrita == true) {
      fontWeight = FontWeight.w600;
    }
    return Container(
      padding: EdgeInsets.only(bottom: 5.0, top: 5.0, left: 5.0, right: 5.0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.3, color: Colors.white),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Text('$txtIzquierda',
                style: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: fontWeight,
                    fontSize: 10,
                    color: Colors.white)),
          ),
          Expanded(
            flex: 1,
            child: Text(
              '$txtDerecha',
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

  void calculate(String valueString) {
    if (valueString.contains(',') || valueString.contains('.')) {
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
    double valueDouble = double.parse(value);

    double maxValueAllowed = scheduledQuantity - quantityExecuted;

    if (maxValueAllowed == 0) {
      return Toast.show(
          "Lo sentimos, Toda la cantidad programada fué ejecutada",
          duration: 6,
          gravity: Toast.bottom);
    }

    if (valueDouble > maxValueAllowed) {
      Toast.show("Lo sentimos, Cantidad máxima permitida es $maxValueAllowed",
          duration: 6, gravity: Toast.bottom);

      controller.text = '';
      controller.selection = TextSelection.collapsed(
        offset: controller.text.length,
      );

      widget.onChanged(widget.item.indicadorAlcanceId, '0');
      newQuantityExecuted = 0;
      return;
    }

    // print(value.toString() == '' ? '0' : value.toString());

    widget.onChanged(widget.item.indicadorAlcanceId, value.toString());
    newQuantityExecuted = double.parse(value);
  }
}
