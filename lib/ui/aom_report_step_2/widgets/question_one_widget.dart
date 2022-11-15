import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'yes_no_purple_widget.dart';

class QuestionOne extends StatefulWidget {
  const QuestionOne({
    Key? key,
    required this.monthsInitialValue,
  }) : super(key: key);

  final int monthsInitialValue;

  @override
  State<QuestionOne> createState() => _QuestionOneState();
}

class _QuestionOneState extends State<QuestionOne>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  int value = 1;

  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _textController =
        TextEditingController(text: widget.monthsInitialValue.toString());
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
        Center(
          child: Text(
            '1. ¿Está de acuerdo con el valor de vida remanente del activo?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: ColorTheme.darkShade,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        YesNoPurple(
          onChanged: (int? value) {
            print(value);
            if (value == null) return;
            setState(
              () => this.value = value,
            );
          },
        ),
        Visibility(
          visible: value == 0,
          child: Column(
            children: <Widget>[
              //ROUNDED CONTAINER WITH SHADOW
              Container(
                constraints:
                    BoxConstraints(maxWidth: 340.sp, minHeight: 129.sp),
                margin: EdgeInsets.only(
                  top: 20.sp,
                  left: 10.sp,
                  right: 10.sp,
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.r)),
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
                    Text(
                      'Explique por qué considera diferente el valor de vida remanente:',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF836FF8),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    //texfield max char 250
                    TextField(
                      maxLines: 3,
                      maxLength: 250,
                      decoration: InputDecoration(
                        counterText: '',
                        hintText:
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore',
                        hintStyle: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF556A8D),
                        ),
                        //no border
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 20.sp,
                  left: 10.sp,
                  right: 10.sp,
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                child: Column(
                  children: [
                    Text(
                      '¿Cuál es la vida útil que usted considera para el activo (En meses)?',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF384C68),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    //numeric textfield

                    Center(
                      child: Container(
                        width: 126.sp,
                        margin: EdgeInsets.symmetric(
                          vertical: 15.sp,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF666666).withOpacity(.26),
                              blurRadius: 14,
                              spreadRadius: 1,
                              offset: Offset(4, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _textController,
                          //make texfield text center

                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: false, signed: false),
                          //only numbers
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d{0,5})'),
                            ),
                          ],
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorTheme.darkShade,
                          ),
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              color: ColorTheme.darkShade,
                            ),
                            //no border
                            border: InputBorder.none,
                          ),
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
