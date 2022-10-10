import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/utils/assets/assets.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';

class RendimientoCard extends StatefulWidget {
  const RendimientoCard({
    Key key,
    @required this.onFechaReintegroTap,
  }) : super(key: key);
  final void Function() onFechaReintegroTap;

  @override
  State<RendimientoCard> createState() => _RendimientoCardState();
}

class _RendimientoCardState extends State<RendimientoCard> {
  TextEditingController fechaReintegroController;
  TextEditingController valorGeneradoController;
  TextEditingController valorMesActualController;
  TextEditingController valorMesVencidoController;

  @override
  void initState() {
    super.initState();
    fechaReintegroController = TextEditingController();
    valorGeneradoController = TextEditingController();
    valorMesActualController = TextEditingController();
    valorMesVencidoController = TextEditingController();
  }

  @override
  void dispose() {
    fechaReintegroController.dispose();
    valorGeneradoController.dispose();
    valorMesActualController.dispose();
    valorMesVencidoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var valorRendimientosString = 'Valor de Rendimientos';
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
        right: 15.sp,
        top: 30.64.sp,
        bottom: 38.95.sp,
      ),
      margin: EdgeInsets.only(bottom: 38.sp, left: 20.sp, right: 20.sp),
      child: Column(
        children: [
          _Field(
            title: 'Fecha de Reintegro de Rendimento',
            isDate: true,
            controller: fechaReintegroController,
            onTap: widget.onFechaReintegroTap,
          ),
          _Field(
            title: '$valorRendimientosString Generados',
            controller: valorGeneradoController,
          ),
          _Field(
            title: '$valorRendimientosString Mes Actual',
            controller: valorMesActualController,
          ),
          _Field(
            title: '$valorRendimientosString Mes Vencido',
            controller: valorMesVencidoController,
          ),
        ],
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    Key key,
    @required this.title,
    this.controller,
    this.isDate = false,
    this.onTap,
  }) : super(key: key);
  final String title;
  final TextEditingController controller;
  final bool isDate;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.sp),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              '$title:',
              style: AppTheme.parrafoBlancoNegrita,
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.sp),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(1, 1, 1, 0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                //if !isDate show textfield with coin format
                child: TextField(
                  enabled: !isDate,
                  controller: controller,
                  style: AppTheme.parrafoBlanco,
                  inputFormatters: [
                    if (!isDate)
                      CurrencyTextInputFormatter(
                        locale: 'es_CO',
                        symbol: '\COP',
                        decimalDigits: 2,
                      ),
                  ],
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: !isDate ? '0' : '',
                    hintStyle: AppTheme.parrafoBlanco,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(left: 10.sp),
              width: 25.sp,
              child: Visibility(
                visible: isDate,
                child: Image.asset(
                  Assets.assetsNewHomeDatepickerIcon,
                  height: 25.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyInputFormatter {}
