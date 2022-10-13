import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final date = DateTime.now();

final style = TextStyle(
  color: Color(0xff556A8D),
  fontSize: 15.sp,
  fontFamily: "montserrat",
  fontWeight: FontWeight.w500,
);

class PerformanceIndicators extends StatefulWidget {
  const PerformanceIndicators({Key key}) : super(key: key);

  @override
  State<PerformanceIndicators> createState() => _PerformanceIndicatorsState();
}

class _PerformanceIndicatorsState extends State<PerformanceIndicators> {
  ReportarAvanceProvider reportProgressService;

  TextEditingController incomeGenerationDateCtrl = TextEditingController();
  TextEditingController rentalRepaymentDateCtrl = TextEditingController();
  TextEditingController generatedReturnsCtrl = TextEditingController();
  TextEditingController currentMonthReturnsCtrl = TextEditingController();
  TextEditingController pastDueMonthReturnsCtrl = TextEditingController();

  FocusNode incomeGenerationDateFocusNode = FocusNode();
  FocusNode rentalRepaymentDateFocusNode = FocusNode();
  FocusNode generatedReturnsFocusNode = FocusNode();
  FocusNode currentMonthReturnsFocusNode = FocusNode();
  FocusNode pastDueMonthReturnsFocusNode = FocusNode();

  @override
  void dispose() {
    incomeGenerationDateCtrl.dispose();
    rentalRepaymentDateCtrl.dispose();
    generatedReturnsCtrl.dispose();
    currentMonthReturnsCtrl.dispose();
    pastDueMonthReturnsCtrl.dispose();

    incomeGenerationDateFocusNode.dispose();
    rentalRepaymentDateFocusNode.dispose();
    generatedReturnsFocusNode.dispose();
    currentMonthReturnsFocusNode.dispose();
    pastDueMonthReturnsFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _initListeners();
    super.initState();
    reportProgressService = context.read<ReportarAvanceProvider>();
  }

  _initListeners() {
    generatedReturnsCtrl.addListener(() {
      reportProgressService.savePerformanceIndicator(generatedReturnsCtrl.text);
    });

    currentMonthReturnsCtrl.addListener(() {
      reportProgressService.savePerformanceIndicator(currentMonthReturnsCtrl.text);
    });

    pastDueMonthReturnsCtrl.addListener(() {
      reportProgressService.savePerformanceIndicator(pastDueMonthReturnsCtrl.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO User other picker for ios
    Future<String> selectDate() async {
      return showDatePicker(
        context: context,
        locale: const Locale('es', 'CO'),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: ColorTheme.primaryTint,
              ),
            ),
            child: child,
          );
        },
        initialDate: DateTime.now(),
        // TODO
        firstDate: DateTime(2000),
        // TODO
        lastDate: DateTime(2101),
      ).then<String>((date) {
        if (date == null) return null;
        String fecha = date.toString().split(' ')[0];
        List<String> fechaSplit = fecha.split('-');
        String fechaFormateada =
            '${fechaSplit[2]}-${fechaSplit[1]}-${fechaSplit[0]}';
        return fechaFormateada;
      });
    }

    return Container(
      margin: EdgeInsets.only(bottom: 38.sp, left: 20.sp, right: 20.sp),
      padding: EdgeInsets.symmetric(horizontal: 7.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingresa los indicadores de rendimientos del proyecto (SI APLICA)',
            style: style.copyWith(fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 15.sp),
          Text.rich(
            TextSpan(
                text: 'Mes y Vigencia a Reportar: ',
                style: style.copyWith(fontSize: 14.sp),
                children: <InlineSpan>[
                  TextSpan(
                    text: DateTimeFormat.mmmmYYYY(date).toUpperCase(),
                    style: style.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14.sp),
                  )
                ]),
          ),
          SizedBox(height: 15.sp),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Column(
              children: [
                IndicatorField(
                  'Fecha de Generación de Rendimientos',
                  icon: Icons.watch_later_outlined,
                  hintText: 'DD-MM-YYYY',
                  focusNode: incomeGenerationDateFocusNode,
                  controller: incomeGenerationDateCtrl,
                  onTap: () async {
                    incomeGenerationDateCtrl.text = await selectDate();
                  },
                  enabled: false,
                ),
                SizedBox(height: 10.sp),
                IndicatorField(
                  'Fecha de Reintegro de Rendimientos',
                  icon: Icons.watch_later_outlined,
                  hintText: 'DD-MM-YYYY',
                  focusNode: rentalRepaymentDateFocusNode,
                  controller: rentalRepaymentDateCtrl,
                  onTap: () async {
                    rentalRepaymentDateCtrl.text = await selectDate();
                  },
                  enabled: false,
                ),
                SizedBox(height: 10.sp),
                IndicatorField('Valor de Rendimientos Generados',
                    icon: Icons.monetization_on_outlined,
                    focusNode: generatedReturnsFocusNode,
                    controller: generatedReturnsCtrl, onTap: () {
                  generatedReturnsFocusNode.requestFocus();
                }),
                SizedBox(height: 10.sp),
                IndicatorField(
                  'Valor de Rendimientos Mes Actual',
                  icon: Icons.monetization_on_outlined,
                  focusNode: currentMonthReturnsFocusNode,
                  controller: currentMonthReturnsCtrl,
                  onTap: () {
                    currentMonthReturnsFocusNode.requestFocus();
                  },
                ),
                SizedBox(height: 10.sp),
                IndicatorField(
                  'Valor de Rendimientos Mes Vencido',
                  icon: Icons.monetization_on_outlined,
                  focusNode: pastDueMonthReturnsFocusNode,
                  controller: pastDueMonthReturnsCtrl,
                  onTap: () {
                    pastDueMonthReturnsFocusNode.requestFocus();
                  },
                ),
                SizedBox(height: 10.sp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IndicatorField extends StatelessWidget {
  const IndicatorField(
    this.title, {
    Key key,
    @required this.icon,
    this.hintText = '\$ 0.00',
    @required this.onTap,
    @required this.focusNode,
    @required this.controller,
    this.enabled = true,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final String hintText;
  final Function onTap;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: Colors.white,
        ),
        child: Column(
          children: [
            SizedBox(height: 10.sp),
            Row(
              children: [
                SizedBox(width: 10.sp),
                // TODO Use asset
                Icon(icon, size: 23.sp),
                SizedBox(width: 10.sp),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    title,
                    style: style.copyWith(fontSize: 13.sp),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 43.sp),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.sp),
              child: TextField(
                enabled: enabled,
                textAlign: TextAlign.center,
                style: style.copyWith(
                    fontSize: 13.sp, fontWeight: FontWeight.w400),
                inputFormatters: [
                  if (enabled)
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
                  hintText: hintText,
                  hintStyle: style.copyWith(
                      fontSize: 14.sp, fontWeight: FontWeight.w400),
                ),
                focusNode: focusNode,
                controller: controller,
                // TODO Set Max length and hide indicator
                onChanged: (String value) {
                  final val =
                      TextSelection.collapsed(offset: controller.text.length);
                  controller.selection = val;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
