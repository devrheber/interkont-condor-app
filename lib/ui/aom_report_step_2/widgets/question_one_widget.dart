import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'yes_no_purple_widget.dart';

class QuestionOne extends StatefulWidget {
  const QuestionOne({
    Key? key,
    required this.monthsInitialValue,
    required this.initialValue,
    required this.onChangedAnswer,
    required this.onChangedReason,
    required this.onChangedMonths,
  }) : super(key: key);

  final String monthsInitialValue;
  final int initialValue;
  final Function(int value) onChangedAnswer;
  final Function(String) onChangedReason;
  final Function(String) onChangedMonths;

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController _reasonController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _textController.text = widget.monthsInitialValue;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            '1. ¿Está de acuerdo con el valor de vida remanente del activo?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: ColorTheme.darkShade,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        YesNoPurple(
          initialValue: widget.initialValue,
          onChanged: (int? value) {
            if (value == null) return;
            widget.onChangedAnswer(value);
          },
        ),
        Visibility(
          visible: widget.initialValue == 0,
          child: Column(
            children: <Widget>[
              //ROUNDED CONTAINER WITH SHADOW
              Container(
                constraints: const BoxConstraints(maxWidth: 340, minHeight: 129),
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(102, 102, 102, 0.26),
                      blurRadius: 14,
                      spreadRadius: 0,
                      offset: Offset(4, 10),
                    ),
                  ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    tileMode: TileMode.mirror,
                    colors: <Color>[
                      Colors.white,
                      Colors.white,
                    ],
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Text(
                      'Explique por qué considera diferente el valor de vida remanente:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF836FF8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    //texfield max char 250
                    TextField(
                      maxLines: 3,
                      maxLength: 250,
                      decoration: const InputDecoration(
                        counterText: '',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF556A8D),
                        ),
                        //no border
                        border: InputBorder.none,
                      ),
                      controller: _reasonController,
                      onChanged: (String? value) {
                        if (value == null) return;
                        widget.onChangedReason(value);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    const Text(
                      '¿Cuál es la vida útil que usted considera para el activo (En meses)?',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF384C68),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //numeric textfield

                    Center(
                      child: Container(
                        width: 126,
                        margin: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF666666).withOpacity(.26),
                              blurRadius: 14,
                              spreadRadius: 1,
                              offset: const Offset(4, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _textController,
                          //make texfield text center

                          textAlign: TextAlign.center,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          //only numbers
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d{0,5})'),
                            ),
                          ],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorTheme.darkShade,
                          ),
                          decoration: const InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: ColorTheme.darkShade,
                            ),
                            //no border
                            border: InputBorder.none,
                          ),
                          onChanged: (String? value) {
                            if (value == null) return;
                            widget.onChangedMonths(value);
                          },
                        ),
                      ),
                    ),
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
