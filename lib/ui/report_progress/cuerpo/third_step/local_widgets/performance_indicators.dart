import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/report_progress/report_progress_provider.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final date = DateTime.now();

final style = const TextStyle(
  color: Color(0xff556A8D),
  fontSize: 15,
  fontFamily: "montserrat",
  fontWeight: FontWeight.w500,
);

class PerformanceIndicators extends StatefulWidget {
  const PerformanceIndicators({Key? key}) : super(key: key);

  @override
  State<PerformanceIndicators> createState() => _PerformanceIndicatorsState();
}

class _PerformanceIndicatorsState extends State<PerformanceIndicators> {
  late ReportProgressProvider reportProgressService;

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();
  TextEditingController controller5 = TextEditingController();

  FocusNode incomeGenerationDateFocusNode = FocusNode();
  FocusNode rentalRepaymentDateFocusNode = FocusNode();
  FocusNode generatedReturnsFocusNode = FocusNode();
  FocusNode currentMonthReturnsFocusNode = FocusNode();
  FocusNode pastDueMonthReturnsFocusNode = FocusNode();

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    controller4.dispose();
    controller5.dispose();

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
    reportProgressService = context.read<ReportProgressProvider>();
    if (reportProgressService.incomeGenerationDate != null) {
      controller1.text =
          DateTimeFormat.ddMMYYYY(reportProgressService.incomeGenerationDate!);
    }

    if (reportProgressService.rentalRepaymentDate != null) {
      controller2.text =
          DateTimeFormat.ddMMYYYY(reportProgressService.rentalRepaymentDate!);
    }

    if (reportProgressService.generatedReturns != null) {
      controller3.text = reportProgressService.generatedReturns == 0.0
          ? ''
          : CurrencyFormatterHelper.format(
              reportProgressService.generatedReturns);
    }

    if (reportProgressService.valorReintegroRendimientos != null) {
      controller4.text = reportProgressService.valorReintegroRendimientos == 0.0
          ? ''
          : CurrencyFormatterHelper.format(
              reportProgressService.valorReintegroRendimientos!);
    }

    if (reportProgressService.valorSaldoFinalExtracto != null) {
      controller5.text = reportProgressService.valorSaldoFinalExtracto == 0.0
          ? ''
          : CurrencyFormatterHelper.format(
              reportProgressService.valorSaldoFinalExtracto!);
    }
  }

  _initListeners() {
    controller3.addListener(() {
      final value = ProjectHelpers.getDoubleValue(controller3.text);
      reportProgressService.saveGeneratedReturns(value);
    });

    controller4.addListener(() {
      final value = ProjectHelpers.getDoubleValue(controller4.text);
      reportProgressService.saveValorReintegroRendimientos(value);
    });

    controller5.addListener(() {
      final value = ProjectHelpers.getDoubleValue(controller5.text);
      reportProgressService.saveValorSaldoFinalExtracto(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO User other picker for ios
    Future<DateTime?> selectDate({DateTime? initialDate}) async {
      return showDatePicker(
        context: context,
        locale: const Locale('es', 'CO'),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: ColorTheme.primaryTint,
              ),
            ),
            child: child!,
          );
        },
        initialDate: initialDate ?? DateTime.now(),
        // TODO
        firstDate: DateTime(2000),
        // TODO
        lastDate: DateTime(2101),
      ).then<DateTime?>((date) {
        if (date == null) return null;
        print(date.toIso8601String());
        return date;
      });
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 38, left: 20, right: 20),
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ingresa los indicadores de rendimientos del proyecto (SI APLICA)',
            style: style.copyWith(fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 15),
          Text.rich(
            TextSpan(
                text: 'Mes y Vigencia a Reportar: ',
                style: style.copyWith(fontSize: 14),
                children: <InlineSpan>[
                  TextSpan(
                    text: DateTimeFormat.mmmmYYYY(reportProgressService
                            .periodoSeleccionado.getFechaIniDateTime)
                        .toUpperCase(),
                    style: style.copyWith(
                        fontWeight: FontWeight.w400, fontSize: 14),
                  )
                ]),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IndicatorField(
                  'Fecha de Generación de Rendimientos',
                  assetIcon: 'assets/img/paso3-icon1.png',
                  hintText: 'DD-MM-YYYY',
                  focusNode: incomeGenerationDateFocusNode,
                  controller: controller1,
                  onTap: () async {
                    final dateTime = await selectDate(
                      initialDate: reportProgressService.incomeGenerationDate,
                    );
                    if (dateTime == null) return;

                    controller1.text = DateTimeFormat.ddMMYYYY(dateTime);
                    reportProgressService.saveIncomeGenerationDate(dateTime);
                  },
                  enabled: false,
                ),
                const SizedBox(height: 10),
                IndicatorField(
                  'Fecha de Reintegro de Rendimientos',
                  assetIcon: 'assets/img/paso3-icon1.png',
                  hintText: 'DD-MM-YYYY',
                  focusNode: rentalRepaymentDateFocusNode,
                  controller: controller2,
                  onTap: () async {
                    final dateTime = await selectDate(
                      initialDate: reportProgressService.rentalRepaymentDate,
                    );
                    if (dateTime == null) return;
                    controller2.text = DateTimeFormat.ddMMYYYY(dateTime);
                    reportProgressService.saveRentalRepaymentDate(dateTime);
                  },
                  enabled: false,
                ),
                const SizedBox(height: 10),
                IndicatorField('Valor Rendimientos Generados',
                    assetIcon: 'assets/img/paso3-icon2.png',
                    focusNode: generatedReturnsFocusNode,
                    controller: controller3, onTap: () {
                  generatedReturnsFocusNode.requestFocus();
                }),
                const SizedBox(height: 10),
                IndicatorField(
                  'Valor Reintegrado',
                  assetIcon: 'assets/img/paso3-icon3.png',
                  focusNode: currentMonthReturnsFocusNode,
                  controller: controller4,
                  onTap: () {
                    currentMonthReturnsFocusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 10),
                IndicatorField(
                  'Saldo Final en Extracto',
                  assetIcon: 'assets/img/paso3-icon3.png',
                  focusNode: pastDueMonthReturnsFocusNode,
                  controller: controller5,
                  onTap: () {
                    pastDueMonthReturnsFocusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 10),
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
    Key? key,
    this.icon,
    this.assetIcon,
    this.hintText = '\$ 0.00',
    required this.onTap,
    required this.focusNode,
    required this.controller,
    this.enabled = true,
  })  : assert(assetIcon != null || icon != null),
        super(key: key);

  final String title;
  final IconData? icon;
  final String? assetIcon;
  final String hintText;
  final void Function()? onTap;
  final FocusNode focusNode;
  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Row(
              children: [
                const SizedBox(width: 10),
                if (assetIcon != null)
                  Image.asset(assetIcon!, width: 25, height: 25)
                else
                  Icon(
                    icon,
                    size: 23,
                    color: const Color(0xff556A8D),
                  ),
                const SizedBox(width: 10),
                Flexible(
                  fit: FlexFit.tight,
                  child: Text(
                    title,
                    style: style.copyWith(fontSize: 13),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 43),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                enabled: enabled,
                textAlign: TextAlign.center,
                style: style.copyWith(
                    fontSize: 13, fontWeight: FontWeight.w400),
                inputFormatters: [
                  if (enabled)
                    CurrencyTextInputFormatter(
                      locale: 'en_US',
                      symbol: '\$ ',
                      decimalDigits: 2,
                    ),
                ],
                maxLength: 26,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  hintStyle: style.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                  counterText: '',
                ),
                focusNode: focusNode,
                controller: controller,
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
